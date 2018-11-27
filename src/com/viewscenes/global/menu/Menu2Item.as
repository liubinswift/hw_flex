package com.viewscenes.global.menu
{
	import com.morcha4.frame.menu.ImgMenuItem;
	import com.morcha4.frame.menu.ImgMenuItemSkin;
	
	import spark.components.Label;
	import spark.components.ToggleButton;
	
	public class Menu2Item extends ImgMenuItem
	{
		public function Menu2Item()
		{
			super();
			setStyle("skinClass",ImgMenuItemSkin);
			
		}
	}
}