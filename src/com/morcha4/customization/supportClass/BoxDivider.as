package com.morcha4.customization.supportClass
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.DividedBox;
	import mx.containers.dividedBoxClasses.BoxDivider;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.DividerEvent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	import mx.graphics.BitmapFillMode;
	import mx.graphics.BitmapScaleMode;
	
	import spark.components.Image;
	
	use namespace mx_internal;
	public class BoxDivider extends UIComponent
	{
		public function BoxDivider()
		{
			super();
			addEventListener(Event.ADDED,onADD);
		}
		private function onADD(e:Event):void{
			DividedBox((parent as mx.containers.dividedBoxClasses.BoxDivider).owner).addEventListener(ResizeEvent.RESIZE,onResize);
		}
		private function onResize(e:Event):void{
			invalidateDisplayList();
		}
		override protected function createChildren():void{
			super.createChildren();
			this.addChild(img);
			this.addChild(img2);
			img.source=getStyle("dividerBG");
			img2.source=getStyle("dividerBTN");
		}
		private var img:Image=new Image;
		private var img2:Image=new Image;
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			img.fillMode=BitmapFillMode.SCALE;
			img.scaleMode=img2.scaleMode=BitmapScaleMode.STRETCH;
			img2.fillMode=BitmapFillMode.CLIP;
			img2.width=34;
			img2.height=4;
			img2.x=((parent as  mx.containers.dividedBoxClasses.BoxDivider).width-img2.width)/2;
			img.y=-1;
			
			this.width=img.width=(parent as  mx.containers.dividedBoxClasses.BoxDivider).width;
			this.height=img.height=6;
			if(!DividedBox((parent as  mx.containers.dividedBoxClasses.BoxDivider).owner).isVertical()){
				img.width=(parent as  mx.containers.dividedBoxClasses.BoxDivider).height;
				img.x=-1*(img.width-Math.round(img.width/2));//-1*img.width/2+2;
				img.width+=(2+(img.width+1)%2);
			}
		}
	}
}