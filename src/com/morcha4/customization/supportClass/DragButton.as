package com.morcha4.customization.supportClass
{
	import com.morcha4.customization.supportClass.DragFactor;
	import com.morcha4.ui.button.IconButton;
	
	import flash.events.MouseEvent;
	
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.managers.DragManager;
	
	import spark.components.Button;
	import spark.components.ButtonBar;
	import spark.components.Label;
	import spark.primitives.Line;
	
	public class DragButton extends IconButton
	{
		public var _data:Object;
		private var _type:String;
		private var _format:String;
		private var _tip:String;
		private var df:DragFactor;

		public function get tip():String
		{
			return _tip;
		}

		public function set tip(value:String):void
		{
			invalidateProperties();
			_tip = value;
		}

		public function get format():String
		{
			return _format;
		}

		public function set format(value:String):void
		{
			invalidateProperties();
			_format = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			invalidateProperties();
			_type = value;
		}

		public function set data(value:Object):void{
			invalidateProperties();
			_data=value;
		}
		public function get data():Object{
			return _data;
		}
		override protected function commitProperties():void{
			df.data=data;
			df.format=format;
			df.tip=tip;
			df.type=type;
			super.commitProperties();
		}
		public function DragButton()
		{
			super();
			df=new DragFactor(this);
		}
	}
}