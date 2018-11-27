package com.viewscenes.beans.spectrum
{
	/**
	 * 频谱信息表bean
	 */
	[RemoteClass(alias="com.viewscenes.bean.spectrum.SpectrumStatBean")]
	public class SpectrumStatBean
	{
		public var id:String = "";
		public var head_code:String = "";//前端
		public var station_id:String = "";//发射台
		public var station_name:String = "";
		public var language_id:String = "";
		public var language_name:String = "";//语言
		public var country:String = "";//国家
		public var effect:String = "";//效果
		public var mark:String = "";//分数
		public var freq:String = "";//频率
		public var playtime:String = "";//播音时段
		public var headtype:String = "";//101采集点 102遥控站
		public var is_play:String = "";//0无播音 1有播音  对象语言识别系统返回的字段<Status>停播、空播、话少</Status>  停播就是无播音
		public var input_datetime:String = "";//录入日期
		public var head_name:String = "";//前端名称,去掉AB用于频谱统计时使用.
		
		public function SpectrumStatBean()
		{
		}
	}
}