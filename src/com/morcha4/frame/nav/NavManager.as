package com.morcha4.frame.nav
{
	import avmplus.getQualifiedClassName;
	
	import com.morcha4.frame.PageFrame;
	import com.morcha4.frame.PageTransformManager;
	import com.morcha4.frame.menu.BaseMenu;
	import com.morcha4.frame.system.AdvancedEvent;
	import com.morcha4.frame.system.BasePage;
	import com.morcha4.util.Queue;
	import com.morcha4.util.XMLUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	import spark.primitives.Path;
	
	public class NavManager extends EventDispatcher
	{
		/**
		 * 系统导航事件,若为当前模块则自动转化为模块调用事件
		 */
		public static const MODULE_NAV:String="module_navigation";
		/**
		 * 系统导航事件,若为当前模块则自动转化为模块调用事件
		 */
		public static const MODULE_NEXT:String="module_navigation_next";
		/**
		 * 系统导航事件,若为当前模块则自动转化为模块调用事件
		 */
		public static const MODULE_PRE:String="module_navigation_pre";
		/**
		 * 模块调用事件，若模块还未创建，则提示或抛出异常。
		 */ 
		public static const MODULE_CALL:String="module_is_called";
		/**
		 * 目录使能事件，传递参数为当前情况下需要屏蔽的目录路径。
		 */ 
		public static const MODULE_DISABLE:String="module_disable";
		/**
		 * 目录使能事件，传递参数为当前情况下需要屏蔽的目录名字的数组。
		 */ 
		public static const MODULE_DISABLEBYNAME:String="module_disable_by_name";
		/**
		 * 导航锁定事件，锁定过程中不可进行导航。
		 */ 
		public static const NAV_LOCK:String="navigation_lock";
		/**
		 * 目录导航完成事件。
		 */ 
		public static const MENU_COMPLETE:String="menu_complete";
		/**
		 * 刷新当前页面事件。
		 */ 
		public static const MODULE_REFRESH:String="module_refresh";
		/**
		 * 处理目录系统的方法，根据menu参数设置各级目录的数据源，需要在适当的时刻调度处理完成事件。
		 */ 
		public var processMenu:Function=processMenuDeafult;
		
		public function NavManager(target:IEventDispatcher=null)
		{
			super(target);
			addListeners();
		}
		private static var _instance:NavManager;
		public static function getInstance():NavManager{
			if(!_instance){
				_instance=new NavManager();
			}
			return _instance;
		}
		
		public function get currentPath():String{
			return this.currPath;
		}
		/**
		 * 系统目录树
		 */ 
		public var menu:XML;
		/**
		 * 添加接口
		 */ 
		private function addListeners():void{
			this.addEventListener(MODULE_NAV,onModuleNav);
			this.addEventListener(MODULE_CALL,onModuleCall);
			this.addEventListener(MODULE_DISABLE,onModuleDisable);
			this.addEventListener(MODULE_DISABLEBYNAME,onEnableMenuByName);
			this.addEventListener(NAV_LOCK,onNavLock);
			this.addEventListener(MODULE_NEXT,nav2Next);
			this.addEventListener(MODULE_PRE,nav2Pre);
			this.addEventListener(MODULE_REFRESH,onModuleRefresh);
		}
		/**
		 * 等待导航堆栈
		 */ 
		private var waitForNavStack:Array=[];
		/**
		 * 当前模块路径
		 */ 
		private var currPath:String;
		/**
		 * 当前模块节点
		 */ 
		private var currNode:XML;
		/**
		 * 当前导航参数
		 */ 
		private var currParam:NavParam;
		private var oldParam:NavParam;
		private var isRefresh:Boolean = false;
		private function onModuleNav(e:AdvancedEvent):void{
			isRefresh = false;
			if(lock){
				waitForNavStack.push(e);
				return;
			}
			dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,true));
			if(e.data is NavParam){
				oldParam=currParam;
				this.currParam=e.data as NavParam;
				try{
					var node:XML;
					if(e.data.path){
						node=XMLUtil.getNodeByPath(menu.*,e.data.path.split("/"),"label",1);
					}else{
						node=e.data.node;
					}
					trace((e.data.path?e.data.path:"null")+"_"+(e.data.node?e.data.node.toXMLString():"null"));
					if(node.@["enable"]=="false"){
						Alert.show("路径不可达");
						dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,false));
						return;
					}
					if(e.data.path){
						navByPath(e.data.path);
					}else{
						navByNode(e.data.node);
					}
					if(e.data.isnew){
						navQueue.push(e);
					}
				}catch(er:Error){
					Alert.show("导航参数有误"+er.message);
					dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,false));
				}
			}
		}
		private function navByPath(path:String):void{
			if(path==""){
				Alert.show("导航路径为空");
				dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,false));
			}else if(currPath==path){
				dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,false));
				dispatchEvent(new AdvancedEvent(MODULE_CALL,false,false,oldParam));
				currParam=oldParam;
			}else{
				var node:XML=XMLUtil.getNodeByPath(menu.*,path.split("/"),"label",1,processNode);
//				Alert.show(node.toXMLString());
				currNode=node;
				currPath=path;
				currParam.node=node;
				this.addEventListener(MENU_COMPLETE,onMenuComplete);
				processMenu(menu);
			}
		}
		private function navByNode(node:XML):void{
			if(node==null){
				Alert.show("导航节点为空");
				dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,false));
			}else if(currNode==node){
				dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,false));
				dispatchEvent(new AdvancedEvent(MODULE_CALL,false,false,oldParam));
				currParam=oldParam;
			}else{
				var path:String=XMLUtil.getFullPath(node,"node","label","/",processNode);
				currNode=node;
				currPath=path;
				currParam.path=path;
				this.addEventListener(MENU_COMPLETE,onMenuComplete);
				processMenu(menu);
			}
		}
		private function processNode(l:XMLList,node:XML):void{
			XMLUtil.getNodeByAttribute(l,"select","true").@["select"]="false";
			node.@["select"]="true";
		}
		private function onModuleCall(e:AdvancedEvent):void{
			var page:BasePage=PageTransformManager.getInstance().getPageByPath(e.data.path);
			if(page){
				page.dispatchEvent(new AdvancedEvent(BasePage.CALL,false,false,e.data.param));
			}else{
//				Alert.show("页面"+e.data.path+"还未创建，无法调度。");
				trace("页面"+e.data.path+"还未创建，无法调度。");
			}
		}
		private var _isLocked:Boolean=false;
		public function get lock():Boolean{
			return _isLocked;
		}
		/**
		 * 为提升效率，应将所有需要更改的目录项全都整合到一个数组中后一次性发送事件
		 * 数组中元素格式为{path:String,enable:Boolean}.
		 */ 
		private function onModuleDisable(e:AdvancedEvent):void{
			BaseMenu.enableChanged=true;
			//为方便操作，每次设置之前都会将原有设置清空。也可选择保留之前设置。
			XMLUtil.viewNode(menu,"node",false,resetEnable);
			
			for each(var obj:Object in e.data){
				if(!XMLUtil.getNodeByPath(menu.node,obj["path"].split("/"),"label",1)){
					Alert.show("无法找到此目录:"+obj["path"]);
					continue;
				}
				var arr:Array=XMLUtil.getAllFNode(XMLUtil.getNodeByPath(menu.node,obj["path"].split("/"),"label",1),"node");
				for each(var xml:XML in arr){
					xml.@["enable"]=obj["enable"].toString();
				}
			}
			XMLUtil.viewNode(menu,"node",false,processDisable);
			if(currNode.@enable=="false"){
				dispatchEvent(new AdvancedEvent(MODULE_NAV,false,false,new NavParam(null,null,
					XMLUtil.getFNodeByAttribute(menu,"select","true"))));
			}else{
				processMenu(menu);
			}
		}
		private function resetEnable(node:XML):void{
			if(node.@select=="true"&&node.@enable=="false"){
				node.@select="false";
			}
			node.@enable="true";
		}
		private function processDisable(node:XML):void{
			if(node["node"].length()!=0){
				var b:Boolean=false;
				for each(var xml:XML in node["node"]){
					if(xml.@["enable"]!="false"){
						b=true;
						break;
					}
				}
				node.@["enable"]=b.toString();
			}
		}
		private var disableNames:Array=[];
		private function onEnableMenuByName(e:AdvancedEvent):void{
			BaseMenu.enableChanged=true;
			disableNames=e.data as Array;
			//为方便操作，每次设置之前都会将原有设置清空。也可选择保留之前设置。
			XMLUtil.viewNode(menu,"node",false,resetEnable);
			XMLUtil.viewNode(menu,"node",false,diableByName);
			XMLUtil.viewNode(menu,"node",false,processDisable);
			if(!currNode||currNode.@enable=="false"){
				dispatchEvent(new AdvancedEvent(MODULE_NAV,false,false,new NavParam(null,null,
					XMLUtil.getFNodeByAttribute(menu,"select","true"))));
			}else{
				processMenu(menu);
			}
			disableNames=[];
		}
		private function diableByName(node:XML):void{
			if(disableNames.indexOf(node.@label+"")!=-1){
				dgd(node);
			}
		}
		private function dgd(xml:XML):void{
			xml.@enable="false";
			for each(var xm:XML in xml.node){
				dgd(xm);
			}
		}
		private function onNavLock(e:AdvancedEvent):void{
			this._isLocked=e.data;
		}
		private function onMenuComplete(e:AdvancedEvent):void{
			this.removeEventListener(MENU_COMPLETE,onMenuComplete);
			dispatchEvent(new AdvancedEvent(NAV_LOCK,false,false,false));
			if(currNode.@classPath.toString() ==""){
				return;
			}
			trace("currPath:"+currPath+"|"+currNode.@classPath.toString());
			PageTransformManager.getInstance().dispatchEvent(new AdvancedEvent(
				PageTransformManager.TRANSFORM_PAGE,false,false,{path:currPath,node:currNode,param:currParam,refresh:isRefresh}));
		}
		private function processMenuDeafult(m:XML):void{
			Alert.show("未设置目录处理器");
			dispatchEvent(new AdvancedEvent(MENU_COMPLETE,false,false));
		}
		private var navQueue:Queue=new Queue(20);
		private function nav2Next(ev:Event):void{
			while(navQueue.hasnext()){
				var e:AdvancedEvent=navQueue.getnext() as AdvancedEvent;
				var node:XML;
				if(e.data.path){
					node=XMLUtil.getNodeByPath(menu.*,e.data.path.split("/"),"label",1,processNode);
				}else{
					node=e.data.node;
				}
				if(node.@["enable"]!="false"){
					e.data.isnew=false;
					NavManager.getInstance().dispatchEvent(new AdvancedEvent(MODULE_NAV,false,false,e.data));
					return;
				}
			}
			PageFrame.direction=true;
			Alert.show("已经是最近访问页面");
		}
		private function nav2Pre(ev:Event):void{
			while(navQueue.haspre()){
				var e:AdvancedEvent=navQueue.getpre() as AdvancedEvent;
				var node:XML;
				if(e.data.path){
					node=XMLUtil.getNodeByPath(menu.*,e.data.path.split("/"),"label",1,processNode);
				}else{
					node=e.data.node;
				}
				if(node.@["enable"]!="false"){
					e.data.isnew=false;
					NavManager.getInstance().dispatchEvent(new AdvancedEvent(MODULE_NAV,false,false,e.data));
					return;
				}
			}
			PageFrame.direction=true;
			Alert.show("已经是最早访问页面");
		}
		
		/**
		 * 重新加载当前页面
		 */
		private function onModuleRefresh(e:AdvancedEvent):void{
			isRefresh = true;
			
			PageTransformManager.getInstance().dispatchEvent(new AdvancedEvent(
				PageTransformManager.TRANSFORM_PAGE,false,false,{path:currPath,node:currNode,param:currParam,refresh:isRefresh}));
		}
	}
}