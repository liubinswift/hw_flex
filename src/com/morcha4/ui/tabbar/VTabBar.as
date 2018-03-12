package com.morcha4.ui.tabbar
{
	import spark.components.TabBar;
	
	public class VTabBar extends TabBar
	{
		public function VTabBar()
		{
			super();
			setStyle("skinClass",VTabBarSkin);
		}
	}
}