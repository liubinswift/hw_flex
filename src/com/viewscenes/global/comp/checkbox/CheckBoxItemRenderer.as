package com.viewscenes.global.comp.checkbox
{
	import flash.events.Event;
	import flash.events.MouseEvent; 
	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	import mx.controls.listClasses.ListBase;
	import mx.events.ListEvent;
	import mx.utils.ArrayUtil;
	import mx.controls.Alert;
	
	public class CheckBoxItemRenderer extends CheckBox{      
		private var currData:Object;      
		public function CheckBoxItemRenderer(){
			super();
			this.addEventListener(Event.CHANGE,onClickCheckBox);        
		}
		
		override public function set data(value:Object):void{
			if(value == null)
				return;
			this.selected = value.selected;
			this.currData = value; 
			this.label=value.label;         
		}
		override public function set enabled(value:Boolean):void{
			if(currData){
				value=currData.enabled==false?false:true;
			}
			super.enabled=value;         
		}
		
		override public function get data():Object{
			return this.currData;
		}
		
		private function onClickCheckBox(e:Event):void{    
			var listBase:ListBase = ListBase(listData.owner);
			var selectedItems:Array = listBase.selectedItems;       
			var arr:ArrayCollection = listBase.dataProvider as ArrayCollection;
			var len:int = arr.length;
			var check:CheckBoxItemRenderer;
			var index:int = arr.getItemIndex(currData);
			currData.selected = this.selected;
			if(currData.value == "all"){
				var obj:Object = arr.getItemAt(0);
				for(var i:int =1; i<len; i++){
					check = listBase.indexToItemRenderer(i) as CheckBoxItemRenderer;
					if(check){
						check.selected = this.selected;
						check.data.selected = this.selected;
					}else arr.getItemAt(i).selected = obj.selected;
				}
			}else{
//				check = listBase.indexToItemRenderer(0) as CheckBoxItemRenderer;
//				
//				if(check){
//					check.selected = false;
//				}
//				else arr.getItemAt(0).selected = false;
			}
			listBase.dispatchEvent(new ListEvent(ListEvent.CHANGE,false,false,0,index,"",this));         
		}              
	}
}