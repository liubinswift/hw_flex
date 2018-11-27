package com.viewscenes.beans.runplan
{
	import com.viewscenes.beans.BaseBean;

	/**外国台运行图bean
	 *@作者:王福祥
	 *@创建时间：2012/07/19
	 * */
	[RemoteClass(alias="com.viewscenes.bean.runplan.WGTRunplanBean")]
	public class WGTRunplanBean extends BaseBean
	{
		
		public var runplan_id:String="";      //运行图id
		public var runplan_type_id:String=""; //运行图类型
		public var broadcast_station:String="";     //播音电台
		public var broadcast_country:String;  //播音国家
		public var launch_country:String;  //发射国家
		public var sentcity_id:String="";     //发射城市id
		public var sentcity:String="";        //发射城市名称
		public var station_id:String="";      //发射台id
		public var station_name:String="";    //发射台名称
		public var transmiter_no:String="";   //发射机号
		public var freq:String="";            //频率
		public var antenna:String="";         //天线号
		public var antennatype:String="";     //天线程式
		public var direction:String="";       //方向
		public var language_id:String="";     //语言id
		public var language:String="";     //语言名称
		public var power:String="";           //功率
		public var service_area:String="";    //服务区
		public var ciraf:String="";           //CIRAF区
		public var start_time:String="";      //播音开始时间
		public var end_time:String="";        //播音结束时间
		public var mon_area:String="";        //质量收测站点
		public var xg_mon_area:String="";     //效果收测站点
		public var rest_datetime:String="";   //休息日期
		public var rest_time:String="";       //休息时间
		public var valid_start_time:String="";//启用期
		public var valid_end_time:String="";  //停用期
		public var remark:String="";          //备注
		public var flag:String="";           //标志位 unit:代表查询当前单元的运行图；all:代表查询全部运行图
		public function WGTRunplanBean()
		{
		}
	}
}