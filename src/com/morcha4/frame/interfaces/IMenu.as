package com.morcha4.frame.interfaces
{
	public interface IMenu
	{
		/**
		 * 设置数据源
		 */ 
		function set dataProvider(xl:XMLList):void;
		/**
		 * 将menuitem去除外部联系并缓存。必须先将其在其父上remove掉
		 */ 
		function set reuseItem(xl:XMLList):void;
	}
}