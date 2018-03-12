package com.viewscenes.module.onlineBusiness.realMonitor.quality
{
	import mx.charts.LineChart;
	import mx.charts.renderers.LineRenderer;
	import mx.charts.series.items.LineSeriesItem;
	import mx.controls.Alert;
	import mx.graphics.IStroke;

	public class QualityRender extends LineRenderer
	{
		
		/**
		 * X轴对应页面像素位置
		 */
//		public  var ZeroX:Number			=0;
		
		
		private var linecolorhight:uint = 0xFF0000;//高出门限线的颜色
		private var linecolorlower:uint = 0x369CFF;//低于门限线的颜色
		private var linewdith:Number = 2.4;//画线的宽度
		
		public var chartType:String = "";
		public var headType:String = "";
		public function QualityRender()
		{
			super();
		}
		

		override protected function updateDisplayList(unscaledWidth:Number,
												  unscaledHeight:Number):void
		{
//				super.updateDisplayList(unscaledWidth, unscaledHeight);
			var usedUI:QualityDrawing = (this.parent as LineSeriesNew).usedUi as QualityDrawing;
			if(usedUI == null){
				return;
			}
			var stroke:IStroke = getStyle("lineStroke");
			var form:String = getStyle("form");
			
			//一、折线
			//1、带宽指标 	Y：0~200	 	X:时间		Y单位：KHZ带宽					OK
			//2、频偏指标		Y:-100~100,	X:时间		Y单位：HZ频偏		2条门限,			OK
			//3、最大调制度 	Y:-150~150,	X:时间		Y单位: KHZ		4条门限,2条折线
			//4、调幅度		Y:0~100, 	X:时间		Y单位: %调幅度	2条门限,			OK
			//5、载波电平		Y:0~255,	X:时间		Y单位: uV						图像/伴音载波电平/差、载噪比		OK
			//6、载频频偏		Y:-100~100,	X:时间		Y单位：HZ载频频偏	2条门限,
			//7、李沙育
			//二、竖线
			//8、瞬时调制度分布		Y:-60~0,	 X:-150~150 X单位：KHZ调制度
			graphics.clear();
			
			var items:Array = data.items as Array;
			var fx:int=0;
			var fy:int=0;
			var perious:int=0;//0:前一值在门限下，1：前一值在门限上，
			
		
				if(usedUI._levelType == "B"){		//2条门限
					//频谱图，画竖线，超过门限变红
					for(var ii:int=0;ii<items.length;ii++){
						var seriesItemII:LineSeriesItem = items[ii] as LineSeriesItem;
						var yvalueII:Number = parseFloat(seriesItemII.yValue.toString());
						if(ii==0){
							fx = seriesItemII.x;
							fy = seriesItemII.y;
							graphics.moveTo(fx,fy);
							if(yvalueII>usedUI.threshold||yvalueII<usedUI.thresholdD){
								perious = 1;
							}
						}
//						var holdline:Number = yvalueII>usedUI.threshold?usedUI.thresholdY:usedUI.thresholdDY;
						
						
						if(yvalueII>usedUI.threshold||yvalueII<usedUI.thresholdD){
							var periouseitem:LineSeriesItem = items[ii-1] as LineSeriesItem;
							if(ii>0){
								//前一值在门限外，当前值在另一门限外，要变色
								if(yvalueII>usedUI.threshold&&(parseFloat(periouseitem.yValue.toString())<usedUI.thresholdD)){
									graphics.lineTo((periouseitem.x+(seriesItemII.x-periouseitem.x)/3),usedUI.thresholdDY-9);
									graphics.lineStyle(linewdith,linecolorlower,1);
									graphics.lineTo((periouseitem.x+(2*(seriesItemII.x-periouseitem.x)/3)),usedUI.thresholdY-9);
								}else if(yvalueII<usedUI.thresholdD&&(parseFloat(periouseitem.yValue.toString())>usedUI.threshold)){
									graphics.lineTo((periouseitem.x+(seriesItemII.x-periouseitem.x)/3),usedUI.thresholdY-9);
									graphics.lineStyle(linewdith,linecolorlower,1);
									graphics.lineTo((periouseitem.x+(2*(seriesItemII.x-periouseitem.x)/3)),usedUI.thresholdDY-9);
								}
							}
							
							if(perious==0){//前一值在门限里，当前值在门限外，要变色	
								
	//							var y:Number = periouseitem.y+(seriesItem.y-periouseitem.y)/2;
								var x:Number = periouseitem.x+(seriesItemII.x-periouseitem.x)/2;
	//							var x:Number = usedUI.thresholdY/k;
//								graphics.lineTo(x,usedUI.thresholdY-9);
								if(yvalueII>usedUI.threshold){
									graphics.lineTo(x,usedUI.thresholdY-9);
								}else if(yvalueII<usedUI.thresholdD){
									graphics.lineTo(x,usedUI.thresholdDY-9);
								}
								
//								graphics.lineTo(x,holdline);
							}
							graphics.lineStyle(linewdith,linecolorhight,1);
							perious =1;
						}else{
							if(perious==1){
								var periouseitem3:LineSeriesItem = items[ii-1] as LineSeriesItem;
								var x2:Number = periouseitem3.x+(seriesItemII.x-periouseitem3.x)/2;
								
								if(parseFloat(periouseitem3.yValue.toString())>usedUI.threshold){
									graphics.lineTo(x2,usedUI.thresholdY-9);
								}else if(parseFloat(periouseitem3.yValue.toString())<usedUI.thresholdD){
									graphics.lineTo(x2,usedUI.thresholdDY-9);
								}
//								graphics.lineTo(x2,holdline);
							}
							graphics.lineStyle(linewdith,linecolorlower,1);
							perious =0;
						}
						graphics.lineTo(seriesItemII.x,seriesItemII.y);
					}
				} else if (usedUI._levelType == "C"){
					for(var ii2:int=0;ii2<items.length;ii2++){
						var seriesItemII2:LineSeriesItem = items[ii2] as LineSeriesItem;
						var yvalueII2:Number = parseFloat(seriesItemII2.yValue.toString());
						
						if(ii2==0){
							//Alert.show(usedUI.thresholdD+"--"+usedUI.threshold2);
							fx = seriesItemII2.x;
							fy = seriesItemII2.y;
							if(yvalueII2>usedUI.thresholdD||yvalueII2<usedUI.threshold2){
								graphics.lineStyle(linewdith,linecolorhight,1);
							}
							graphics.moveTo(fx,fy);
						}
//						var holdline:Number = yvalueII2>usedUI.threshold?usedUI.thresholdY:usedUI.thresholdDY;
						if(ii2>0){  //usedUI.thresholdY2 下线 usedUI.thresholdDY 上限
							var periouseitem2:LineSeriesItem = items[ii2-1] as LineSeriesItem;
							if((parseFloat(periouseitem2.yValue.toString())<usedUI.threshold2)){//第一点小于下限
								if(yvalueII2<usedUI.threshold2){//第二点小于下限
								//空
									graphics.lineStyle(linewdith,linecolorhight,1);
								} else if(yvalueII2>usedUI.threshold){//第二点大于上限
									graphics.lineStyle(linewdith,linecolorhight,1);
									graphics.lineTo((periouseitem2.x+(seriesItemII2.x-periouseitem2.x)/3),usedUI.thresholdY2);
									graphics.lineStyle(linewdith,linecolorlower,1);
									graphics.lineTo((periouseitem2.x+(2*(seriesItemII2.x-periouseitem2.x)/3)),usedUI.thresholdY-9);
									graphics.lineStyle(linewdith,linecolorhight,1);
								} else{//第二点在上限和下限之间
									graphics.lineStyle(linewdith,linecolorhight,1);
									graphics.lineTo((periouseitem2.x+(seriesItemII2.x-periouseitem2.x)/2),usedUI.thresholdY2);
									graphics.lineStyle(linewdith,linecolorlower,1);
								}
							} else if((parseFloat(periouseitem2.yValue.toString())>usedUI.threshold)){//第一点大于上限
								if(yvalueII2<usedUI.threshold2){//第二点小于下限
									graphics.lineStyle(linewdith,linecolorhight,1);
									graphics.lineTo((periouseitem2.x+(seriesItemII2.x-periouseitem2.x)/3),usedUI.thresholdY-9);
									graphics.lineStyle(linewdith,linecolorlower,1);
									graphics.lineTo((periouseitem2.x+(2*(seriesItemII2.x-periouseitem2.x)/3)),usedUI.thresholdY2);
									graphics.lineStyle(linewdith,linecolorhight,1);
								} else if(yvalueII2>usedUI.threshold){//第二点大于上限
									graphics.lineStyle(linewdith,linecolorhight,1);
								} else{//第二点在上限和下限之间
									graphics.lineStyle(linewdith,linecolorhight,1);
									graphics.lineTo((periouseitem2.x+(seriesItemII2.x-periouseitem2.x)/2),usedUI.thresholdY-9);
									graphics.lineStyle(linewdith,linecolorlower,1);
								}
							} else {//第一点在上限和下限之间
								if(yvalueII2<usedUI.threshold2){//第二点小于下限
									graphics.lineStyle(linewdith,linecolorlower,1);
									graphics.lineTo((periouseitem2.x+(seriesItemII2.x-periouseitem2.x)/2),usedUI.thresholdY2);
									graphics.lineStyle(linewdith,linecolorhight,1);
								} else if(yvalueII2>usedUI.threshold){//第二点大于上限
									graphics.lineStyle(linewdith,linecolorlower,1);
									graphics.lineTo((periouseitem2.x+(seriesItemII2.x-periouseitem2.x)/2),usedUI.thresholdY-9);
									graphics.lineStyle(linewdith,linecolorhight,1);
								} else{//第二点在上限和下限之间
									graphics.lineStyle(linewdith,linecolorlower,1);
								}
							}
							graphics.lineTo(seriesItemII2.x,seriesItemII2.y);
						}
					}
				} else if(usedUI._levelType == "D"){	//4条门限
					//频谱图，画竖线，超过门限变红
					for(var JJ:int=0;JJ<items.length;JJ++){
						var seriesItemJJ:LineSeriesItem = items[JJ] as LineSeriesItem;
						var yvalueJJ:Number = parseFloat(seriesItemJJ.yValue.toString());
						if(JJ==0){
							fx = seriesItemJJ.x;
							fy = seriesItemJJ.y;
							graphics.moveTo(fx,fy);
//							if(yvalueJJ>usedUI.threshold||yvalueJJ<usedUI.thresholdD){
//								perious = 1;
//							}
							if(((yvalueJJ>usedUI.threshold||yvalueJJ<usedUI.thresholdD)&&yvalueJJ>0)
							||((yvalueJJ>usedUI.threshold2||yvalueJJ<usedUI.thresholdD2)&&yvalueJJ<0)){
								perious = 1;
							}
							
							if(yvalueJJ>=usedUI.threshold || usedUI.threshold<=usedUI.thresholdD){
								graphics.lineStyle(linewdith,linecolorlower,1);
							} else{
								graphics.lineStyle(linewdith,linecolorlower,1);
							}
						} else{
							var periouseitemJJ:LineSeriesItem = items[JJ-1] as LineSeriesItem;
							//大于0的线条
							if(yvalueJJ>=0){
								//前一值大于高门限
								if(parseFloat(periouseitemJJ.yValue.toString())>usedUI.threshold){
									//当前值小于低门限 
									if(yvalueJJ<usedUI.thresholdD){
//										graphics.lineStyle(linewdith,linecolorhight,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/3),usedUI.thresholdY-9);
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(2*(seriesItemJJ.x-periouseitemJJ.x)/3)),usedUI.thresholdDY-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
										
									} else if(yvalueJJ>=usedUI.thresholdD){//当前值大于等于低门限 
										//当前值大于等于高门限
										if(yvalueJJ>=usedUI.threshold){
										} else if(yvalueJJ<usedUI.threshold){//当前值小于等于高门限
											graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdY-9);
											graphics.lineStyle(linewdith,linecolorlower,1);
											
										}
									}
								} else if(parseFloat(periouseitemJJ.yValue.toString())<usedUI.thresholdD){//前一值小于低门限
									//当前值大于高门限 
									if(yvalueJJ>usedUI.threshold){
										//										graphics.lineStyle(linewdith,linecolorhight,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/3),usedUI.thresholdDY-9);
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(2*(seriesItemJJ.x-periouseitemJJ.x)/3)),usedUI.thresholdY-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
										graphics.lineTo(seriesItemJJ.x,seriesItemJJ.y);
										
									}  else if(yvalueJJ<=usedUI.threshold){//当前值小于等于高门限 
										//当前值小于等于低门限
										if(yvalueJJ<=usedUI.thresholdD){
										} else { 
											graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdDY-9);
											graphics.lineStyle(linewdith,linecolorlower,1);
											
										}
									}
								} //前一值等于高门限
								else if(parseFloat(periouseitemJJ.yValue.toString())==usedUI.threshold){
									//当前值小于低门限 
									if(yvalueJJ<usedUI.thresholdD){
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdDY-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
										
									} //当前值大于高门限 
									else  if(yvalueJJ>=usedUI.threshold){
										graphics.lineStyle(linewdith,linecolorhight,1);
									} else{
										graphics.lineStyle(linewdith,linecolorlower,1);
									}
								}//前一值等于低门限
								else if(parseFloat(periouseitemJJ.yValue.toString())==usedUI.thresholdD){
									//当前值小于等于低门限 
									if(yvalueJJ<=usedUI.thresholdD){
										graphics.lineStyle(linewdith,linecolorhight,1);
										
									} //当前值大于高门限 
									else  if(yvalueJJ>usedUI.threshold){
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdY-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
									} else{
										graphics.lineStyle(linewdith,linecolorlower,1);
									}
								} else{//当前值在高低门限之间
									//当前值小于低门限 
									if(yvalueJJ<usedUI.thresholdD){
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdDY-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
									}///当前值大于高门限 
									else  if(yvalueJJ>usedUI.threshold){
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdY-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
									}
								}
							}
							
							//小于0的线条
							if(yvalueJJ<=0){
								//前一值大于高门限
								if(parseFloat(periouseitemJJ.yValue.toString())>usedUI.thresholdD2){
									//当前值小于低门限 
									if(yvalueJJ<usedUI.threshold2){
										//										graphics.lineStyle(linewdith,linecolorhight,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/3),usedUI.thresholdDY2-9);
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(2*(seriesItemJJ.x-periouseitemJJ.x)/3)),usedUI.thresholdY2-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
										
									} else if(yvalueJJ>=usedUI.threshold2){//当前值大于等于低门限 
										//当前值大于等于高门限
										if(yvalueJJ>=usedUI.thresholdD2){
										} else if(yvalueJJ<usedUI.thresholdD2){//当前值小于等于高门限
											graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdDY2-9);
											graphics.lineStyle(linewdith,linecolorlower,1);
											
										}
									}
								} else if(parseFloat(periouseitemJJ.yValue.toString())<usedUI.threshold2){//前一值小于低门限
									//当前值大于高门限 
									if(yvalueJJ>usedUI.thresholdD2){
										//										graphics.lineStyle(linewdith,linecolorhight,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/3),usedUI.thresholdY2-9);
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(2*(seriesItemJJ.x-periouseitemJJ.x)/3)),usedUI.thresholdDY2-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
										graphics.lineTo(seriesItemJJ.x,seriesItemJJ.y);
										
									}  else if(yvalueJJ<=usedUI.thresholdD2){//当前值小于等于高门限 
										//当前值小于等于低门限
										if(yvalueJJ<=usedUI.threshold2){
										} else { 
											graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdY2-9);
											graphics.lineStyle(linewdith,linecolorlower,1);
											
										}
									}
								} //前一值等于高门限
								else if(parseFloat(periouseitemJJ.yValue.toString())==usedUI.thresholdD2){
									//当前值小于低门限 
									if(yvalueJJ<usedUI.threshold2){
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdY2-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
										
									} //当前值大于高门限 
									else  if(yvalueJJ>=usedUI.thresholdD2){
										graphics.lineStyle(linewdith,linecolorhight,1);
									} else{
										graphics.lineStyle(linewdith,linecolorlower,1);
									}
								}//前一值等于低门限
								else if(parseFloat(periouseitemJJ.yValue.toString())==usedUI.threshold2){
									//当前值小于等于低门限 
									if(yvalueJJ<=usedUI.threshold2){
										graphics.lineStyle(linewdith,linecolorhight,1);
										
									} //当前值大于高门限 
									else  if(yvalueJJ>usedUI.thresholdD2){
										graphics.lineStyle(linewdith,linecolorlower,1);
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdDY2-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
									} else{
										graphics.lineStyle(linewdith,linecolorlower,1);
									}
								} else{//当前值在高低门限之间
									//当前值小于低门限 
									if(yvalueJJ<usedUI.threshold2){
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdY2-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
									}///当前值大于高门限 
									else  if(yvalueJJ>usedUI.thresholdD2){
										graphics.lineTo((periouseitemJJ.x+(seriesItemJJ.x-periouseitemJJ.x)/2),usedUI.thresholdDY2-9);
										graphics.lineStyle(linewdith,linecolorhight,1);
									}
								}
							}
							
							
							graphics.lineTo(seriesItemJJ.x,seriesItemJJ.y);
						
						}
						
						
					}
						
						
						
						
				}else if(usedUI._levelType == "A"){//1条门限:电平指标、载噪比，全是下限
					for(var j:int=0;j<items.length;j++){
						var seriesItemJ:LineSeriesItem = items[j] as LineSeriesItem;
						var yvalueJ:Number = parseFloat(seriesItemJ.yValue.toString());
						if(j==0){
							fx = seriesItemJ.x;
							fy = seriesItemJ.y;
							graphics.moveTo(fx,fy);
							if(yvalueJ<usedUI.threshold2){
								perious = 1;
							}
						}
						if(yvalueJ<usedUI.threshold){
							if(perious==0){//前一值在门限里，当前值在门限外，要变色
								var periouseitemJ:LineSeriesItem = items[j-1] as LineSeriesItem;
								if(periouseitemJ==null)
									continue;
	//							var y:Number = periouseitem.y+(seriesItem.y-periouseitem.y)/2;
								var xJ:Number = periouseitemJ.x+(seriesItemJ.x-periouseitemJ.x)/2;
								
	//							var x:Number = usedUI.thresholdY/k;
								graphics.lineTo(xJ,usedUI.thresholdY-9);
							}
							graphics.lineStyle(1.5,linecolorlower,1);
							perious =1;
						}else{
							if(perious==1){
								var periouseitemJ2:LineSeriesItem = items[j-1] as LineSeriesItem;
								var xJ2:Number = periouseitemJ2.x+(seriesItemJ.x-periouseitemJ2.x)/2;
	
								graphics.lineTo(xJ2,usedUI.thresholdY-9);
							}
							graphics.lineStyle(1.5,linecolorhight,1);
							perious =0;
						}
						graphics.lineTo(seriesItemJ.x,seriesItemJ.y);
					}
				}else{
					graphics.lineStyle(linewdith,linecolorhight,1);
					for(var j0:int=0;j0<items.length;j0++){
						var seriesItemJ0:LineSeriesItem = items[j0] as LineSeriesItem;
						if(j0==0){
							fx = seriesItemJ0.x;
							fy = seriesItemJ0.y;
							graphics.moveTo(fx,fy);
						}
						graphics.lineTo(seriesItemJ0.x,seriesItemJ0.y);
//						if(seriesItemJ0.yValue>YMax){
//							graphics.lineTo(seriesItemJ0.x,MaxY);
//						}else if(seriesItemJ0.yValue<YMin){
//							graphics.lineTo(seriesItemJ0.x,ZeroX);
//						}else{
//							graphics.lineTo(seriesItemJ0.x,seriesItemJ0.y);
//						}
						
					}
					
				}
			}
			
			
			
			
	}
}