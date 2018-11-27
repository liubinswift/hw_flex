package com.viewscenes.utils
{
	public class SendXmlService
	{
		import mx.rpc.http.HTTPService;
		import mx.rpc.events.*;
		import mx.controls.Alert;
		
		private var _m_parent:Object;
		private var _func_parseData:Function = null;
		
		private function parseData(xml:XML):void{
			if(_func_parseData == null){
				_m_parent.parseData(xml);
			}
			else{
				this._func_parseData(xml);
			}
		}
		
		public function SendXmlService()
		{
		}
		
		public function set m_parent(parent:Object):void{
			this._m_parent = parent;
		}
		
		public function get func_parseData():Function{
			return this._func_parseData;
		}
		
		public function set func_parseData(func_parseData:Function):void{
			this._func_parseData = func_parseData;
		}
		
		public function get m_parent():Object{
			return this._m_parent;
		}
		
		public function sendService(text:String,url:String):void{
				var service:HTTPService = new HTTPService();
				service.method = "post";
				service.url = url;
				service.contentType = "application/xml";
				service.resultFormat = "e4x";
				service.addEventListener(ResultEvent.RESULT,doResult);
				service.addEventListener(FaultEvent.FAULT,doFault);
				
				var xmlText:XML = new XML(text);
				service.send(xmlText);
		}
		
		public function doResult(e:ResultEvent):void{
			var xmlText:XML = e.result as XML;
			parseData(xmlText);
		}
			
		public function doFault(e:FaultEvent):void{
			var str:String = "服务调用失败，详细信息：\n" 
							+ "Event Target:" + e.target
							+ "\n Event type:" + e.type
							+ "\n Fault Code:" + e.fault.faultCode
							+ "\n Fault Info:" + e.fault.faultString;
			Alert.show(str,"错误");
		}
			
		public function getXmlMsgHead(type:String,func:String):String{
			var head:String = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\r';
			head += '<msg type="'+type+'" function="'+func+'">\r';
			head += '<user_id>1</user_id>\r';
			head += '<priority>111</priority>\r';
			return head;
		}
	}
}