package com.morcha4.RPC
{
	import com.morcha4.RPC.remoteProxys.BaseRemoteProxy;
	import com.morcha4.RPC.remoteProxys.RemoteProxyFactory;
	import com.morcha4.RPC.request.BaseRequestProxy;
	import com.morcha4.RPC.request.RequestManager;
	
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.Request;

	public class Endpoint
	{
		/**
		 * 服务器地址 
		 */		
		public var url:String;
		/**
		 * 连接类型 
		 */		
		public var type:String;
		/**
		 * 标识该通道当前是否可用 
		 */		
		public var useable:Boolean=true;
		/**
		 * 该通道拥有的远程调用代理(RemoteProxy) 
		 */		
		public var remoteProxys:Array=[];
		/**
		 * 该通道可以可以使用的最大代理数量
		 */ 
		public var maxNUM:int=2;
		/**
		 * 该通道中正在使用的代理数量 
		 */		
		public var usedNUM:int=0;
		/**
		 * 标识该通道是否为现在正在使用的通道 
		 */		
		public var isCurr:Boolean=false;
		/**
		 * 该通道的最大等待时间，即若所有调用对象均用完的情况持续此时间则认为远程服务出现问题。 
		 */		
		public var timeoutTime:int=20;
		/**
		 * 此通道中正在等待异步返回的请求对象 
		 */		
		public var longTimeWaitRequest:ArrayCollection=new ArrayCollection;
		/**
		 * 标识当前是否正在发送pri请求 
		 */		
		private var isPriSending:Boolean=false;
		/**
		 * 获取异步请求结果的时间间隔
		 */ 
		public var waitTime:int=500;
		private var timeoutInner:int;
		private var server:serverProxy;
		public function Endpoint(url:String,type:String,max:int,server:serverProxy,timeOut:int=10,waitTime:int=500)
		{//setInterval(function (){Alert.show("endpoint"+hasIdle+"unum"+usedNUM)},1000);
			this.url=url;
			this.type=type;
			this.server=server;
			this.maxNUM=max;
			this.timeoutTime=timeOut;
			this.waitTime=waitTime;
			initProxy();
		}
		/**
		 * 根据type值初始化remoteProxy 
		 * @return 
		 * 
		 */		
		private function initProxy():void{
			for(var i:int=0;i<maxNUM;i++){
				var b:BaseRemoteProxy=RemoteProxyFactory.getRemoteProxy(type,this);
				remoteProxys.push(b);
			}
		}
		/**
		 * 使用该通道发送一个请求 
		 * @param request 发送的请求
		 */		
		public function send(request:BaseRequestProxy):void{
			numChange();
			request.beginTimeout();
			getRemoteProxy().send(request);
			
		}
		/**
		 * 远程调用对象返回
		 * @param resultObj 调用的返回结果
		 * @param success 标识调用是否成功(若为后台方法执行错误则有resultObj,若为服务器连接错误则resultObj为空)
		 */		
		public function result(remoteProxy:BaseRemoteProxy,resultObj:Object,success:Boolean=true):void{
			if(remoteProxy.request.isPri){
				if(!resultObj&&isCurr){
					notifyTransEndpoint();
				}
				applyResult(remoteProxy,resultObj,success);
			}else if(!isCurr){
			}else{
				if(!success){
					if(resultObj){
						applyResult(remoteProxy,resultObj,success);
					}else{
						notifyTransEndpoint();
					}
				}else if(remoteProxy.request.isLongTime){
					longTimeWaitRequest.addItem(remoteProxy.request);
					trySendPriRequest();
				}else{
					applyResult(remoteProxy,resultObj,success);
				}
			}
			numChange(false);
			if(hasIdle){
				notifyIdle();
			}
		}
		/**
		 * 尝试发送pri请求，若正在发送pri则等待，
		 * 否则清理 longTimeWaitRequest。清理完后还需要发则发。
		 * 
		 */		
		private function trySendPriRequest():void{
			if(isPriSending){
				return;
			}
			if(!isCurr){
				return;
			}
			if(longTimeWaitRequest.length==0){
				return;
			}
			var len:int=longTimeWaitRequest.length;
			var r:BaseRequestProxy;
			for(var i:int=len-1;i>=0;i--){
				r=longTimeWaitRequest[i] as BaseRequestProxy;
				if(r.isReturn||r.isCancel){
					longTimeWaitRequest.removeItemAt(i);
				}
			}
			if(longTimeWaitRequest.length>0){
				sendPriRequest();
			}
		}
		/**
		 * 确定需要发送pri请求后。 
		 * 
		 */		
		private function sendPriRequest():void{
			if(hasIdle){
				isPriSending=true;
				numChange();
				var pri:BaseRequestProxy=RemoteProxyFactory.getPriRequest(type);
				pri.callBack=priRequestReturn;
				pri.faultBack=priRequestFault;
				getRemoteProxy().send(pri);
			}
		}
		/**
		 * pri请求正常回复 
		 * @param obj
		 * 
		 */		
		private var priTime:int;
		public function priRequestReturn(obj:Object):void{
			//解析私有请求
			var r:BaseRequestProxy;
			for(var mid:String in obj){
				r=RequestManager.getRequestByID(mid);
				if(r){
					if(longTimeWaitRequest.contains(r)){
						longTimeWaitRequest.removeItemAt(longTimeWaitRequest.getItemIndex(r));
						if(!r.isReturn&&!r.isCancel){
							r.applyResult(obj[mid],!(obj[mid]is RPCException));
						}
					}
				}
			}
			isPriSending=false;
			clearTimeout(priTime);
			priTime=setTimeout(trySendPriRequest,waitTime);
		}
		/**
		 * pri请求异常回复 
		 * @param obj
		 * 
		 */
		public function priRequestFault(obj:Object):void{
			isPriSending=false;
			setTimeout(trySendPriRequest,waitTime);
		}
		/**
		 * 为正常的请求返回结果 
		 * @param remoteProxy
		 * @param resultObj
		 * @param success
		 * 
		 */		
		private function applyResult(remoteProxy:BaseRemoteProxy,resultObj:Object,success:Boolean=true):void{
			remoteProxy.request.applyResult(resultObj,success);
		}
		/**
		 * 正在使用的代理数量发生改变 
		 * @param add 标识是否为增加
		 */		
		public function numChange(add:Boolean=true):void{
			if(add){
				usedNUM+=1;
			}else{
				usedNUM-=1;
			}
			if(!isCurr){
				
			}else{
				if(usedNUM<0||usedNUM>maxNUM){
					Alert.show("EndPoint数量出错");
				}
				if(usedNUM<maxNUM){
					clearTimeout(timeoutInner);
				}else{
					timeoutInner=setTimeout(notifyTransEndpoint,timeoutTime*1000);
				}
			}
			if(!isCurr&&usedNUM==0){
				setTimeout(notifyConnect,2000);
			}
		}
		private function notifyConnect():void{
			if(!isCurr&&usedNUM==0){
				server.endpointConnect(this);
			}
		}
		/**
		 * 通知ServerPorxy切换通道 
		 * 
		 */		
		private function notifyTransEndpoint():void{
			server.transEndPoint(this);	
		}
		/**
		 * 通知通道有空闲 
		 * 
		 */		
		private function notifyIdle():void{
			server.endpointHasIdle(this);
		}
		/**
		 * 判断该通道是否有空闲发送请求
		 * @return 
		 */		
		public function get hasIdle():Boolean{
			return maxNUM>usedNUM;
		}
		public function getRemoteProxy():BaseRemoteProxy{
			for each(var r:BaseRemoteProxy in remoteProxys){
				if(!r.isUsed){
					return r;
				}
			}
			return null;
		}
	}
}