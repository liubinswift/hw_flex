package com.morcha4.frame.interfaces
{
	/**
	 *可接收进度信息的对象 
	 */ 
	public interface IProgressNotifyAble
	{
		/**
		 *加载过程出错中断
		 */ 
		function onError(prame:Object):void;
		/**
		 *加载过程中定时调度，应迅速返回 
		 */ 
		function onProgress(loaded:Number,total:Number):void;
		/**
		 *加载完成
		 */ 
		function onReday():void;
	}
}