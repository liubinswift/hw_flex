package com.morcha4.frame.menu
{
	import com.morcha4.frame.nav.NavManager;
	import com.morcha4.frame.nav.NavParam;
	import com.morcha4.frame.system.AdvancedEvent;
	import com.morcha4.util.XMLUtil;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	
	import spark.components.ToggleButton;
	import spark.primitives.BitmapImage;

	[Style(name="rollOverSrc", type="Class", format="Class", inherit="yes")]
	[Style(name="overColor", type="uint", format="Class", inherit="yes")]
	[Style(name="selectedColor", type="uint", format="Color", inherit="yes")]
	public class ImgMenuItem extends ToggleButton
	{
		public function ImgMenuItem()
		{
			super();
			addEventListener(MouseEvent.CLICK,onClick);
		}
		protected function onClick(e:MouseEvent):void{
			NavManager.getInstance().dispatchEvent(new AdvancedEvent(NavManager.MODULE_NAV,false,false,new NavParam(null,null,
				XMLUtil.getFNodeByAttribute(dataProvider,'select','true'))));
		}
		[SkinPart]
		public var img:BitmapImage;
		[SkinPart]
		public var imgSelect:BitmapImage;
		private var _source:Object;
		private var _fastSource:Object;
		protected var select:Boolean=false;
		[Bindable]
		public function set source(value:Object):void{
			_source=value;
			if(img){
				img.source=value;
			}
		}
		public function get source():Object{
			return _source;
		}
		[Bindable]
		public function set fastSource(value:Object):void{
			_fastSource=value;
			if(img){
				imgSelect.source=value;
			}
		}
		public function get fastSource():Object{
			return _fastSource;
		}
		override protected function partAdded(partName:String, instance:Object):void{
			super.partAdded(partName,instance);
			if(instance==img){
				img.source=source;
			} else if(instance==imgSelect){
				imgSelect.source=fastSource;
			}
		}
		override public function get selected():Boolean{
			return select;
		}
		private var _dataProvider:XML;
		public var sourceField:String="@source";
		public var fastSourceField:String="@fastSource";
		public var labelField:String="@showLabel";
		public function set dataProvider(xml:XML):void{
			_dataProvider=xml;
			fastSource=xml[fastSourceField].toString();
			source=xml[sourceField].toString();
			label=xml[labelField];
			select=(xml.@select=="true");
			invalidateSkinState();
		}
		public function get dataProvider():XML{
			return _dataProvider;
		}
		public function refresh():void{
			if(_dataProvider.@["enable"]!="false"&&_dataProvider.@["select"]=="true"){
				select=true;
			}else{
				select=false;
			}
			invalidateSkinState();
		}
	}
}