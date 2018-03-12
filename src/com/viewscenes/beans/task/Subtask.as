package com.viewscenes.beans.task
{
	import mx.collections.ArrayCollection;

	/**
	 * 任务子类
	 * */
	[RemoteClass(alias="com.viewscenes.bean.task.Subtask")]
	public   class Subtask
	{
		public var     sub_task_id:String =  "";
		public var   band:String =  "";
		public var   startfreq:String =  "";
		public var   endfreq:String =  "";
		public var   stepfreq:String =  "";
		public var   task_id:String =  "";
		public var   from_runplan:String =  "";
		public var   is_delete:String =  "";
		public var   equ_code:String =  "";
		public var   freq:String =  "";
		public var   bps:String =  "";
		public var   station_name:String =  "";
		public var   language:String =  "";
		
		public var   cyctask:ArrayCollection=new ArrayCollection();
		public var   sintask:ArrayCollection=new ArrayCollection();
		
		public   function Subtask()
		{
		}
	}
}