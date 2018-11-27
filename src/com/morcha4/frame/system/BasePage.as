package com.morcha4.frame.system
{
	import com.morcha4.frame.BasePageSkin;
	
	import mx.events.FlexEvent;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.modules.Module;
	import spark.skins.spark.SkinnableContainerSkin;

	/**
	 * 页面被切换为当前页面
	 */ 
	[Event(name="PAGE_SHOW", type="flash.events.Event")]
	/**
	 * 页面被关闭
	 */ 
	[Event(name="PAGE_CLOSE", type="flash.events.Event")]
	/**
	 * 页面被外部呼叫
	 */ 
	[Event(name="PAGE_CALL", type="flash.events.Event")]
	/**
	 * 背景渐变色
	 */
	[Style(name="backgroundColor1", inherit="no", type="uint")]
	[Style(name="backgroundColor2", inherit="no", type="uint")]
	
	public class BasePage  extends Module
	{
		public static const SHOW:String="PAGE_SHOW";
		public static const CLOSE:String="PAGE_CLOSE";
		public static const CALL:String="PAGE_CALL";
		/**
		 * 页面逻辑路径
		 */ 
		public var path:String;
		/**
		 * 页面加载路径
		 */ 
		public var url:String;
		/**
		 * 本页面在配置文件中的配置信息
		 */ 
		[Bindable]public var config:XML;
		/**
		 * 切换到本页面时附带的参数
		 */ 
		public var param:Object;
		/**
		 * 是否使用定义的皮肤(背景图，背景色)
		 */
		public var useSkin:Boolean = true;
		public function BasePage()
		{
			this.addEventListener(FlexEvent.CREATION_COMPLETE,createOver);
			
		}
		private function createOver(event:FlexEvent):void{
			if(useSkin){
				this.setStyle("skinClass",BasePageSkin);
			}
		}
	}
}