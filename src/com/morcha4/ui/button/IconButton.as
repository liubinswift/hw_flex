package com.morcha4.ui.button
{
	import com.morcha4.skin.button.IconButtonSkin;
	
	import spark.components.Button;
	import spark.primitives.BitmapImage;

	[Style(name="overSrc", inherit="no", type="Class")]
	[Style(name="upSrc", inherit="no", type="Class")]
	[Style(name="downSrc", inherit="no", type="Class")]
	public class IconButton extends Button
	{
		public function IconButton()
		{
			super();
			setStyle("skinClass",IconButtonSkin);
		}
		[SkinPart]
		public var img:BitmapImage;
		private var _source:Object;
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
		override protected function partAdded(partName:String, instance:Object):void{
			super.partAdded(partName,instance);
			if(instance==img){
				img.source=source;
			}
		}
	}
}