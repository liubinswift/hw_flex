package com.morcha4.frame.system
{
	import flash.events.Event;
	
	public class AdvancedEvent extends Event
	{
		public var data:Object;
		public function AdvancedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,data:Object=null)
		{
			this.data=data;
			super(type, bubbles, cancelable);
		}
	}
}