package com.viewscenes.utils.player.playBar
{
	import flash.events.Event;
	
	public class PlayBarEvent extends Event
	{
		public var data:Object;
		public function PlayBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,data:Object=null)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}

	}
}