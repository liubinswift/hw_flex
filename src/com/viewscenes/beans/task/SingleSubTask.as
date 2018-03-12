package com.viewscenes.beans.task
{
	[RemoteClass(alias="com.viewscenes.bean.task.SingleSubTask")]
	public   class SingleSubTask
	{
		/**
		 * 单次任务子类。
		 * */
		public var   time_id:String =  "";
		public var   reportmode:String =  "";
		public var   reportinterval:String =  "";
		public var   reporttime:String =  "";
		public var   startdatetime:String =  "";
		public var   enddatetime:String =  "";
		public var   expiredays:String =  "";
		public var   sub_task_id:String =  "";
		public   function SingleSubTask()
		{
		}
	}
}