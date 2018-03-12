package com.viewscenes.beans
{
	import com.viewscenes.beans.BaseBean;

	/**
	 * 城市字典表对象类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.ZdicCityBean")]
	public class ZdicCityBean extends BaseBean
	{
		
		public var id:String = "";              //id
		public var city:String = "";            //城市
		public var contry:String = "";         //国家
		public var capital:String = "";         //首都
		
		public var continents_id:String = "";    //大洲
		public var longitude:String = "";        //经度
		public var latitude:String = "";         //纬度
		public var ciraf:String = "";             //ciraf区
		
		public var elevation:String = "";           //海拔
		public var default_language:String = "";    //默认语言
		public var voltage:String = "";             //电压
		public var moveut:String = "";               //时差
		public var summer:String = "";               //夏令
		
		public function ZdicCityBean()
		{
		}
	}
}