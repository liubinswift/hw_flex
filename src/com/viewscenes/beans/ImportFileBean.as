package com.viewscenes.beans
{
	[RemoteClass(alias="com.viewscenes.bean.ImportFileBean")]
	public class ImportFileBean extends BaseBean
	{
		public var id:String = "";
		public var file_name:String = "";
		public var file_size:String = "";
		public var file_path:String = "";
		public var date:String = "";
		public var flag:String = "";
		public function ImportFileBean()
		{
		}
	}
}


