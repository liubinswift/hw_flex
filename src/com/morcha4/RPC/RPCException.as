package com.morcha4.RPC
{
	[RemoteClass(alias="org.jmask.web.controller.EXEException")]
	public class RPCException
	{
		public function RPCException()
		{
		}
		public var excId:String;
		public var message:String;
		public var data:Object;
	}
}