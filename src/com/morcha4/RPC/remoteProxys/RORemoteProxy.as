package com.morcha4.RPC.remoteProxys
{
	import com.morcha4.RPC.Endpoint;
	import com.morcha4.RPC.RPCException;
	import com.morcha4.RPC.request.BaseRequestProxy;
	import com.morcha4.RPC.request.RORequestParam;
	
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import spark.components.mediaClasses.VolumeBar;
	
	public class RORemoteProxy extends BaseRemoteProxy
	{
		private var ro:RemoteObject=new RemoteObject;
		private var errorTime:int=0;
		public function RORemoteProxy(endPoint:Endpoint)
		{
			super(endPoint);
			ro.endpoint=endPoint.url;
			ro.addEventListener(ResultEvent.RESULT,onResult);
			ro.addEventListener(FaultEvent.FAULT,onFault);
			ro.destination="RPCController";
		}
		override public function send(request:BaseRequestProxy):void{
			super.send(request);
			var rp:RORequestParam=request.sendParme as RORequestParam;
			ro.getOperation("getResult").send(request.id,rp.classPath,rp.funName,rp.param,request.isLongTime);
		}
		private function onResult(e:ResultEvent):void{
			if(e.result is RPCException){//后台方法执行错误
				if(errorTime++<3){
					send(request);
				}else{
					errorTime=0;
					result(e.result,false);
				}
			}else{
				errorTime=0;
				result(e.result,true);
			}
		}
		private function onFault(e:FaultEvent):void{
//			Alert.show(e.message+"");
			if(++errorTime<3){
				setTimeout(send,100,request);
			}else{
				result(null,false);
			}
		}
	}
}