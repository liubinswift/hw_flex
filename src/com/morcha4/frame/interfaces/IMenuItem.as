package com.morcha4.frame.interfaces
{
	public interface IMenuItem
	{
		/**
		 * 设置数据源
		 */ 
		function set dataProvider(xl:XMLList):void;
		/**
		 * 复位以便重用
		 */ 
		function distroy():void;
	}
}