package com.viewscenes.beans
{
	import com.viewscenes.beans.runplan.RunplanBean;
	import com.viewscenes.beans.task.Task;
	
	[RemoteClass(alias="com.viewscenes.bean.device.StreamHistoryQueryResult")]
	public class StreamHistoryQueryResult
	{
		
		
		public var  recordId:String = "";
		public var  taskId:String = "";
		public var  freq:String = "";
		public var  band:String = "";
		public var  equCode:String = "";
		public var  startDateTime:String = "";
		public var  endDateTime:String = "";
		public var  url:String = "";
		public var  fileName:String = "";
		public var  size:String = "";
		
		/**
		 *接口新增加的返回结果值
		 *expireDays 在接口文档中没有该项，现注释掉
		 *2012-08-10 
		 */
		public var level:String = "";	//电平
		public var fmModulation:String = "";//调制度
		public var amModulation:String = "";//调幅度
		public var offset:String = "";		//频偏
		
		public var  task:Task;
		public var runplanBean:RunplanBean;
		
		public function StreamHistoryQueryResult()
		{
		}
	}
}