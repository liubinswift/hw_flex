package com.morcha4.frame
{
	import com.morcha4.frame.nav.NavManager;
	import com.morcha4.frame.system.AdvancedEvent;
	import com.morcha4.frame.system.BasePage;
	import com.morcha4.frame.system.ModuleManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	
	public class PageTransformManager extends EventDispatcher
	{
		public static const TRANSFORM_PAGE:String="transfrom_page";
		public static const TRANSFORM_END:String="transfrom_end";
		public static const BEGIN_LOADING_PAGE:String="begin_loading_page";
		public function PageTransformManager()
		{
			this.addEventListener(TRANSFORM_PAGE,onTrans);
			this.addEventListener(TRANSFORM_END,onTransEnd);
		}
		
		private static var _instance:PageTransformManager;
		
		public static function getInstance():PageTransformManager{
			if(!_instance){
				_instance=new PageTransformManager();
			}
			return _instance;
		}
		private var transParam:Object;
		private function onTrans(e:AdvancedEvent):void{
			transParam=e.data;
			trans(e.data.path,e.data.node.@["classPath"],e.data.node.@["label"],e.data.refresh);
		}
		private function onTransEnd(e:Event):void{
			if(waitPage){
				waitPage.addEventListener(FlexEvent.CREATION_COMPLETE,onPageCreat)
				waitPage.visible=false;
				PageFrame.getInstance().addElement(waitPage);
			}else{
				NavManager.getInstance().dispatchEvent(new AdvancedEvent(NavManager.NAV_LOCK,false,false,false));
				//若需要额外的导航则在下一帧中进行
			}
		}
		private function onPageCreat(e:FlexEvent):void{
			switchPage(waitPage);
			waitPage=null;
		}
		private var waitPage:BasePage;
		private var dicPage:Object={};
		public function getPageByPath(path:String):BasePage{
			return dicPage[path];
		}
		private function trans(path:String,url:String,label:String,refresh:Boolean):void{
			NavManager.getInstance().dispatchEvent(new AdvancedEvent(NavManager.NAV_LOCK,false,false,true));
			if(!refresh){//再次点击同一个页面进行重新加载操作
				if(dicPage[path]){  
					(dicPage[path]as BasePage).param=transParam.param;
					switchPage(dicPage[path]);
					return;
				}
			}
			var page:BasePage=ModuleManager.getModule(url) as BasePage;
			if(page){
				dicPage[path]=page;
				page.config=transParam.node;
				waitPage=page;
				switchPage(TempPage.getInstance());
				return;
			}
			if(PageProxyManager.getInstance().hasProxy(path)){
				TempPage.getInstance().initPage(path,url,transParam,label);
				switchPage(TempPage.getInstance());
			}else{
				PageProxyManager.getInstance().getProxy(path).load(url);
				TempPage.getInstance().initPage(path,url,transParam,label);
				switchPage(TempPage.getInstance());
			}
		}
		private function switchPage(target:BasePage):void{
			PageFrame.getInstance().dispatchEvent(new AdvancedEvent(PageFrame.TRANSFORM_PAGE,false,false,target));
		}
	}
}