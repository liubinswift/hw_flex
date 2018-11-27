package com.morcha4.customization
{
	import com.morcha4.customization.CustomizationManager;
	import com.morcha4.customization.percentPlacePan;
	import com.morcha4.customization.supportClass.Blank;
	import com.morcha4.customization.supportClass.Config;
	import com.morcha4.customization.supportClass.HDividedPlace;
	import com.morcha4.customization.supportClass.VDividedPlace;
	
	import flash.events.Event;
	
	import mx.containers.Box;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.VerticalLayout;
	import spark.primitives.Rect;

	public class RootPercentPlacePan extends percentPlacePan
	{
		private var t:Blank;t2:Config;
		public function RootPercentPlacePan()
		{
			super();
			this.clipAndEnableScrolling=true;
			this.addEventListener(FlexEvent.CREATION_COMPLETE,init);
		}
		public function init(e:Event):void{
			this.configPan.delBtn.enabled=false;
		}
		public function set dataProvider(value:XML):void{
			if(!value||value.toString()==""){
				content=null;
				if(!isLeaf){
					this.removeElement(this.getChildByName(dbName) as IVisualElement);
					changeState(true);
				}
			}else{
				processNode(value,this);
			}
		}
		public function get dataProvider():XML{
			getDataProvider();
			return _dataProvider;
		}
		private var _dataProvider:XML;
		private function getDataProvider():void{
			_dataProvider=new XML("<root/>")
			processUI(this,_dataProvider);
		}
		private function processUI(ui:percentPlacePan,data:XML):void{
			if(ui.isLeaf){
				data.@isLeaf="true";
				if(!ui.hasContent){
					data.appendChild(new XML("<config id=\"space\"/>"));
				}else{
					data.appendChild(ui.Config);
				}
			}else{
				var uix:Object=ui.getChildByName(percentPlacePan.dbName);
				if(uix["leftM"]>-1){
					data.@leftM=uix["leftM"].toString();
				}else if(uix["rightM"]>-1){
					data.@rightM=uix["rightM"].toString();
				}else{
					data.@leftPercent=uix["leftPercent"].toString();
				}
				if(uix is HDividedPlace){
					data.@dir="H";
				}else{
					data.@dir="V";
				}
				var xml1:XML=new XML(<node/>);
				var xml2:XML=new XML(<node/>);
				data.appendChild(xml1);
				data.appendChild(xml2);
				processUI(uix["leftChild"],xml1);
				processUI(uix["rightChild"],xml2);
			}
		}
		private function processNode(data:XML,ui:percentPlacePan):void{
			if(data.@isLeaf=="true"){
				ui.changeState(true);
				ui.content=(data.config.length()==0||data.config[0].@id=="space")?null:data.config[0];
			}else if(data.node.length()==2){
				ui.changeState(false);
				var uix:Object;
				if(data.@dir=="H"){
					uix=new HDividedPlace;
				}else{
					uix=new VDividedPlace;
				}
				uix.name=dbName;
				ui.addElement(uix as IVisualElement);
				if(data.@leftM.length()!=0){
					uix["leftM"]=parseInt(data.@leftM.toString());
				}else if(data.@rightM.length()!=0){
					uix["rightM"]=parseInt(data.@rightM.toString());
				}else if(data.@leftPercent.length()!=0){
					uix["leftPercent"]=parseInt(data.@leftPercent.toString());
				}
				processNode(data.node[0],uix["leftChild"]);
				processNode(data.node[1],uix["rightChild"]);
			}
		}
		override protected function createChildren():void{
//			const g:Group=new Group;
//			g.percentHeight=g.percentWidth=100;
//			var r:Rect=new Rect();
//			r.percentHeight=r.percentWidth=100;
//			r.fill=new SolidColor();
//			r.radiusX=r.radiusY=8;
//			g.addElement(r);
//			this.addElement(g);
//			mask=g;
			super.createChildren();
		}
	}
}