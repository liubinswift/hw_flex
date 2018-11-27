package com.morcha4.ui.contaners
{
	import com.morcha4.ui.skins.TitleContainerSkin;
	
	import spark.components.Label;

	public class TitleContainer extends BorderContainer
	{
		[Bindable]
		[SkinPart(required="false")]
		
		public var title:Label;
		public function TitleContainer()
		{
			super();
			setStyle("skinClass",TitleContainerSkin);
		}
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
			}
		}
	}
}