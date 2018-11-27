package com.viewscenes.beans
{
	/**
	 * 设备端录音文件查询返回结果类
	 */ 
	[RemoteClass(alias="com.viewscenes.bean.device.FileQueryResult")]
	public class FileQueryResult extends BaseBean
	{
		public var  resultType:String = "";
		public var  startDateTime:String = "";
		public var  endDateTime:String = "";
		public var  fileURL:String = "";
		public var  taskID:String = "";
		public var  band:String = "";
		public var  freq:String = "";
		public var  size:String = "";
		//在复选框中使用到
//		public var isSelected:String = "false";
		public function FileQueryResult()
		{
		}
	}
}