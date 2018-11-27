package com.viewscenes.beans
{
	/**
	 * 
	 * 打分表对象类
	 * 
	 * */
	[RemoteClass(alias="com.viewscenes.bean.RadioMarkZstViewBean")]
	public class RadioMarkZstViewBean extends BaseBean
	{
		
		
		public var mark_id:String =  "";
		public var mark_user:String =  "";
		public var mark_datetime:String =  "";
		public var head_code:String =  "";
		public var equ_code:String =  "";
		public var frequency:String =  "";
		public var runplan_id:String =  "";
		public var counti:String =  "";
		public var counto:String =  "";
		public var counts:String =  "";
		public var description:String =  "";
		public var mark_type:String =  "";
		public var edit_user:String =  "";
		public var unit:String =  "";
		public var mark_file_url:String =  "";
		public var file_name:String =  "";
		public var file_length:String =  "";
		public var record_start_time:String =  "";
		public var record_end_time:String =  "";
		public var station_id:String =  "";
		public var station_name:String =  "";
		public var headname:String =  "";
//		public var language_name:String =  "";
		public var play_time:String =  "";
		public var task_id:String =  "";
		public var task_name:String =  "";
		public var level_value:String =  "";
		public var fm_value:String =  "";
		public var am_value:String =  "";
		public var offset_value:String =  "";
		public var remark:String =  "";
		
		// 下面是语音识别回来的结果数据
		public var asr_type:String = "";
		public var result_type:String = "";
		public var status:String = "";
		public var wavelen:String = "";
		public var musicratio:String = "";
		public var noiseratio:String = "";
		public var speechlen:String = "";
		public var totalcm:String = "";
		public var audibilityscore:String = "";
		public var audibilityconfidence:String = "";
		public var channelname:String = "";
		public var channelnameconfidence:String = "";
		public var programname:String = "";
		public var programnameconfidence:String = "";
		public var languagename1:String = "";
		public var languagename2:String = "";
		public var languagename3:String = "";
		public var languagename4:String = "";
		public var languagename5:String = "";
		public var languageconfidence1:String = "";
		public var languageconfidence2:String = "";
		public var languageconfidence3:String = "";
		public var languageconfidence4:String = "";
		public var languageconfidence5:String = "";
		
		
		public function RadioMarkZstViewBean()
		{
		}
	}
}