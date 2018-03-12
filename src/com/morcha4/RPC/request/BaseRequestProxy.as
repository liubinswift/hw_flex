package com.morcha4.RPC.request
{
	import com.morcha4.RPC.RPCException;
	
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;

	public class BaseRequestProxy
	{
		/**
		 * 发送到服务端的参数 
		 */		
		public var sendParme:Object;//{destination,operation,param:{class,mathod,param[]}}
		/**
		 * 现场数据，若设置则在返回时可以得到 
		 */		
		public var priParme:Object;
		/**
		 * 唯一标识请求的id 
		 */		
		public var id:String;
		/**
		 * 请求超时的时间 
		 */		
		public var timeoutTime:int=-1;
		private var timeoutInner:int;
		/**
		 * 请求返回时的回调方法 
		 */		
		public var callBack:Function;
		/**
		 * 请求发生错误时的回调方法(后台方法报错或者服务器连接错误);
		 */ 
		public var faultBack:Function;
		/**
		 * 标识该请求是否被取消 
		 */		
		public var isCancel:Boolean=false;
		/**
		 * 标识该请求是否已返回给请求客户 
		 */		
		public var isReturn:Boolean=false;
		/**
		 * 标识该请求是否是异步请求 
		 */		
		public var isLongTime:Boolean=false;
		/**
		 * 是否为pri请求 
		 */		
		public var isPri:Boolean=false;
		private var timeISCult:Boolean=false;
		public function beginTimeout():void{
			if(timeoutTime>0&&!timeISCult){
				timeISCult=true;
				timeoutInner=setTimeout(onTimeout,timeoutTime*1000);
			}
		}
		private function onTimeout():void{
			var exc:RPCException=new RPCException;
			exc.message="请求超时";
			applyResult(exc,false);
		}
		/**
		 * 回复请求客户
		 * @param obj 回复给请求客户的数据
		 * @param success 标识远程调用是否成功
		 * @return 
		 */		
//		public function applyResult(obj:Object,success:Boolean=true):void{
//			setTimeout(applyResult0,0,obj,success);
//		}
		public function applyResult(obj:Object,success:Boolean=true):void{
			clearTimeout(timeoutInner);
			if(isReturn||isCancel){
				return;
			}
			isReturn=true;
			try{
				if(success&&callBack!=null){
					if(priParme){
						callBack(obj,priParme);
					}else{
						callBack(obj);
					}
				}else if(!success&&faultBack!=null){
					if(priParme){
						faultBack(obj,priParme);
					}else{
						faultBack(obj);
					}
				}
				
			}catch(e:Error){
				Alert.show('远程调用回调方法执行错误'+e.message);
				trace('远程调用回调方法执行错误'+e.getStackTrace());
			}
		}
		public function cancel():void{
			isCancel=true;
			clear();
			
		}
		public function clear():void{
			clearTimeout(timeoutInner);
			this.callBack=null;
			this.faultBack=null;
		}
	}
}