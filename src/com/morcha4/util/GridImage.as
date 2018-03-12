package com.morcha4.util
{
	import com.morcha4.util.ScaleBitmap;
	
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	import mx.states.SetStyle;
	
	import spark.primitives.supportClasses.GraphicElement;
	
	public class GridImage extends UIComponent
	{
		public function GridImage()
		{
			super();
		}
		private var sbm:ScaleBitmap;
		private var _source:Object;
		public function set source(value:Object):void{
			_source=value;
			if(!value){
				if(sbm){
					sbm.bitmapData.dispose();
					if(contains(sbm))this.removeChild(sbm);
				}
				return;
			}
			var ins:Object=new value;
			var bitmapData:BitmapData;
			bitmapData = new BitmapData(ins.width, ins.height, true, 0);
			bitmapData.draw(ins as IBitmapDrawable, new Matrix());
			if(sbm){
				sbm.bitmapData.dispose();
				if(contains(sbm))this.removeChild(sbm);				
			}
			sbm=new ScaleBitmap(bitmapData);
			if(!this.hasEventListener(ResizeEvent.RESIZE)){
				this.addEventListener(ResizeEvent.RESIZE,function (e:ResizeEvent):void{sbm.width=width;sbm.height=height});
			}
			this.addChild(sbm);
			if(width>0){
				sbm.width=this.width;
				sbm.height=this.height;
			}
			if(ins.scale9Grid){
				scale9Grid=ins.scale9Grid;
			}
		}
		public function get source():Object{
			return _source;
		}
//		override public function styleChanged(styleProp:String):void{
//			super.styleChanged(styleProp);
//			this.source=getStyle('source');
//			var s:Rectangle=(new (getStyle('source'))).scale9Grid;
////			if(_grid){
////				scale9Grid=_grid;
////			}
//			if(s){
//				scale9Grid=s;
//			}
//		}
		override public function set width(value:Number):void{
			super.width=value;
			sbm.width=value;
		}
		override public function set height(value:Number):void{
			super.height=value;
			sbm.height=value;
		}
		private var _grid:Rectangle;
		override public function set scale9Grid(innerRectangle:Rectangle):void{
			if(sbm)sbm.scale9Grid=innerRectangle;
			_grid=innerRectangle;
			
		}
	}
}