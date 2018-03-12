package com.morcha4.RPC
{
	import com.morcha4.RPC.request.BaseRequestProxy;
	import com.morcha4.RPC.request.RORequestParam;
	import com.morcha4.RPC.request.RequestManager;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;

	/**
	 * 本类提供了对前后台调用的封装。
	 * @author lvb
	 */	
	public class RPCManager
	{
		/**
		 * 等待发送的请求,以ServerProxy的id为键，每个代理服务器建立一个请求队列
		 */		
		private static var requestsWaitForSend:Object={};
		private static var serverProxys:Object={};
		private static var deafultServer:serverProxy;
		public static var MAX_PROXY_PER_ENDPOINT:int=2;
		private static var hasInit:Boolean=false;
		/**
		 * 
		 * @param sendParam 发送到服务端的参数
		 * @param callBack 请求返回时的回调方法
		 * @param serverId 所要使用的服务类型
		 * @param timeoutTime 请求超时时间，以秒为单位
		 * @param priParam 现场数据,若设置则可以在返回时获取
		 * @return 返回RPC请求的ID,可以使用该ID取消请求
		 */		
//		public static function sendCmd(sendParam:*,callBack:Function=null,faultBack:Function=null,isLong:Boolean=false,
//									   priParam:Object=null,serverId:String=null, timeoutTime:int=-1):String{
		public static function sendCmd(sendParam:RORequestParam):String{
			if(!hasInit){
				Alert.show("还未初始化RPCManger");
				return null;
			}
			var r:BaseRequestProxy=RequestManager.getRequest();
			r.callBack=sendParam.callBack;
			r.faultBack=sendParam.faultBack;
			r.timeoutTime=sendParam.timeoutTime;
			r.isLongTime=sendParam.isLong;
			r.priParme=sendParam.priParam;
			r.sendParme=sendParam;
			var server:serverProxy=sendParam.serverId?getServer(sendParam.serverId):deafultServer;
			if(server.hasIdle){
				server.send(r);
				//注释一下看能否解决总是提示“服务器不可用”
//			}else if(!server.useable){
//				var exc:RPCException=new RPCException;
//				exc.message="服务器不可用";
//				r.applyResult(exc,false);
			}else{
				if(!requestsWaitForSend[server.id]){
					requestsWaitForSend[server.id]=new ArrayCollection;
				}
				requestsWaitForSend[server.id].addItem(r);
			}
			return r.id;
		}
		public static function initServers(config:XML,max:int=2):void{
			MAX_PROXY_PER_ENDPOINT=parseInt(config.@max);
			for each(var xml:XML in config.serverProxy){
				var sp:serverProxy=new serverProxy(xml.@id,xml.@type);
				sp.initEndpoint(xml.endPoint);
				serverProxys[sp.id]=sp;
				if(!deafultServer){
					deafultServer=sp;
				}
				if(xml.isDeafult=="true"){
					deafultServer=sp;
				}
			}
			hasInit=true;
		}
		/**
		 * 取消发送请求 
		 * @param id
		 * 
		 */		
		public static function cancelCmd(id:String):void{
			try{
				RequestManager.getRequestByID(id).cancel();
			}catch(e){
				
			}
			
		}
		/**
		 * 被服务代理通知有空闲 
		 * @param server
		 * 
		 */		
		public static function serverHasIdle(server:serverProxy):void{
			if(!requestsWaitForSend[server.id]){
				return;
			}
			var len:int=requestsWaitForSend[server.id].length;
			var br:BaseRequestProxy;
			for(var i:int=len-1;i>=0;i--){
				br=requestsWaitForSend[server.id][i];
				if(br.isCancel||br.isReturn){
					requestsWaitForSend[server.id].removeItemAt(i);
				}
			}
			if(requestsWaitForSend[server.id].length>0&&server.hasIdle){
				server.send(requestsWaitForSend[server.id][0] as BaseRequestProxy);
				requestsWaitForSend[server.id].removeItemAt(0);
			}
		}
		public static function serverHasFailed(server:serverProxy):void{
			var arr:ArrayCollection=requestsWaitForSend[server.id];
			if(!arr){
				return;
			}
			for(var i:int=arr.length-1;i>=0;i--){
				var exc:RPCException=new RPCException;
				exc.message="服务器连接失败";
				(arr[i] as BaseRequestProxy).applyResult(exc,false);
				arr.removeItemAt(i);
			}
		}
		private static function getServer(id:String):serverProxy{
			return serverProxys[id] as serverProxy
		}
	}
}