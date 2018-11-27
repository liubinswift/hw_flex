package com.viewscenes.beans
{
	/**
	 * 运行图类型对象类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.RunplanTypeBean")]
	public class RunplanTypeBean
	{
		public var runplanTypeId:String = "";
		public var runplanType:String = "";

		public function RunplanTypeBean()
		{
		}
	}
}