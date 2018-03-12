package com.morcha4.ui.contaners.layout
{
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;

	public class HRollContainer extends Group
	{
		public function HRollContainer()
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
			sp=gcon.horizontalScrollPosition;
		}
		private function onOut(e:MouseEvent):void{
			removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			gcon.horizontalScrollPosition=sp;
		}
		private function onMove(e:MouseEvent):void{
			if(width<gcon.width){
				if(mouseX<rang){
					gcon.horizontalScrollPosition=0;
				}else if(mouseX+rang>width){
					gcon.horizontalScrollPosition=gcon.width-width;
				}else{
					gcon.horizontalScrollPosition=(mouseX-rang)*((gcon.width-width)/(width-2*rang));
				}
			}else{
				gcon.horizontalScrollPosition=0;
			}
		}
	}
}