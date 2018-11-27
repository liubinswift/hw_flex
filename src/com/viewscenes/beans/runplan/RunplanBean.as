package com.viewscenes.beans.runplan
{
	import com.viewscenes.beans.BaseBean;
	
	/**运行图bean
	 *@作者:刘斌
	 *@创建时间：2012/07/19
	 * */
	[RemoteClass(alias="com.viewscenes.bean.runplan.RunplanBean")]
	public class RunplanBean extends BaseBean
	{
		
		public function RunplanBean()
		{
		}
		public var runplan_id:String="";
		public var runplan_type_id:String="";
		public var station_id:String="";
		public var transmiter_no:String="";
		public var freq:String="";
		public var valid_start_time:String="";
		public var valid_end_time:String="";
		public var direction:String="";
		public var power:String="";
		public var service_area:String="";
		public var antennatype:String="";
		public var rest_datetime:String="";
		public var rest_time:String="";
		public var sentcity_id:String="";
		public var start_time:String="";
		public var end_time:String="";
		public var satellite_channel:String="";
		public var store_datetime:String="";
		public var program_type_id:String="";
		public var language_id:String="";
		public var weekday:String="";
		public var input_person:String="";
		public var revise_person:String="";
		public var remark:String="";
		public var program_id:String="";
		public var mon_area:String="";//质量收测站点
		public var xg_mon_area:String="";//效果收测站点
		public var is_delete:String="";
		public var band:String="";
		public var program_type:String="";
		public var redisseminators:String="";
		public var local_time:String="";
		public var summer:String="";
		public var summer_starttime:String="";
		public var summer_endtime:String="";
		public var season_id:String="";
		public var antenna:String="";
		public var station_name:String="";
		public var ciraf:String="";
		public var launch_country:String = "";
		//根据关联条件关联出来的内容。
		public var sendcity:String="";
		public var language_name:String="";
		public var program_name:String="";
		public var type:String="";
		public var runplanType:String="";
		public var  shortname:String="";
		
	}
}