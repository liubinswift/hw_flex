package com.viewscenes.global.login
{
	import flash.display.Loader;
	import flash.utils.ByteArray;
	
	public class PreloaderLogo extends Loader
	{
		[Embed(source="com/viewscenes/images/default/global1/logo.png", mimeType="application/octet-stream")]
		public var WelcomeLogo:Class;
		
		private var _plus:Boolean = false;
		
		private const AlphaRate:Number = 0.01;
		
		public function PreloaderLogo()
		{
			this.loadBytes(new WelcomeLogo() as ByteArray);
		}
		
		public function refreshAlpha():void{
			if(alpha < AlphaRate){
				_plus = true;
			}
			else if(alpha > (1 - AlphaRate)){
				_plus = false;
			}
			
			alpha = _plus ? alpha + AlphaRate : alpha - AlphaRate;
		}
		
		public function refreshStop():void{
			alpha = 1;
		}
	}

}