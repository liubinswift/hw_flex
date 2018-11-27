package com.morcha4.frame
{
	import flash.events.EventDispatcher;

	/**
	 * 页面代理管理器.
	 * 此类为单例,请使用getInstance()方法获取唯一实例.
	 */ 
	public class PageProxyManager
	{
		public function PageProxyManager()
		{
		}
		private static var _instance:PageProxyManager;
		/**
		 * 得到页面代理管理器
		 */ 
		public static function getInstance():PageProxyManager{
			if(!_instance){
				_instance=new PageProxyManager();
			}
			return _instance;
		}
		private var dicProxy:Object={};
		/**
		 * 得到以参数id唯一标识的页面的代理
		 */ 
		public function getProxy(id:String):PageProxy{
			if(!dicProxy[id]){
				dicProxy[id]=new PageProxy();
				dicProxy[id].url=id;
			}
			return dicProxy[id];
		}
		public function hasProxy(id:String):Boolean{
			return dicProxy[id]!=null;
		}
		/**
		 * 销毁id标识的页面代理
		 */ 
		public function removeProxy(id:String):void{
			(dicProxy[id] as PageProxy).clear();
			dicProxy[id]=null;
		}
		/**
		 * 激活id标识的页面代理
		 */ 
		private var actProxy:String;
		public function activateProxy(id:String,target:EventDispatcher,isAct:Boolean):void{
			if(isAct){
				if(actProxy&&dicProxy[actProxy]){
					(dicProxy[actProxy] as PageProxy).activate(null,false);
				}
				actProxy=id;
				(dicProxy[id] as PageProxy).activate(target,true);
			}else{
				(dicProxy[id] as PageProxy).activate(null,false);
			}
		}
	}
}