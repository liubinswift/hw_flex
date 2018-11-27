package com.morcha4.RPC
{
	import com.morcha4.RPC.remoteProxys.BaseRemoteProxy;
	import com.morcha4.RPC.request.BaseRequestProxy;
	
	import flash.utils.Endian;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import spark.components.mediaClasses.VolumeBar;

	public class serverProxy
	{
		public var id:String;
		/**
		 * 标识该服务代理当前是否可用 
		 */		
		public var useable:Boolean=true;
		public var waitRequestProxy:Array=[]
		/**
		 * 该服务代理所使用的远程代理类型
		 */		
		private var type:String;
		/**
		 * 该服务代理所拥有的endpoint 
		 */		
		private var endpoints:Array=[];
		/**
		 * 当前endpoint 
		 */		
		private var currEndpoint:Endpoint;
		public function serverProxy(id:String,type:String)
		{//setInterval(function (){Alert.show("server"+hasIdle+"wait"+waitRequestProxy.length)},5000);
			this.id=id;
			this.type=type;
		}
		public function initEndpoint(config:XMLList):void{
			for each(var xml:XML in config){
				var ep:Endpoint=new Endpoint(xml.@url,type,RPCManager.MAX_PROXY_PER_ENDPOINT,this,(isNaN(parseInt(xml.@timeout))?10:parseInt(xml.@timeout)),
					(isNaN(parseInt(xml.@waitTime))?10:parseInt(xml.@waitTime)));
				endpoints.push(ep);
			}
			currEndpoint=endpoints[0];
			currEndpoint.isCurr=true;
		}
		/**
		 * 判断该服务代理当前是否有空闲发送请求 
		 * @return 
		 * 
		 */		
		public function get hasIdle():Boolean{
			if(!useable){
				return false;
			}
			return currEndpoint.hasIdle;
		}
		public function send(request:BaseRequestProxy):void{
			currEndpoint.send(request);
		}
		/**
		 * 被endpoint通知需要切换endpoint 
		 * @param e
		 * @return 
		 * 
		 */		
		public function transEndPoint(e:Endpoint):void{
			e.isCurr=false;
			e.useable=false;
			waitRequestProxy=waitRequestProxy.concat(e.longTimeWaitRequest.toArray());
			e.longTimeWaitRequest==new ArrayCollection;
			for each(var rem:BaseRemoteProxy in e.remoteProxys){
				if(rem.request){
					waitRequestProxy.push(rem.request);
//					rem.request=null;
				}
			}
			currEndpoint=null;
			for each(var ep:Endpoint in endpoints){
				if(ep.useable){
					currEndpoint=ep;
					ep.isCurr=true;
				}
			}
			if(currEndpoint){
				endpointHasIdle(currEndpoint);
//				setTimeout(endpointHasIdle,10,currEndpoint);
			}else{
				useable=false;
				while(waitRequestProxy.length>0){
					var exc:RPCException=new RPCException;
					exc.message="服务器连接失败";
					(waitRequestProxy.pop() as BaseRequestProxy).applyResult(exc,false);
				}
				//通知RPCManager服务挂了
				RPCManager.serverHasFailed(this);
			}
		}
		/**
		 * 被endpoint通知有空闲发送请求 
		 * 
		 */		
		public function endpointHasIdle(e:Endpoint):void{
			if(e!=currEndpoint){
				return;
			}
			while(currEndpoint.hasIdle&&waitRequestProxy.length>0){
				var br:BaseRequestProxy=waitRequestProxy.pop();
				if(!br.isCancel&&!br.isReturn){
					currEndpoint.send(br);
				}
			}
			if(currEndpoint.hasIdle){
				RPCManager.serverHasIdle(this);
			}
		}
		/**
		 * 被endpoint通知重连成功 
		 * @param e
		 * 
		 */		
		public function endpointConnect(e:Endpoint):void{//Alert.show("ok");
			e.useable=true;
			if(!useable){
				currEndpoint=e;
				e.isCurr=true;
				useable=true;
			}
		}
	}
}