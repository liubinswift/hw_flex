package com.morcha4.ui.contaners
{
	import com.morcha4.ui.skins.SimpleContainerSkin;
	
	import spark.components.Scroller;
	import spark.components.SkinnableContainer;

	
	[Style(name="paddingLeft", type="Number", format="int", inherit="no", theme="spark")]
	[Style(name="paddingRight", type="Number", format="int", inherit="no", theme="spark")]
	[Style(name="paddingTop", type="Number", format="int", inherit="no", theme="spark")]
	[Style(name="paddingbottom", type="Number", format="int", inherit="no", theme="spark")]
	
	/**
	 * 简单的容器，只有布局功能。
	 * 本类提供了对滚动条良好的支持。
	 * @author lvb
	 * 
	 */	
	public class SimpleContainer extends SkinnableContainer
	{
		[Bindable]
		[SkinPart(required="true")]
		
		public var scrollBar:Scroller;
		public function SimpleContainer()
		{
			super();
			setStyle("skinClass",SimpleContainerSkin);
		}
		/**
		 *可选值为off、on、auto(默认值)
		 */		
		public var horizontalScrollPolicy:String;
		/**
		 *可选值为off、on、auto(默认值)
		 */	
		public var verticalScrollPolicy:String;
		private var wHChange:Boolean=true;
		override public function set width(value:Number):void{
			super.width=value;
			wHChange=true;
		}
		override public function set height(value:Number):void{
			super.height=value;
			wHChange=true;
		}
		override public function set percentWidth(value:Number):void{
			super.percentWidth=value;
			wHChange=true;
		}
		override public function set percentHeight(value:Number):void{
			super.percentHeight=value;
			wHChange=true;
		}
		override protected function commitProperties():void{
			super.commitProperties();
			if(wHChange){
				if(isNaN(explicitWidth)&&isNaN(percentWidth)){
					scrollBar.setStyle("horizontalScrollPolicy","off");
				}else{
					scrollBar.setStyle("horizontalScrollPolicy",horizontalScrollPolicy?horizontalScrollPolicy:"auto");
				}
				if(isNaN(explicitHeight)&&isNaN(percentHeight)){
					scrollBar.setStyle("verticalScrollPolicy","off");
				}else{
					scrollBar.setStyle("verticalScrollPolicy",verticalScrollPolicy?verticalScrollPolicy:"auto");
				}
				wHChange=false;
			}
		
		}
		
	}
}