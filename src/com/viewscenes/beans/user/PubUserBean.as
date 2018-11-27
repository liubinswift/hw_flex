package com.viewscenes.beans.user
	
{

	/**
	 *@作者:
	 *@创建时间：
	 *
	 **/
	[RemoteClass(alias="com.viewscenes.web.sysmgr.user.PubUserBean")]
	public class PubUserBean
	{
		
		public var userName:String = "";
		public var userId:String = "";
		public var userCode:String = "";
		public var userPassword:String ="";
		public var age:String = "";
		public var sex:String = "";
		public var mobilephone:String = "";
		public var telephone:String = "";
		public var address:String = "";
		public var post	:String = "";
		public var email:String = "";
		public var description:String = "";
		
		public var roleId:String = "";
		public var roleName:String = "";
		public var priority:String = "";
		
		public function PubUserBean()
		{
		}
	}
}