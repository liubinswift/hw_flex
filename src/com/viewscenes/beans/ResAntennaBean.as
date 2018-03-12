package com.viewscenes.beans
{
	/**
	 * 发射台对象类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.ResAntennaBean")]
	public class ResAntennaBean
	{
		public var id:String = "";
		public var station_name:String = "";
		public var antenna_no:String = "";
		public var antenna_mode:String = "";
		public var itu:String = "";
		public var direction:String = "";
		public var service_area:String = "";
		public var address:String = "";
		public var ciraf:String = "";
		public var shiypd:String = "";
		public var remark:String = "";

		public function ResAntennaBean()
		{
		}
	}
}