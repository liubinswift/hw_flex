package com.morcha4.util
{
	import com.morcha4.rederer.ButtonRenderer;
	import com.morcha4.rederer.CheckBoxRenderer;
	import com.morcha4.rederer.DropDownButtonRenderer;
	
	import mx.core.ClassFactory;

	public class RendererUtil
	{
		public function RendererUtil()
		{
		}
		public static function getButtonRenderer(label:String,callBack:Function=null,labelField:String=null):ClassFactory{
			var f:ClassFactory=new ClassFactory(ButtonRenderer);
			f.properties={l:label,callBack:callBack,labelField:labelField};
			return f;
		}
		
		public static function getCheckBoxRenderer(callBack:Function=null):ClassFactory{
			var f:ClassFactory=new ClassFactory(CheckBoxRenderer);
			f.properties={callBack:callBack};
			return f;
		}
		public static function getDropDwonButtonRenderer(label:String,callBack:Function=null,callBackDrop:Function=null,labelField:String=null):ClassFactory{
			var f:ClassFactory=new ClassFactory(DropDownButtonRenderer);
			f.properties={l:label,callBack:callBack,callBackDrop:callBackDrop,labelField:labelField};
			return f;
		}
	}
}