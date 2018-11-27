package com.morcha4.ui.contaners
{
	import com.morcha4.ui.skins.BorderContainerSkin;

	[Style(name="borderBackground", type="Class", format="Class", inherit="yes", theme="spark")]
	[Style(name="contentGrid", format="Number", type="Array", arrayType="Number",inherit="yes")]
	[Style(name="BGDepth", format="uint", type="uint", inherit="yes")]
	/**
	 * 提供了自定义边框(渐变背景)和拖动功能
	 * @author lvb
	 */	
	public class BorderContainer extends SimpleContainer
	{
		public var dragAble:Boolean=false;
		public function BorderContainer()
		{
			super();
			setStyle("skinClass",BorderContainerSkin);
		}
	}
}