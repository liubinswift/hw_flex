package com.morcha4.frame.theme
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.core.FlexGlobals;
	import mx.events.StyleEvent;
	
	import spark.components.Application;

	public class StyleManager
	{
		public function StyleManager()
		{
		}
		private static var dis:IEventDispatcher;
		public static function loadSkin(url:String,progressHandle:Function=null,
										completeHandle:Function=null,errorHandle:Function=null):void{
			if(dis){
				return;
			}
			dis=(FlexGlobals.topLevelApplication as Application).styleManager.loadStyleDeclarations(url);
			dis.addEventListener(StyleEvent.COMPLETE,StyleManager.completeHandle);
			dis.addEventListener(StyleEvent.ERROR,StyleManager.errorHandle);
			if(progressHandle!=null){
				dis.addEventListener(StyleEvent.PROGRESS,progressHandle);
			}
			if(completeHandle!=null){
				dis.addEventListener(StyleEvent.COMPLETE,completeHandle);
			}
			if(errorHandle!=null){
				dis.addEventListener(StyleEvent.ERROR,errorHandle);
			}
		}
		public static function removeSkin(url:String):void{
			(FlexGlobals.topLevelApplication as Application).styleManager.unloadStyleDeclarations(url);
		}
		private static function completeHandle(e:StyleEvent):void{
			dis=null;
		}
		private static function errorHandle(e:StyleEvent):void{
			dis=null;	
		}
		
		
	}
}