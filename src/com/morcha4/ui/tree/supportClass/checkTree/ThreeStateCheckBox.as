package com.morcha4.ui.tree.supportClass.checkTree
{
	import flash.events.MouseEvent;
	
	import spark.components.CheckBox;
	
	public class ThreeStateCheckBox extends CheckBox
	{
		public function ThreeStateCheckBox()
		{
			super();
			this.setStyle("skinClass",ThreeStateCheckBoxSkin);
		}
		private var _state:String="0";
		public function set state(value:String):void{
			_state=value;
			invalidateSkinState();
		}
		override public function get selected():Boolean{
			return _state=="1";
		}
		override protected function clickHandler(event:MouseEvent):void{
			event.preventDefault();
		}
		override protected function getCurrentSkinState():String{
			if(_state!="2"){
				return super.getCurrentSkinState();
			}else{
				return super.getCurrentSkinState()+"And3State";
			}
		}
	}
}