package com.morcha4.ui.tabbar
{
	import spark.components.ButtonBarButton;
	[Style(name="selectSource", inherit="no", type="Class")]
	[Style(name="source", inherit="no", type="Class")]
	[Style(name="overSource", inherit="no", type="Class")]
	[Style(name="selectColor", inherit="no", type="uint",format="Color")]
	[Style(name="jLeft", inherit="no", type="Class")]
	[Style(name="jRight", inherit="no", type="Class")]
	[Style(name="jTop", inherit="no", type="Class")]
	[Style(name="jBottom", inherit="no", type="Class")]
	[Style(name="numCol", inherit="no", type="uint")]
	public class VButtonBarButton extends ButtonBarButton
	{
		
		public function VButtonBarButton()
		{
			super();
		}
	}
}