package com.viewscenes.beans
{
	import com.viewscenes.beans.runplan.RunplanBean;

	/**
	 * 数据库查询录音文件
	 */ 
	[RemoteClass(alias="com.viewscenes.bean.RadioStreamResultBean")]
	public class RadioStreamResultBean extends BaseBean
	{
		public var  result_id:String = "";
		public var  band:String = "";
		public var  task_id:String = "";
		public var  start_datetime:String = "";
		public var  end_datetime:String = "";
		public var  frequency:String = "";
		public var  filename:String = "";
		public var  filesize:String = "";
		public var  head_id:String = "";
		public var  url:String = "";
		public var  report_type:String = "";
		public var  is_stored:String = "";
		public var  is_delete:String = "";
		public var  store_datetime:String = "";
		public var  mark_file_name:String = "";
		public var  runplan_id:String = "";
		public var  equ_code:String = "";
		public var  stationName:String = "";//用户下任务时手动添加的发射台名称
		public var  language:String = "";//用户下任务时手动添加的语言
		
		public var fmModulation:String = "";
		public var amModulation:String = "";
		public var offset:String = "";
		public var levelValue:String = "";
		public var shortname:String = "";
		
		public var  is_temporary="";//区别临时和效果
		
		
		public var  runplanBean:RunplanBean;// = new RunplanBean();//录音相关联的运行图
		public var  radioMarkZstViewBean:RadioMarkZstViewBean;// = new RadioMarkZstViewBean();//录音相关联的打分
		public function RadioStreamResultBean()
		{
		}
	}
}