package com.morcha4.frame.interfaces
{
	import com.morcha4.frame.system.AdvancedEvent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	import mx.core.Container;
	import mx.core.IVisualElementContainer;
	import mx.events.EffectEvent;

	public interface ITransEffect
	{
		//只可设置显隐，不可设置加减
		function play(source:DisplayObject,dest:DisplayObject,target:IVisualElementContainer=null):void;
		/**
		 * 效果播放完毕后调用
		 */ 
		function tranEnd(e:EffectEvent):void;
//		{
//			//删除相关元素
//			PageFrame.getInstance().dispatchEvent(new AdvancedEvent(PageFrame.TRANSFORM_EFFECT_END));
//		}
	}
}