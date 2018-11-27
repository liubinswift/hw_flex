package com.viewscenes.beans.pub
	
{
	import com.viewscenes.beans.BaseBean;

	/**
	 *@作者:
	 *@创建时间：
	 *
	 **/
	//与java后台bean对应时需要这样写 bean中的字段可以不完全一样，但属性命名最好驼峰式命名规则
	[RemoteClass(alias="com.viewscenes.bean.ResHeadendBean")]
	public class ResHeadendBean extends BaseBean
	{
		
		public var head_id:String = "";
		public var code:String = "";
		public var shortname:String = "";
		public var com_id:String = "";
		public var com_protocol:String = "";
		public var ip:String = "";
		public var longitude:String = "";
		public var latitude:String = "";
		public var comphone:String = "";
		public var site:String = "";
		public var address:String = "";
		public var site_status:String = "";
		public var com_status:String = "";
		public var fault_status:String = "";
		public var station_name:String = "";
		public var descript:String = "";
		public var state:String = "";
		public var country:String = "";
		public var version:String = "";
		public var occur_time:String = "";
		public var altitude:String = "";
		public var summertime_begin:String = "";
		public var summertime_end:String = "";
		public var ciraf:String = "";
		public var person:String = "";
		public var person_phone:String = "";
		public var principal:String = "";
		public var principal_phone:String = "";
		public var time_diff:String = "";
		public var is_delete:String = "";
		public var default_language:String = "";
		public var x:String = "";
		public var y:String = "";
		
		
		public var state_name:String = "";
		public var type_id:String = "";
		public var url:String="";
		public var is_online:String="";
		public var manufacturer:String = "";
		
		public var code_noab:String = "";
		public var shortname_noab:String = "";
		public var service_name:String="";
		public var post:String = "";
	}
}