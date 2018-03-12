package com.morcha4.frame.transEffects
{
	import com.morcha4.frame.PageFrame;
	import com.morcha4.frame.interfaces.ITransEffect;
	import com.morcha4.frame.system.AdvancedEvent;
	import com.morcha4.util.UISnapshot;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.core.Container;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.effects.Tween;
	import mx.effects.easing.Bounce;
	import mx.effects.easing.Sine;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.graphics.ImageSnapshot;
	
	import spark.components.Group;
	import spark.effects.CrossFade;
	import spark.effects.Wipe;
	import spark.effects.easing.Linear;
	
	public class maskEffect implements ITransEffect
	{
		private var source:DisplayObject;
		private var dest:DisplayObject;
		private var mmask:Mask=new Mask();
		private var g:Group
		public function play(source:DisplayObject, dest:DisplayObject,target:IVisualElementContainer=null):void{
			this.source=source;this.dest=dest;
			if(!(PageFrame.getInstance().pageFrameInstance as UIComponent).contains(dest as UIComponent)){
				(dest as UIComponent).addEventListener(FlexEvent.UPDATE_COMPLETE,onOK);
				PageFrame.getInstance().pageFrameInstance.addElementAt(dest as UIComponent,0);
			}else{
				setTimeout(play0,10,source,dest);
//				play0(source,dest);
			}
		}
		private function onOK(e:Event):void{
			setTimeout(play0,10,source,dest);
//			play0(source,dest);
			(dest as UIComponent).removeEventListener(FlexEvent.UPDATE_COMPLETE,onOK);
		}
		public function play0(source:DisplayObject, dest:DisplayObject,target:IVisualElementContainer=null):void{
			PageFrame.getInstance().pageFrameInstance.removeElement(dest as UIComponent);
			target=PageFrame.getInstance().pageFrameInstance;
			this.source=source;
			this.dest=dest;
			source.visible=false;
			g=new Group();
			g.clipAndEnableScrolling=false;
			g.percentHeight=g.percentWidth=100;
			var su:UISnapshot=new UISnapshot(source);
			var du:UISnapshot=new UISnapshot(dest);
			//			du.height=(target as UIComponent).height;;du.width=(target as UIComponent).width;
			//			Alert.show(dest.height+"_"+source.height+"_"+(target as UIComponent).height);
			g.addElement(su);
			g.addElement(du);
			target.addElement(g);
			mmask=new Mask(50,500,0.03,PageFrame.direction);PageFrame.direction=true;
			mmask.width=source.width;mmask.height=source.height;
			du.addChild(mmask);
			du.mask=mmask;
			var t:Tween=new Tween(this,0,500,500,40);//duration原来为500
			t.easingFunction=mx.effects.easing.Sine.easeOut;
		}
		public function onTweenUpdate(value:Object):void
		{
			mmask.time=value as Number;
		}
		public function onTweenEnd(value:Object):void
		{
			mmask.time=value as Number;
			tranEnd(null);
		}
		public function tranEnd(e:EffectEvent):void{
			try{
				dest.visible=true;
				(source.parent as Group).removeElement(g);
				PageFrame.getInstance().dispatchEvent(new AdvancedEvent(PageFrame.TRANSFORM_EFFECT_END));
			}catch(e:Error){
				
			}
			
		}
	}
}