package com.viewscenes.utils.flipBar
{
	import flash.events.Event;
	public class FlipEvent extends Event
	{
		public var data:Object;
		public static const Flip_PAGECHANGE:String="flip_pagechange";//分页组件被用户操作；
		public function FlipEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,data:Object=null)
		{
			super(type, bubbles, cancelable);
			this.data=data;
		}

	}
}