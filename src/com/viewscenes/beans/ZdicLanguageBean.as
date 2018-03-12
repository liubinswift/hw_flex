package com.viewscenes.beans
{
	/**
	 * 语言字典表对象类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.ZdicLanguageBean")]
	public class ZdicLanguageBean extends BaseBean
	{
		
		public var language_id:String = "";
		public var language_name:String = "";
		public var is_delete:String = "";
		
		public function ZdicLanguageBean()
		{
		}
	}
}