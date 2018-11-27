package com.morcha4.ui.contaners
{
	import com.morcha4.ui.skins.PanelContainerSkin;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.SWFLoader;
	
	import spark.components.Button;
	import spark.components.Label;

	[Style(name="iconSource", inherit="no", type="String")]
	[Style(name="labelStyle", inherit="no", type="String")]
	[Event(name="close", type="flash.events.Event")]
	/**
	 * 在BorderContainer的基础上可选的提供了一个icon、title及关闭按钮
	 * @author lvb
	 */	
	public class PanelContainer extends BorderContainer
	{
		[Bindable]
		[SkinPart(required="false")]
		
		public var icon:SWFLoader;
		[Bindable]
		[SkinPart(required="false")]
		
		public var title:Label;
		[Bindable]
		[SkinPart(required="false")]
		
		public var closeButton:Button;
		public function PanelContainer()
		{
			super();
			setStyle("skinClass",PanelContainerSkin);
		}
		[Bindable]public var showCloseButton:Boolean=false;
		[Bindable]public var titleLeft:Boolean=true;
		private var _titleText:String;
		public function set titleText(value:String):void{
			_titleText=value;
			if(title){
				title.text=value;
			}
		}
		public function get titleText():String{
			return _titleText;
		}
		override protected function partAdded(partName:String, instance:Object):void{
			switch(partName){
				case "title":
					title.text=titleText;
					break;
				case "closeButton":
					closeButton.addEventListener(MouseEvent.CLICK,onClose);
					break;
			}
		}
		override protected function partRemoved(partName:String, instance:Object):void{
			switch(partName){
				case "closeButton":
					closeButton.removeEventListener(MouseEvent.CLICK,onClose);
					break;
			}
		}
		private function onClose(event:MouseEvent):void{
			this.dispatchEvent(new Event("close",false,false));
		}
	}
}