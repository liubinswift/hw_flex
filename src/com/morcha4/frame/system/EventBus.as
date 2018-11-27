package com.morcha4.frame.system
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class EventBus extends EventDispatcher
	{
		public function EventBus(target:IEventDispatcher=null)
		{
			super(target);
		}
		private static var dicBus:Object={};
		private static var _instance:EventBus;
		private static function get instance():EventBus{
			if(!_instance){
				_instance=new EventBus;
			}
			return _instance;
		}
		/**
		 * 添加全局监听器 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * 
		 */		
		public static function addEventListener(type:String, listener:Function, 
			useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void{
			instance.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		/**
		 * 移除全局监听器 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * 
		 */		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void{
			instance.removeEventListener(type,listener,useCapture);
		}
		public static function dispatchEvent(event:Event):Boolean{
			return instance.dispatchEvent(event);
		}
		/**
		 * 获取局部事件调度器 
		 * @param id
		 * @return 
		 * 
		 */		
		public static function getEventBus(id:String):EventBus{
			if(!dicBus[id]){
				dicBus[id]=new EventBus;
			}
			return dicBus[id];
		}
		/**
		 * 销毁局部事件调度器 
		 * @param id
		 * 
		 */		
		public static function destroyEventBus(id:String):void{
			dicBus[id]=null;
		}
		
	}
}