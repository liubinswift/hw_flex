package com.morcha4.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.graphics.ImageSnapshot;
	import mx.utils.ObjectUtil;
	
	public class UISnapshot extends UIComponent
	{
		private var ui:Object;
		private var bmd:BitmapData;
		private var bm:ScaleBitmap;
		public function UISnapshot(ui:Object=null)
		{
			super();
			if(ui){
				this.uiC=ui;
			}
		}
		public function set uiC(ui:Object):void{
			this.ui=ui;
			
			getSnapshot();
			
			bm=new ScaleBitmap(bmd);
			width=width==0?bmd.width:width;
			height=height==0?bmd.height:height;
			addChild(bm);
		}
		override public function set width(value:Number):void{
			super.width=value;
			bm.width=value;
		}
		override public function set scale9Grid(innerRectangle:Rectangle):void{
			bm.scale9Grid=innerRectangle;
		}
		override public function set height(value:Number):void{
			super.height=value;
			bm.height=value;
		}
		public function refresh():void{
			getSnapshot();
		}
		private function getSnapshot():void{
			destroy();
			if(ui is DisplayObject){
				bmd=ImageSnapshot.captureBitmapData(ui as DisplayObject);
				if(!bmd){
					Alert.show("此组件还未初始化，无法创建图像\n"+ObjectUtil.toString(ui));
					return;
				}
			}else if(ui is BitmapData){
				bmd=ui as BitmapData;
			}
		}
		public function destroy():void{
			try{
				removeChild(bm);
				bmd.dispose();
			}catch(e:Error){}
		}
	}
}