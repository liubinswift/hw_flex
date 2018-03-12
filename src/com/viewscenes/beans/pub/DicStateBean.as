package com.viewscenes.beans.pub
	
{
	import com.viewscenes.beans.BaseBean;

	/**
	 *@作者:
	 *@创建时间：
	 *
	 **/
	//与java后台bean对应时需要这样写 bean中的字段可以不完全一样，但属性命名最好驼峰式命名规则
	[RemoteClass(alias="com.viewscenes.bean.DicStateBean")]
	public class DicStateBean extends BaseBean
	{
		
		public var state:String = "";
		public var state_name:String = "";
		
	}
}