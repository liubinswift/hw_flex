package com.morcha4.frame.transEffects
{
	import com.morcha4.util.UISnapshot;
	import com.morcha4.frame.PageFrame;
	import com.morcha4.frame.TempPage;
	import com.morcha4.frame.interfaces.ITransEffect;
	import com.morcha4.frame.system.AdvancedEvent;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.core.Container;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.graphics.ImageSnapshot;
	
	import spark.effects.Wipe;
	
	public class WipeEffect implements ITransEffect
	{
		private var source:DisplayObject;
		private var dest:DisplayObject;
		public function play(source:DisplayObject, dest:DisplayObject,target:IVisualElementContainer=null):void{
			target=PageFrame.getInstance().pageFrameInstance;
			this.source=source;
			this.dest=dest;
			source.visible=false;
			var eff:Wipe=new Wipe;
			eff.duration=500;
			eff.bitmapFrom=ImageSnapshot.captureBitmapData(source);
			eff.bitmapTo=ImageSnapshot.captureBitmapData(dest);
			eff.addEventListener(EffectEvent.EFFECT_END,tranEnd);
			eff.play([target]);
		}
		public function tranEnd(e:EffectEvent):void{
			dest.visible=true;
			PageFrame.getInstance().dispatchEvent(new AdvancedEvent(PageFrame.TRANSFORM_EFFECT_END));
		}
	}
}