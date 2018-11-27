package com.morcha4.ui.tree.supportClass.checkTree
{
	import mx.controls.listClasses.ListBase;
	import mx.controls.treeClasses.TreeListData;
	
	public class CheckTreeListData extends TreeListData
	{
		[Bindable]public var checkedState:String;
		public function CheckTreeListData(text:String, uid:String, owner:ListBase, rowIndex:int=0, columnIndex:int=0,checkedState:String="0")
		{
			super(text, uid, owner, rowIndex, columnIndex);
			this.checkedState=checkedState;
		}
	}
}