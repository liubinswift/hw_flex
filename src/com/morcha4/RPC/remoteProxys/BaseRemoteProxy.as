package com.morcha4.RPC.remoteProxys
{
	import com.morcha4.RPC.Endpoint;
	import com.morcha4.RPC.request.BaseRequestProxy;

	public class BaseRemoteProxy
	{
		/**
		 * 该远程代理所属的远程连接通道 
		 */		
		protected var endPoint:Endpoint;
		/**
		 * 标识该远程调用对象是否正在被使用 
		 */		
		public var isUsed:Boolean=false;
		/**
		 * 该远程调用对象所代理的请求 
		 */		
		public var request:BaseRequestProxy;
		public function BaseRemoteProxy(endPoint:Endpoint)
		{
			this.endPoint=endPoint;
		}
		/**
		 * 使用该远程代理发送一个请求 
		 * @param request 发送的请求
		 */		
		public function send(request:BaseRequestProxy):void{
			isUsed=true;
			this.request=request;
		}
		/**
		 * 远程调用对象返回
		 * @param resultObj 调用的返回结果
		 * @param success 标识调用是否成功(若为后台方法执行错误则有resultObj,若为服务器连接错误则resultObj为空)
		 */		
		protected function result(resultObj:Object,success:Boolean=true):void{
			isUsed=false;
			endPoint.result(this,resultObj,success);
		}
		
	}
}