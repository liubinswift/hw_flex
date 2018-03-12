package com.viewscenes.beans
{
	public class BaseBean extends Object
	{
		/**
		 * 开始行 分页组件用到 不用赋值
		 */
		public var startRow:int = 0;
		/**
		 * 结束行 分页组件用到 不用赋值
		 */
		public var endRow:int = 200;
		/**
		 * datagrid中一行是否被选中
		 */
		public var isSelected:String = "false";
		
		public function BaseBean()
		{
			super();
		}
	}
}