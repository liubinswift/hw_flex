package com.viewscenes.beans
{
	/**
	 * 下发实时音频指令类
	 * 
	 * */
	[RemoteClass(alias="com.viewscenes.bean.RealtimeUrlCmdBean")]
	public class RealtimeUrlCmdBean
	{
		public var userid:String =  "";
		public var code:String =  "";
		public var equCode:String =  "";
		public var bps:String =  "";
		public var encode:String =  "";
//		public var flag:String =  "";
		public var freq:String =  "";
		public var band:String =  "";
		public var action:String =  "";
		public var priority:String =  "";
		public var lastUrl:String =  "";
		
		public function RealtimeUrlCmdBean()
		{
			
		}
	}
}