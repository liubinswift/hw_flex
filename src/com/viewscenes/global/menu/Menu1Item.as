package com.viewscenes.global.menu
{
	import com.morcha4.frame.menu.ImgMenuItem;
	import com.morcha4.frame.menu.ImgMenuItemSkin;
	import com.morcha4.frame.nav.NavManager;
	import com.morcha4.frame.nav.NavParam;
	import com.morcha4.frame.system.AdvancedEvent;
	import com.morcha4.util.XMLUtil;
	
	import flash.events.MouseEvent;
	
	import mx.states.SetStyle;

	public class Menu1Item extends ImgMenuItem
	{
		public function Menu1Item()
		{
			super();
			setStyle("skinClass",ImgMenuItemSkin);
		}
		override protected function onClick(e:MouseEvent):void{
			NavManager.getInstance().dispatchEvent(new AdvancedEvent(NavManager.MODULE_NAV,false,false,new NavParam(null,null,
				XMLUtil.getFNodeByAttribute(dataProvider,'select','true',"node",false))));
		}
	}
}