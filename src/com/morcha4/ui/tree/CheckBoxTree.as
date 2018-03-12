package com.morcha4.ui.tree
{
	import com.morcha4.frame.system.AdvancedEvent;
	import com.morcha4.ui.tree.supportClass.checkTree.CheckTreeListData;
	import com.morcha4.ui.tree.supportClass.checkTree.CheckTreeRenderer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.controls.Tree;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	import mx.core.ClassFactory;

	[Event(name="selectItemsChanged", type="flash.events.Event")]
	public class CheckBoxTree extends Tree
	{
		
		public function CheckBoxTree()
		{
			super();
			this.itemRenderer=new ClassFactory(CheckTreeRenderer);
			this.addEventListener("checkBoxClick",onCheckBoxClick);
		}
		private function selectChange():void{
			getSelectItems();
			dispatchEvent(new Event("selectItemsChanged"));
		}
		private function get checkedItems():ArrayCollection{
			return _checkedItems;
		}
		private function get checkedBranchItems():ArrayCollection{
			return _checkedBranchItems;
		}
		override public function set dataProvider(value:Object):void{
			return;
		}
		public function selectAll(select:Boolean):void{
			processChildens(dataProvider.source,select?"1":"0");
			selectChange();
		}
		/**
		 * 标识节点是否被选中的字段
		 * 选中字段的值：0未选中、1选中、2中间状态。
		 */ 
		public var checkField:String="@checked";
		private function onCheckBoxClick(e:AdvancedEvent):void{
			e.stopImmediatePropagation();
			if((e.data as CheckTreeListData).checkedState=="1"){
				(e.data as CheckTreeListData).item[checkField]="0";
			}else{
				(e.data as CheckTreeListData).item[checkField]="1";
			}
			processParents((e.data as CheckTreeListData).item);
			processChildens((e.data as CheckTreeListData).item,(e.data as CheckTreeListData).item[checkField]);
			selectChange();
			//invalidateList();
		}
		private function processParents(item:Object):void{
			var item:Object=getParentItem(item);
			if(item){
				var hasChecked:Boolean=false;
				var hasNonChecked:Boolean=false;
				for each(var cItem:Object in item.*){
					if(cItem[checkField].toString()=="0"){
						hasNonChecked=true;
					}else{
						hasChecked=true;					
					}
				}
				if(hasChecked&&hasNonChecked){
					item[checkField]="2";
				}else if(hasChecked){
					item[checkField]="1";
				}else{
					item[checkField]="0";
				}
				processParents(item);
			}
		}
		private function processChildens(item:Object,value:String):void{
			if(item.*.length()!=0){
				for each(var cItem:Object in item.*){
					cItem[checkField]=value;
					processChildens(cItem,value);
				}
			}
		}
		private var _checkedItems:ArrayCollection = new ArrayCollection();  //所有checkbox值为1的叶子节点
		private var _checkedBranchItems:ArrayCollection = new ArrayCollection(); //所有checkbox值不为0的非叶子节点
		private function getSelectItems():void{
			_checkedBranchItems=new ArrayCollection;
			_checkedItems=new ArrayCollection;
			for each(var item:Object in dataProvider.children()){
				processSelectItem(item);
			}
		}
		private function processSelectItem(item:Object):void{
			if(item.*.length()!=0){
				if(item[checkField].toString()=="1"||item[checkField].toString()=="2"){
					_checkedBranchItems.addItem(item);
					for each(var cItem:Object in item.*){
						processSelectItem(cItem);
					}
				}
			}else{
				if(item[checkField].toString()=="1"){
					_checkedItems.addItem(item);
				}
			}
		}
		override protected function makeListData(data:Object, uid:String, rowNum:int):BaseListData{
			var treeListData:CheckTreeListData = new CheckTreeListData(itemToLabel(data), uid, this, rowNum);
			initListData(data, treeListData);
			return treeListData;
		}
		override protected function initListData(item:Object, treeListData:TreeListData):void{
			if (item == null)
				return;
			super.initListData( item, treeListData );
			(treeListData as CheckTreeListData ).checkedState = item[checkField]=itemToCheck(item);
		}
		protected function itemToCheck(item:Object):String{
			var value:String=item[checkField].toString();
			if(value=="0"||value=="1"||value=="2"){
				return value;
			}else{
				return "0";
			}
		}
		override protected function drawRowBackgrounds():void{
			
		}
		override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void{
			
		}
		override protected function drawCaretIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void{
			
		}
//		override protected function drawHighlightIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void{
//		}
		override protected function drawSelectionIndicator(indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void{
			
		}
	}
}