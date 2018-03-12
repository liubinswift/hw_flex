package com.viewscenes.beans
{
	import com.viewscenes.beans.BaseBean;
	[RemoteClass(alias="com.viewscenes.bean.SeasonBean")]
	public class SeasonBean extends BaseBean
	{
		public var code:String="";
		public var start_time:String="";
		public var end_time:String="";
		public var is_now:String="";
		
		public function SeasonBean()
		{
		}
	}
}