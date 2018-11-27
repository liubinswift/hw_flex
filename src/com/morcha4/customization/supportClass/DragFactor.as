package com.morcha4.customization.supportClass
{
	import flash.events.MouseEvent;
	
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.managers.DragManager;
	
	import spark.components.Label;

	public class DragFactor
	{
		public var data:Object;
		public var type:String;
		public var format:String;
		public var tip:String;
		private var target:UIComponent;
		public function DragFactor(ui:UIComponent,format:String=null,tip:String=null,
								   type:String=null,data:Object=null)
		{
			target=ui;
			this.format=format;
			this.tip=tip;
			this.type=type;
			this.data=data;
			target.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		private function onMouseDown(e:MouseEvent):void{
			target.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			target.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		private function onMouseUp(e:MouseEvent):void{
			target.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			target.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		private function onMouseMove(e:MouseEvent):void{
			target.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			var label:Label=new Label;
			label.height=20;
			label.text=tip;
			DragManager.doDrag(target,getDragSource(),e,label,-1*e.localX/2,label.height-1*e.localY);
		}
		protected function getDragSource():DragSource{
			var ds:DragSource=new DragSource;
			ds.addData({"type":type,"data":data},format);
			return ds;
		}
	}
}