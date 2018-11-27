package com.morcha4.frame.system
{
	import com.morcha4.frame.interfaces.IProgressNotifyAble;
	
	import mx.core.FlexGlobals;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	
	public class ModuleManager
	{
		public function ModuleManager()
		{
			
		}
		private static var dicReadyModules:Object=new Object;
		private static var dicProcessModules:Object=new Object;
		private static var dicCallBack:Object=new Object; 
		public static function getModule(url:String,backObj:IProgressNotifyAble=null):Object{
			if(dicReadyModules[url]!=null){
				var b:Object=(dicReadyModules[url] as IModuleInfo).factory.create();
				return b;
			}else{
				if(dicProcessModules[url]==null){
					var mi:IModuleInfo=mx.modules.ModuleManager.getModule(url);
					dicProcessModules[url]=mi;
					if(dicCallBack[url]==null){
						dicCallBack[url]=new Array();
					}
					if(backObj&&(dicCallBack[url]as Array).indexOf(backObj)<0){
						dicCallBack[url].push(backObj);
					}
					mi.data=url;
					mi.addEventListener(ModuleEvent.ERROR,onError);
					mi.addEventListener(ModuleEvent.PROGRESS,onProgress);
					mi.addEventListener(ModuleEvent.READY,onReady);
					mi.load(null,null,null,FlexGlobals.topLevelApplication.moduleFactory);
				}else{
					if(backObj&&(dicCallBack[url]as Array).indexOf(backObj)<0){
						dicCallBack[url].push(backObj);
					}
				}
				return null;
			}
		}
		private static function onError(e:ModuleEvent):void{
			for each(var back:IProgressNotifyAble in dicCallBack[e.currentTarget.data] as Array){
				back.onError(e.errorText);
			}
			(e.currentTarget as IModuleInfo).unload();
			dicProcessModules[e.currentTarget.data]=null;
			dicCallBack[e.currentTarget.data]=null;
		}
		private static function onProgress(e:ModuleEvent):void{
			for each(var back:IProgressNotifyAble in dicCallBack[e.currentTarget.data] as Array){
				back.onProgress(e.bytesLoaded,e.bytesTotal);
			}
		}
		private static function onReady(e:ModuleEvent):void{
			dicReadyModules[e.currentTarget.data]=dicProcessModules[e.currentTarget.data];
			dicProcessModules[e.currentTarget.data]=null;	
			for each(var back:IProgressNotifyAble in dicCallBack[e.currentTarget.data] as Array){
				back.onReday();
			}
			dicCallBack[e.currentTarget.data]=null;
		}
		
	}
}