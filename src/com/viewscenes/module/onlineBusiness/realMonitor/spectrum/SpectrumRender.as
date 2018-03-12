package com.viewscenes.module.onlineBusiness.realMonitor.spectrum
{ 
	
	import com.viewscenes.module.onlineBusiness.realMonitor.quality.LineSeriesNew;
	
	import flashx.textLayout.formats.Float;
	
	import mx.charts.renderers.LineRenderer;
	import mx.charts.series.items.LineSeriesItem;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.graphics.IStroke;

	/** 
	 * @author zyh 
	 * @explain:  
	 * @version 1.0.0 
	 * 创建时间：2012-2-23 下午04:27:38 * 
	 */  
	public class SpectrumRender extends LineRenderer
	{
		public function SpectrumRender()
		{
			super();
		}
		private var _data:Object;
		private var f:Boolean=false;
		override public function set data(value:Object):void{
			if(value){
				if(_data==value){
					return;
				}else{
					_data=super.data=value;
					f=true;
				}
			}else{
				return;
			}
		}
		override protected function updateDisplayList(unscaledWidth:Number,
													  unscaledHeight:Number):void
		{
			//				super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(!f){
				return;
			}else{
				f=false;
			}
			var usedUI:SpectrumDrawing = (this.parent as LineSeriesNew).usedUi as SpectrumDrawing;
			if(usedUI == null){
				return;
			}
			
			var stroke:IStroke = getStyle("lineStroke");
			var form:String = getStyle("form");
			
			graphics.clear();
			
			var items:Array = data.items as Array;
			var perious:int=0;//0:前一值在门限下，1：前一值在门限上，
			//频谱图，画竖线，超过门限变红
			for(var i:int=0;i<items.length;i++){
				//取每个数据点
				var seriesItem:LineSeriesItem = items[i] as LineSeriesItem;
				var yvalue:Number = new Number(seriesItem.yValue.toString());
				//画连续折线时使用，设置画笔初始位置，
				//移动画笔到X轴（x,0）位置。
				graphics.moveTo(seriesItem.x,usedUI.ZeroX);
								if(yvalue>usedUI._threshold){
									graphics.lineStyle(1,0xFF0000,1);
								}else{
									graphics.lineStyle(1,0x00FF00,1);
								}
//				graphics.lineStyle(1,0x33CC33,1);
				graphics.lineTo(seriesItem.x,seriesItem.y);
			}
		}
	}
} 