package com.morcha4.RPC.request
{
	public class RORequestParam
	{
		public function RORequestParam(classPath:String,funName:String,param:Object,callBack:Function,
				faultBack:Function=null,isLong:Boolean=false, priParam:Object=null,serverId:String=null, timeoutTime:int=-1)
		{
			this.classPath=classPath;
			this.funName=funName;
			this.param=param;
			this.callBack=callBack;
			this.faultBack=faultBack;
			this.isLong=isLong;
			this.priParam=priParam;
			this.serverId=serverId;
			this.timeoutTime=timeoutTime;
		}
		/**
		 * 请求正常返回时的回调方法。
		 * 若设置了priParam(现场数据)，则需要该回调方法的第二个参数接收priParam。
		 */		
		public var callBack:Function;
		/**
		 * 请求失败时的回调方法。
		 * 若设置了priParam(现场数据)，则需要该回调方法的第二个参数接收priParam。
		 */	
		public var faultBack:Function;
		/**
		 * 标志该请求是否可能长时间占用通信通道。
		 */	
		public var isLong:Boolean;
		/**
		 * 现场数据，若设置，则中会原封不动的提交到回调方法中
		 */	
		public var priParam:Object;
		public var serverId:String;
		public var timeoutTime:int;
		/**
		 * 后台的路径
		 */ 
		public var classPath:String;
		/**
		 * 后台的方法名
		 */ 
		public var funName:String;
		private var _param:Object;
		/**
		 * 提交到后台方法的唯一参数
		 */ 
		public function set param(value:Object):void{
			if(value){
				_param=[value];
			}else{
				_param=[];
			}
		}
		public function get param():Object{
			return _param;
		}
	}
}