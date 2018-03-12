package com.morcha4.ui.contaners.layout
{
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	
	public class VRollContainer extends Group
	{
		public function VRollContainer()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,init);
			this.addEventListener(MouseEvent.ROLL_OVER,onOver);
			this.addEventListener(MouseEvent.ROLL_OUT,onOut);
			clipAndEnableScrolling=true;
		}
		public function set position (i:int):void{
			sp=i;
			gcon.verticalScrollPosition=sp;
		}
		private var sp:int;
		private var gcon:Group;
		public var rang:int=10;
		private function init(e:FlexEvent):void{
			gcon=getChildByName("con") as Group;
			gcon. clipAndEnableScrolling=true;
		}
		private function onOver(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			sp=gcon.verticalScrollPosition;
		}
		private function onOut(e:MouseEvent):void{
			removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			gcon.verticalScrollPosition=sp;
		}
		private function onMove(e:MouseEvent):void{
			if(height<gcon.height){
				if(mouseY<rang){
					gcon.verticalScrollPosition=0;
				}else if(mouseY+rang>height){
					gcon.verticalScrollPosition=gcon.height-height;
				}else{
					gcon.verticalScrollPosition=(mouseY-rang)*((gcon.height-height)/(height-2*rang));
				}
			}else{
				gcon.verticalScrollPosition=0;
			}
		}
	}
}