package com.morcha4.frame.system
{
	import flash.events.Event;
	
	public class ProgressEvent extends Event
	{
		public static const PROGRESS_ERROR:String="progress_error";
		public static const PROGRESS_COME:String="progress_come";
		public static const PROGRESS_READY:String="progress_ready";
		
		public var errorMessage:String;
		public var loaded:Number;
		public var total:Number;
		public function ProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,
			errorMessage:String=null,loaded:int=0,total:int=0)
		{
			this.errorMessage=errorMessage;
			this.loaded=loaded;
			this.total=total;
			super(type, bubbles, cancelable);
		}
	}
}