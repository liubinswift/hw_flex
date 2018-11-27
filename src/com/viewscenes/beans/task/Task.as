package com.viewscenes.beans.task
{
	import com.viewscenes.beans.BaseBean;
	
	import mx.collections.ArrayCollection;

	/**
	 * 任务主类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.task.Task")]
	 public class Task extends BaseBean
	{
	
		public function Task()
		{
			
		
	
		}
		public var  task_id:String =  "";
		public var  equ_code:String =  "";
		public var  head_code:String =  "";
		public var  shortname:String =  "";
		
		public var  is_delete:String =  "";
		public var  valid_startdatetime:String =  "";
		public var  valid_enddatetime:String =  "";
		public var  check_level:String =  "";
		public var   check_fm_modulation:String =  "";
		public var   check_am_modulation:String =  "";
		public var  check_fm_modulation_max:String =  "";
		public var  check_offset:String =  "";
		public var   check_bandwidth:String =  "";
		public var  unit:String =  "";
		public var   samples_number:String =  "";
		public var  is_send:String =  "";
		public var  is_delaysend:String =  "";
		public var  delaysend_datetime:String =  "";
		public var  recordlength:String =  "";
		public var  expiredays:String =  "";
		public var  sleeptime:String =  "";
		public var  send_times:String =  "";
		public var  note:String =  "";
		public var  runplan_id:String =  "";
		public var  batch_no:String =  "";
		public var  is_active:String =  "";
		public var   priority:String =  "";
		public var   quality_sleeptime:String =  "";
		public var   stream_sleeptime:String =  "";
		public var   offset_sleeptime:String =  "";
		public var   spectrum_sleeptime:String =  "";
		public var   is_temporary:String =  "";
		public var   bps:String =  "";
		public var   create_user:String =  "";
		public var   send_user:String =  "";
		public var   authentic_status:String =  "";
		public var   authentic_user:String =  "";
		public var   send_datetime:String =  "";
		public var   task_type:String =  "";
		public var   freq:String =  "";
		public var   validDate:String =  "";
		public var   check_alarm:String = "";
		public var   start:String =  "";
		public var   end:String =  "";
		public var  subtask:ArrayCollection=new ArrayCollection();
		
		public var  head_type_id:String ="";//站点类型 101采集点 102遥控站
		public var  record_type:String ="";//运行图录音任务类型 质量 录音
		public var  play_time:String ="";//关联运行图的播音时间
		public var  station_name:String ="";//发射台 (其实子任务表中的字段，方便页面查询显示，这里也放了)
		public var  language:String ="";//语言(其实子任务表中的字段，方便页面查询显示，这里也放了)
}}