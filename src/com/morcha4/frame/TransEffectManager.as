package com.morcha4.frame
{
	import com.morcha4.frame.transEffects.FadeEffect;
	import com.morcha4.frame.transEffects.WipeEffect;
	import com.morcha4.frame.transEffects.maskEffect;
	import com.morcha4.frame.interfaces.ITransEffect;
	
	import mx.effects.MaskEffect;

	public class TransEffectManager
	{
		public function TransEffectManager()
		{
		}
		private static var _instance:TransEffectManager;
		/**
		 * 得到页面切换效果管理器
		 */ 
		public static function getInstance():TransEffectManager{
			if(!_instance){
				_instance=new TransEffectManager();
			}
			return _instance;
		}
		public function getEffect():ITransEffect{
			return new maskEffect;
		}
	}
}