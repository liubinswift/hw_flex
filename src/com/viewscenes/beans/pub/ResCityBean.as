package com.viewscenes.beans.pub
	
{
	import com.viewscenes.beans.BaseBean;

	/**
	 *@作者:
	 *@创建时间：
	 *
	 **/
	//与java后台bean对应时需要这样写 bean中的字段可以不完全一样，但属性命名最好驼峰式命名规则
	[RemoteClass(alias="com.viewscenes.bean.ResCityBean")]
	public class ResCityBean extends BaseBean
	{
		
		public var state:String = "";
		public var id = "";
		public var city = "";
		public var contry = "";
		public var capital = "";
		public var continents_id = "";
		public var longitude = "";
		public var latitude = "";
		public var ciraf = "";
		public var elevation = "";
		public var default_language = "";
		public var voltage = "";
		public var moveut = "";
		public var summer = "";
		
	}
}