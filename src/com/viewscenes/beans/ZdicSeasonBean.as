package com.viewscenes.beans
{
	/**
	 * 语言字典表对象类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.ZdicSeasonBean")]
	public class ZdicSeasonBean extends BaseBean
	{
		
		public var code:String = "";
		public var start_time:String = "";
		public var end_time:String = "";
		public var is_now:String = "";
		
		public function ZdicSeasonBean()
		{
		}
	}
}