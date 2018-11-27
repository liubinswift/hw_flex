package com.viewscenes.utils.player.playBar
{
	import flash.events.Event;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.SliderEvent;
	
	import spark.components.HSlider;
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	
	[Event(name="play", type="com.viewscenes.utils.player.playBar.PlayBarEvent")]
	[Event(name="stop", type="com.viewscenes.utils.player.playBar.PlayBarEvent")]
	[Event(name="volume", type="com.viewscenes.utils.player.playBar.PlayBarEvent")]
	[Event(name="pause", type="com.viewscenes.utils.player.playBar.PlayBarEvent")]
	[Event(name="full", type="com.viewscenes.utils.player.playBar.PlayBarEvent")]
	[Event(name="time", type="com.viewscenes.utils.player.playBar.PlayBarEvent")]
	
	public class playBarNew extends SkinnableContainer
	{
		[Bindable]private var _time_total:int=0;
		[Bindable]private var _time_curr:int=0;
		//		[Bindable]private var timeTip:String="00:00:00/00:00:00";
		
		[Bindable]
		[SkinPart(required="true")]
		public var playButton:IStateAble;
		[Bindable]
		[SkinPart(required="true")]
		public var stopButton:IStateAble;
		[Bindable]
		[SkinPart(required="true")]
		public var jyButton:IStateAble;
		[Bindable]
		[SkinPart(required="true")]
		public var fullButton:IStateAble;
		[Bindable]
		[SkinPart(required="true")]
		public var volume_slider:HSlider;
		[Bindable]
		[SkinPart(required="true")]
		public var text:rolltext;
		[Bindable]
		[SkinPart(required="true")]
		public var time_slider:HSlider;
		[SkinPart(required="true")]
		public var timeTipL:Label;
		public function playBarNew()
		{
			super();
			this.setStyle("skinClass",PlayBarSkinNew);
			this.addEventListener("jingyin",onEventCome);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,init);
//			timeTipL.visible=false;
//			timeTipL.includeInLayout=false;
		}
		private function init(e:FlexEvent):void{
			this.status="stop";
			//			time_go();
		}
		public function get status():String{
			return _status;
		}
		private function onEventCome(e:PlayBarEvent):void{
			e.stopPropagation();
			switch(e.type){
				case "jingyin":{
					if(e.data){
						this.dispatchEvent(new PlayBarEvent("volume",true,false,0));
						volume_slider.enabled=false;
					}else{
						this.dispatchEvent(new PlayBarEvent("volume",true,false,volume_slider.value));
						volume_slider.enabled=true;
					}
					break;
				}
			}
		}
		
		public function setText(t:String,speed:int=5,color:int=0x000000):void{
			text.setpro(t,speed,color);
		}
		override protected function partAdded(partName:String, instance:Object):void{
			switch(partName){
				case "playButton":{
					break;
				}
				case "stopButton":{
					break;
				}
				case "jyButton":{
					break;
				}
				case "timeTipL":{
					timeTipL.text="00:00:00/00:00:00"
					break;
				}
				case "time_slider":{
					time_slider.maximum=this._time_total;
					break;
				}
			}
		}
		override protected function getCurrentSkinState():String{
			return _mode=="record"?"record":"realtime";
		}
		public function set time_total(total:int):void{
			_time_total=total;
			if(time_slider){
				time_slider.maximum=_time_total;
			}
			changeTimeLabel();
		}
		public function set time_curr(curr:int):void{
			_time_curr=curr;
			if(time_slider){
				time_slider.value=_time_curr;
			}
			changeTimeLabel();
		}
		public function get time_curr():int{
			return _time_curr;
		}
		private var inner:uint;
		public function time_go():void{
			clearInterval(inner);
			inner=setInterval(go,1000);
		}
		public function time_stop():void{
			clearInterval(inner);
		}
		private function go():void{
			time_curr+=1;
			if(_time_curr==_time_total){
				clearInterval(inner);
				//				time_curr = 0;	//播放完成后复位
				dispatchEvent(new PlayBarEvent("stop",true));
			}
			
		}
		private function changeTimeLabel():void{
			if(timeTipL)timeTipL.text=getStr(_time_curr)+"/"+getStr(_time_total);
		}
		public function getStr(i:int):String{
			var temp:int=i%3600;
			var str:String=((i-temp)/3600).toString();
			str=str.length==1?("0"+str):str;
			i=temp;
			temp=i%60;
			var tempstr:String=((i-temp)/60).toString();
			tempstr=tempstr.length==1?(":0"+tempstr):(":"+tempstr);
			str+=tempstr;
			tempstr=temp.toString();
			tempstr=tempstr.length==1?(":0"+tempstr):(":"+tempstr);
			str+=tempstr;
			return str;
		}
		public function ontimechange(e:Event):void{
			time_curr=(e.target as HSlider).value;
			//			time_stop();
			dispatchEvent(new PlayBarEvent("time",true,true,(e.target as HSlider).value));
		}
		
		private var _mode:String;
		public function set mode(value:String):void{
			_mode=value;
			invalidateSkinState();
		}
		public function get mode():String{
			return currentState;
		}
		private var _status:String;
		public function set status(value:String):void{
			_status=value;
			switch(value){
				case "geturl":{
					if(time_slider)time_slider.enabled=false;
					playButton.status="~play";
					stopButton.status="stop";
					jyButton.status="disable";
					volume_slider.enabled=false;
					fullButton.status="~full";
					break;
				}
				case "play":{
					if(time_slider)time_slider.enabled=true;
					jyButton.status="~jy";
					volume_slider.enabled=true;
					fullButton.status="full";
					if(this._mode=="record"){
						playButton.status="pause";
						stopButton.status="stop";
					}else{
						playButton.status="~play";
						stopButton.status="stop";
					}
					break;
				}
				case "pause":{
					if(time_slider)time_slider.enabled=false;
					playButton.status="play";
					stopButton.status="stop";
					jyButton.status="disable";
					volume_slider.enabled=false;
					fullButton.status="~full";
					break;
				}
				case "stop":{
					if(time_slider)time_slider.enabled=false;
					jyButton.status="disable";
					volume_slider.enabled=false;
					playButton.status="play";
					stopButton.status="~stop";
					fullButton.status="~full";
					break;
				}
				case "disable":{
					if(time_slider)time_slider.enabled=false;
					jyButton.status="disable";
					volume_slider.enabled=false;
					playButton.status="~play";
					stopButton.status="~stop";
					fullButton.status="~full";
					break;
				}
			}
		}
	}
}