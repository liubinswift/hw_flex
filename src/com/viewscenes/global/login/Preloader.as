package com.viewscenes.global.login
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.preloaders.IPreloaderDisplay;
	import mx.states.SetStyle;
	
	public class Preloader extends Sprite implements IPreloaderDisplay
	{
		public function Preloader()
		{
			super();
			
			createAndAddChildren();
		}
		
		private var _timer:Timer;
		
		private var _showingDisplay:Boolean = false;
		
		private var _downloadComplete:Boolean = false;
		
		protected var initProgressTotal:uint = 4;
		
		private var _initProgressCount:uint = 0;
		
		protected var DOWNLOAD_PERCENTAGE:uint = 90;
		
		private var _backgroubdAlpha:Number;
		
		public function get backgroundAlpha():Number
		{
			return _backgroubdAlpha;
		}
		
		public function set backgroundAlpha(value:Number):void
		{
			_backgroubdAlpha = value;
		}
		
		private var _backgroundColor:Number;
		
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		
		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
		}
		
		private var _backgroundImage:Object;
		
		public function get backgroundImage():Object
		{
			return _backgroundImage;
		}
		
		public function set backgroundImage(value:Object):void
		{
			_backgroundImage = value;
		}
		
		private var _backgroundSize:String;
		
		public function get backgroundSize():String
		{
			return _backgroundSize;
		}
		
		public function set backgroundSize(value:String):void
		{
			_backgroundSize = value;
		}
		
		private var _stageHeight:Number;
		
		public function get stageHeight():Number
		{
			return _stageHeight;
		}
		
		public function set stageHeight(value:Number):void
		{
			_stageHeight = value;
		}
		
		private var _stageWidth:Number;
		
		public function get stageWidth():Number
		{
			return _stageWidth;
		}
		
		public function set stageWidth(value:Number):void
		{
			_stageWidth = value;
		}
		
		private var _loader:Sprite;
		
		public function set preloader(value:Sprite):void
		{
			_loader = value;
			
			value.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			value.addEventListener(Event.COMPLETE, completeHandler);
			
			value.addEventListener(RSLEvent.RSL_PROGRESS, rslProgressHandler);
			value.addEventListener(RSLEvent.RSL_COMPLETE, rslCompleteHandler);
			value.addEventListener(RSLEvent.RSL_ERROR, rslErrorHandler);
			
			value.addEventListener(FlexEvent.INIT_PROGRESS, initProgressHandler)
			value.addEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
			
			show();
		}
		
		public function initialize():void
		{
			_timer = new Timer(1);
			_timer.addEventListener(TimerEvent.TIMER, refresh);
			_timer.start();
		}
		
//		private var background:PreloaderBackground;
		
		private var logo:PreloaderLogo;
		
		private var text:TextField = new TextField();
		
		private var progressText:TextField;
		
		private function createBackground():PreloaderBackground{
			var bg:PreloaderBackground = new PreloaderBackground();
			bg.x = 0;
			bg.y = 0;
			return bg;
		}
		
		private function createLogo():PreloaderLogo{
			var logo:PreloaderLogo = new PreloaderLogo();
			logo.x = (720/2) - (194/2);
			logo.y = 365;
			return logo;
		}
		
		private function createProgressText():TextField{
			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			tf.font = "Arial";
			tf.color = 0xFFFFFF;
			tf.size = 18;
			var text:TextField = new TextField();
			text.defaultTextFormat = tf;
			text.selectable = false;
			text.width = 130;
			text.x = 590;
			text.y = 445;
			text.text = "aaaaa";
			return text;
		}
		
		protected function createAndAddChildren():void{
//			SetStyle(this,"backgroundColor",0x000000);
			//Add Background;
//			background = createBackground();
//			addChild(background);
			
			//Add Logo;
			logo = createLogo();
			addChild(logo);
			
			//Add Text;
			progressText = createProgressText();
			addChild(progressText);
			
			setDownloadProgress(0);
			
			visible = _showingDisplay;
		}
		
		private function show():void{
			if(! _showingDisplay){
				if (stageWidth == 0 && stageHeight == 0)
				{
					try
					{
						stageWidth = stage.stageWidth;
						stageHeight = stage.stageHeight
					}
					catch (e:Error)
					{
						stageWidth = loaderInfo.width;
						stageHeight = loaderInfo.height;
					}
					if (stageWidth == 0 && stageHeight == 0)
						return;
				}
				
				_showingDisplay = true;
				resetPosition();
//				logo
			}
		}
		
		private function resetPosition():void{
//			x = (stage.stageWidth/2) - (1200/2);
//			y = (stage.stageHeight/2) - (768/2);
			logo.x = (stage.stageWidth/2) - (214/2);
			logo.y = (stage.stageHeight/2) - (72/2);
			progressText.x = (stage.stageWidth/2) - (130/2)-10;
			progressText.y = (stage.stageHeight/2)+100;
			visible = true;
		}
		
		protected function refresh(e:Event):void{
			logo.refreshAlpha();
		}
		
		private function setDownloadProgress(completed:Number, total:Number = Number.MAX_VALUE):void{
			completed = Math.min(completed, total);
			
			var prog:Number = completed / total * DOWNLOAD_PERCENTAGE;
			
			setBarText(prog);
		}
		
		private function setInitProgress(completed:Number, total:Number = Number.MAX_VALUE):void{
			completed = Math.min(completed, total);
			
			var prog:Number = completed / total * (100 - DOWNLOAD_PERCENTAGE) + DOWNLOAD_PERCENTAGE;
			
			setBarText(prog);
		}
		
		private function setBarText(progress:int):void{
			progress = Math.min(progress, 100);
			progress = Math.max(progress, 0);
			
			progressText.text = "Loading " + String(progress) + "%";
		}
		
		protected function progressHandler(e:ProgressEvent):void{
			var loaded:uint = e.bytesLoaded;
			var total:uint = e.bytesTotal;
			
			if(! _showingDisplay){
				show();
			}
			
			setDownloadProgress(loaded, total);
		}
		
		protected function completeHandler(e:Event):void{
			_downloadComplete = true;
		}
		
		protected function rslProgressHandler(e:RSLEvent):void{
			
		}
		
		protected function rslCompleteHandler(e:RSLEvent):void{
			
		}
		
		protected function rslErrorHandler(e:RSLEvent):void{
			
			_loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.removeEventListener(Event.COMPLETE, completeHandler);
			
			_loader.removeEventListener(RSLEvent.RSL_PROGRESS, rslProgressHandler);
			_loader.removeEventListener(RSLEvent.RSL_COMPLETE, rslCompleteHandler);
			_loader.removeEventListener(RSLEvent.RSL_ERROR, rslErrorHandler);
			
			_loader.removeEventListener(FlexEvent.INIT_PROGRESS, initProgressHandler)
			_loader.removeEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
			
		}
		
		protected function initProgressHandler(e:Event):void{
			_initProgressCount ++;
			
			if(! _showingDisplay){
				show();
			}
			
			setInitProgress(_initProgressCount, initProgressTotal);
		}
		
		protected function initCompleteHandler(e:Event):void{
			
			dispatchEvent(new Event(Event.COMPLETE));
			_timer.removeEventListener(TimerEvent.TIMER, refresh);
			_timer.stop();
		}
		
	}


}