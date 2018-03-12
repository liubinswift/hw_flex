package com.viewscenes.beans
{
	import com.viewscenes.beans.runplan.RunplanBean;
	import com.viewscenes.beans.task.Task;

	/**
	 * 设备端录音文件获取返回结果类
	 */ 
	[RemoteClass(alias="com.viewscenes.bean.device.FileRetrieveResult")]
	public class FileRetrieveResult extends BaseBean
	{
		public var  fileUrl:String = "";
		public var  level:String = "";
		public var  fmModulation:String = "";
		public var  amModulation:String = "";
		public var  offset:String = "";
		
		//下面这些属性可通过文件名(fileUrl)称得到
		public var fileName:String = "";
		public var headCode:String = "";
		public var taskId:String = "";
		public var startDatetime:String = "";
		public var endDatetime:String = "";
		public var freq:String = "";
		public var equCode:String = "";
		public var band:String = "";
		private var language:String = "";
		private var recType:String = "";	//录音类型：效果，质量，临时
		
		public var task:Task;	//相关联的TASK对象
		public var runplanBean:RunplanBean;	//相关联的运行图对象
		
		public var result_id:String = "";
		public var filesize = "";
		public var head_id:String = "";
		public var url:String = "";			//转换成本地的MEDIA地址
		public var report_type:String = "";
		public var is_stored:String = "";
		public var store_datetime:String = "";
		public var mark_file_name:String = "";	//与打分数据相关联字段
		public var runplan_id:String = "";
		
		public function FileRetrieveResult()
		{
		}
	}
}