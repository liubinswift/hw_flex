package com.morcha4.customization
{
	import com.morcha4.customization.supportClass.Blank;
	import com.morcha4.frame.system.EventBus;
	
	import flash.utils.getDefinitionByName;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.VerticalLayout;

	public class CustomizationManager
	{
		public function CustomizationManager()
		{
		}
		public static const CONFIG_COMPLETED:String="customization_config_end";
		private static var _config:Object={"red":{"id":"red","classPath":"module::Red","configPath":"module::Config","label":"红色","icon":"red.png","source":"red.png"},
											"black":{"id":"black","classPath":"module::Black","configPath":"module::Config","label":"黑色","icon":"black.png","source":"black.png"},
											"space":{"id":"space","classPath":"module::Blank","configPath":"module::Config","label":"黑色","icon":"black.png","source":"black.png"},
											"write":{"id":"write","classPath":"module::Write","configPath":"module::Config","label":"白色","icon":"write.png","source":"write.png"}}
			
//			<atomLibs>
//											<atom id="red" classPath="module::Red" config="module::Config" label="红色" icon="red.png" source="red.png"/>
//											<atom id="black" classPath="module::Black" config="module::Config" label="黑色" icon="black.png" source="black.png"/>
//											<atom id="write" classPath="module::Write" config="module::Config" label="白色" icon="write.png" source="write.png"/>										
//											<atom id="space" classPath="module::Blank" config="module::Config" label="白色" icon="write.png" source="write.png"/>										
//										</atomLibs>;
		public static function set config(con:Object):void{
			if(con is XML){
				_config=new Object;
				for each(var xml:XML in con.atom){
					_config[xml.@id]={"id":xml.@id,"classPath":xml.@["classPath"],"configPath":xml.@["configPath"],"label":xml.@["label"],"icon":xml.@["icon"],"source":xml.@["source"]};
				}
			}else{
				_config=con;
			}
			_config["space"]={"id":"space","classPath":"com.morcha4.customization.supportClass::Blank","configPath":"com.morcha4.customization.supportClass::Config","name":"空白","icon":"","source":""};
		}
		public static function get config():Object{
			return _config;
		}
		public static function hasAtom(id:String):Boolean{
			return config[id]
		}
		public static function getConfigPan(id:String):UIComponent{
			return new (getDefinitionByName(config[id]["configPath"]));
		}
		public static function getInstance(id:String):UIComponent{
			return new (getDefinitionByName(config[id]["classPath"]));
		}
		public static function getIcon(id:String):String{
			return config[id]["icon"];
		}
		public static function getIMG(id:String):String{
			return config[id]["source"];
		}
		public static function getLabel(id:String):String{
			return config[id]["name"];
		}
		
		public static function creat(dataProvider:XML,ui:Group):void{
			processNode2(dataProvider,ui);
		}
		private static function processNode2(data:XML,ui:Group):void{
			if(data.@isLeaf=="true"){
				fillUIFun(ui,data.config[0]);
			}else if(data.node.length()==2){
				var ui1:Group=new Group;
				var ui2:Group=new Group;
				ui.addElement(ui1);
				ui.addElement(ui2);
				if(data.@dir=="H"){
					ui.layout=new HorizontalLayout;
					ui1.percentHeight=ui2.percentHeight=100;
					if(data.@leftM.length()!=0){
						ui1.width=parseInt(data.@leftM.toString());
						ui2.percentWidth=100;
					}else if(data.@rightM.length()!=0){
						ui2.width=parseInt(data.@rightM.toString());;
						ui1.percentWidth=100;
					}else if(data.@leftPercent.length()!=0){
						ui1.percentWidth=parseInt(data.@leftPercent.toString());
						ui2.percentWidth=100-ui1.percentWidth;
					}
				}else{
					ui.layout=new VerticalLayout;
					ui1.percentWidth=ui2.percentWidth=100;
					if(data.@leftM.length()!=0){
						ui1.height=parseInt(data.@leftM.toString());
						ui2.percentHeight=100;
					}else if(data.@rightM.length()!=0){
						ui2.height=parseInt(data.@rightM.toString());;
						ui1.percentHeight=100;
					}else if(data.@leftPercent.length()!=0){
						ui1.percentHeight=parseInt(data.@leftPercent.toString());
						ui2.percentHeight=100-ui1.percentHeight;
					}
				}
				ui.layout["gap"]=2;
				processNode2(data.node[0],ui1);
				processNode2(data.node[1],ui2);
			}
		}
		public static var fillUIFun:Function=fillUI;
		private static function fillUI(ui:Group,config:XML):void{
			ui.clipAndEnableScrolling=true;
			var uip:UIComponent=CustomizationManager.getInstance(config.@["id"]);
			uip["configXml"]=config;
			(FlexGlobals.topLevelApplication as UIComponent).callLater(function():void{ui.addElement(uip)});
		}
	}
}