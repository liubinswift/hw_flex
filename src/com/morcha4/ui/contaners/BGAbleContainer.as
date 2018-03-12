package com.morcha4.ui.contaners
{
	import com.morcha4.ui.skins.BGAbleContainerSkin;
	
	import mx.states.SetStyle;
	
	[Style(name="backgroundColors", format="Number", type="Array", arrayType="Number", inherit="no", theme="spark")]
	[Style(name="backgroundAlphas", format="Number", type="Array", arrayType="Number", inherit="no", theme="spark")]
	[Style(name="backgroundImage", inherit="no", theme="spark")]
	/**
	 * 可选值有clip、repeat及scale 
	 */	
	[Style(name="backgroundImageMode", type="String", format="String", inherit="no", theme="spark")]
	/**
	 * 提供了具有背景填充功能的容器
	 * 可以使用双色渐变填充及位图填充，位图填充可以设置填充方式
	 * 
	 * @author lvb
	 */	
	public class BGAbleContainer extends SimpleContainer
	{
		public function BGAbleContainer()
		{
			super();
			setStyle("skinClass",BGAbleContainerSkin);
		}
		
	}
}