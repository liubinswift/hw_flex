package com.viewscenes.beans.runplan
{
	import com.viewscenes.beans.BaseBean;

	/**国际台运行图bean
	 *@作者:王福祥
	 *@创建时间：2012/07/19
	 * */
	[RemoteClass(alias="com.viewscenes.bean.runplan.GJTRunplanBean")]
	public class GJTRunplanBean extends BaseBean
	{
		public var runplan_id:String="";      //运行图id
		public var runplan_type_id:String=""; //运行图类型id
		public var station_id:String="";      //发射台id
		public var station_name:String="";   //发射台名称
		public var sentcity_id:String="";    //发射城市id
		public var sentcity:String="";       //发射城市
		public var transmiter_no:String="";  //发射机号
		public var freq:String="";           //频率
		public var antenna:String="";        //天线号
		public var antennatype:String="";    //天线程式
		public var direction:String="";      //方向
		public var language_id:String="";    //语言id
		public var language:String="";       //语言名称
		public var power:String="";          //功率
		public var program_type_id:String="";//节目类型id
		public var program_type:String="";   //节目 类型名称
		public var service_area:String="";   //服务区
		public var ciraf:String="";          //CRIAF取
		public var satellite_channel:String="";//国际卫星通道
		public var start_time:String="";       //播音开始时间
		public var end_time:String="";         //播音结束时间
		public var mon_area:String="";         //质量收测站点
		public var xg_mon_area:String="";     //效果收测站点
		public var rest_datetime:String="";    //休息日期
		public var rest_time:String="";        //休息时间
		public var valid_start_time:String=""; //启用期
		public var valid_end_time:String="";  //停用期
		public var remark:String="";           //备注
		public var flag:String="";           //标志位 unit:代表查询当前单元的运行图；all:代表查询全部运行图
		public var season_id:String="";           //季节代号
		public var weekday:String="";//周设置
		public var store_datetime="";//导入日期
		public function GJTRunplanBean()
		{
		}
	}
}