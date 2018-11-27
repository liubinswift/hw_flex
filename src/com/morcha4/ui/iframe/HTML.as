package com.morcha4.ui.iframe
{
	import com.morcha4.ui.iframe.IFrame;
	import com.morcha4.ui.iframe.IFrameExternalCalls;
	
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import mx.events.FlexEvent;

	/**
	 * 加载HTML
	 * 1.需要手动设置该组件显示隐藏，使用visible属性即可
	 * 2.必须设置该组件的id属性
	 * 3.callIFrameFunction():js中不需要写document.fun。参数必须传数组类型，js中接收到的也是数组类型。
	 * 4.parent.document.getElementById(ExternalInterface.objectID)[callBackFunName](PList)可以在html中调回flex
	 */ 
	public class HTML extends IFrame
	{
		public function HTML(id:String=null)
		{
			super(id);
			this.addEventListener("frameLoad",init);
		}
		private function init(e:Event):void{
			ExternalInterface.call("document.focus()");
		}
	}
}