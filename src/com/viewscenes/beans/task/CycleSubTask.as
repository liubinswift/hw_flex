package com.viewscenes.beans.task
{
	/**
	 * 循环任务子类。
	 * */
	[RemoteClass(alias="com.viewscenes.bean.task.CycleSubTask")]
	public   class CycleSubTask
	{
		public   function CycleSubTask()
		{
		}
		public var   time_id:String =  "";
		public var   dayofweek:String =  "";
		public var   starttime:String =  "";
		public var   endtime:String =  "";
		public var   reportmode:String =  "";
		public var   reportinterval:String =  "";
		public var   reporttime:String =  "";
		public var   expiredays:String =  "";
		public var   sub_task_id:String =  "";
		
		
	}
}