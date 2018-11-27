package com.morcha4.RPC.remoteProxys
{
	import com.morcha4.RPC.Endpoint;
	import com.morcha4.RPC.request.BaseRequestProxy;
	import com.morcha4.RPC.request.RORequestParam;
	import com.morcha4.RPC.request.RequestManager;
	
	import mx.controls.Alert;

	public class RemoteProxyFactory
	{
		public function RemoteProxyFactory()
		{
		}
		public static function getRemoteProxy(type:String,endp:Endpoint):BaseRemoteProxy{
			switch(type){
				case "RO":{
					return new RORemoteProxy(endp);
				}
				case "HTTP":{
					return null;
				}
			}
			Alert.show("不能识别的远程代理类型:"+type);
			return null;
		}
		public static function getPriRequest(type:String):BaseRequestProxy{
			//isPri=true;
			switch(type){
				case "RO":{
					var r:BaseRequestProxy=RequestManager.getRequest();
					r.isPri=true;
					r.sendParme=new RORequestParam("org.jmask.web.controller.user.resultManager","getResult",null,null);
					return r;
				}
				case "HTTP":{
					return null;
				}
			}
			return null;
		}
	}
}