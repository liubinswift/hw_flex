package com.morcha4.ui.advancedComboBox
{
	import spark.components.DropDownList;
	
	public class DropDownListSet extends DropDownList
	{
		public function DropDownListSet()
		{
			//TODO: implement function
			super();
		}
		
		/**
		 * 设置选中项
		 * nameValue 要选中对象匹配属性和其值 ['','']
		 */
		public function set selectedItemValue(nameValue:Array):void{
			try{
				var name:String = nameValue[0];// 要选中对象的某个属性名
				var value:String = nameValue[1];// 要选中对象的值
				
				for(var i=0;i<this.dataProvider.length;i++){
					if(this.dataProvider[i][name] == value){
						this.selectedIndex = i;
						break
					}
				}
			} catch(e:Error){
				
			}
		}
	}
}