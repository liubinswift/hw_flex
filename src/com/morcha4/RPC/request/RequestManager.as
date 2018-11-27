package com.morcha4.RPC.request
{
	import flash.utils.setInterval;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	public class RequestManager
	{
		public function RequestManager()
		{//setInterval(function (){Alert.show("request"+requests.length)},1000);
		}
		private static var requests:ArrayCollection=new ArrayCollection;
		private static var dicRequests:Object={};
		private static var index:int=0;
		private static const MAX:int=30;
		/**
		 * 获取一个新的请求代理 
		 * @return 
		 * 
		 */		
		public static function getRequest():BaseRequestProxy{
			//超量则清理请求
			if(requests.length>=MAX){
				var br:BaseRequestProxy;
				for(var i:int=requests.length-1;i>=0;i--){
					br=requests.getItemAt(i)as BaseRequestProxy;
					if(br.isCancel||br.isReturn){
						dicRequests[br.id]=null;
						requests.removeItemAt(i);
						br.clear();
					}
				}
				if(requests.length>=MAX){
//					Alert.show("未结束请求过多");
				}
			}
			var brn:BaseRequestProxy=new BaseRequestProxy();
			brn.id=index+++"";
			requests.addItem(brn);
			dicRequests[brn.id]=brn;
			return brn;
		}
		/**
		 * 通过请求代理的id获取一个已存在的请求代理 
		 * @param id
		 * @return 
		 * 
		 */		
		public static function getRequestByID(id:String):BaseRequestProxy{
			return dicRequests[id]as BaseRequestProxy;
		}
	}
}