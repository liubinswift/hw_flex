package com.viewscenes.beans
	
{

	/**
	 *@作者:
	 *@创建时间：
	 *
	 **/
	//与java后台bean对应时需要这样写 bean中的字段可以不完全一样，但属性命名最好驼峰式命名规则
	[RemoteClass(alias="com.viewscenes.framework.bean.TestBean")]
	public class TestBean extends BaseBean
	{
		
		public var userName:String = "";
		public var userId:String = "";
		public var code:String = "";
		public var password:String ="";
		public var sex:String = "";
		public var tel:String = "";
		public var address:String = "";
		public var email:String = "";
		public var startTime:String = "";
		public var endTime:String = "";
		
		public var roleId:String = "";
		public var roleName:String = "";
		public var priority:String = "";
		
		public function TestBean()
		{
		}
	}
}