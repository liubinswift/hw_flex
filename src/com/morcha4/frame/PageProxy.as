package com.morcha4.frame
{
	import com.morcha4.frame.interfaces.IProgressNotifyAble;
	import com.morcha4.frame.system.ModuleManager;
	import com.morcha4.frame.system.ProgressEvent;
	
	import flash.events.EventDispatcher;

	public class PageProxy implements IProgressNotifyAble
	{
		public function PageProxy()
		{
		}
		public var url:String;
		private var errorMessage:String;
		private var loaded:Number;
		private var total:Number;
		public var isReady:Boolean=false;
		public function onError(prame:Object):void{
			errorMessage=prame.toString();
			if(isAct){
				target.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS_ERROR,false,false,prame.toString()));
			}
		}
		public function onProgress(loaded:Number,total:Number):void{
			this.loaded=loaded;
			this.total=total;
			if(isAct){
				target.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS_COME,false,false,null,loaded,total));
			}
		}
		public function onReday():void{
			isReady=true;
			if(isAct){
				target.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS_READY,false,false,null,loaded,total));
//				PageProxyManager.getInstance().removeProxy(this.url);
			}
		}
		private var isAct:Boolean=false;
		private var target:EventDispatcher;
		public function activate(target:EventDispatcher,isAct:Boolean):void{
			this.isAct=isAct;
			this.target=target;
			if(isAct){
				if(errorMessage){
					target.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS_ERROR,false,false,this.errorMessage));
				}else if(isReady){
					onReday();
				}else{
					target.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS_COME,false,false,null,this.loaded,this.total));
				}
			}
		}
		public function reload():void{
			errorMessage=null;
			loaded=0;
			total=0;
			isReady=false;
			load(loadUrl);
		}
		private var loadUrl:String;
		public function load(url:String):void{
			loadUrl=url;
			if(ModuleManager.getModule(url,this)){
				onReday();
			}
		}
		public function clear():void{
			this.errorMessage=null;
			this.target=null;
			isAct=false;
		}
	}
}