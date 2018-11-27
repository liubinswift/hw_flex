package com.morcha4.frame.menu
{
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	
	public class BaseMenu extends Group
	{
		public function BaseMenu()
		{
			super();
		}
		public static var enableChanged:Boolean=false;
		protected var currParent:XMLList;
		protected var selectNode:XML;
		protected var _dataProvider:XMLList;
		protected var isHide:Boolean=false;
		protected var dicItems:Object={};//<parent:XML,<node:XML,item>>
		public var dicDP:Object={};
		public function set dataProvider(xl:XMLList):void{
			_dataProvider=xl;
			if(!xl||xl.length()==0){
//				if(!isHide){
					hideMenu();
					isHide=true;
//				}
				currParent=null;
			}else{
				if(isHide){
					showMenu();
					isHide=false;
				}
				if(xl==currParent){
					if(enableChanged){
						refreshByEnable();
					}else{
						refreshBySelect();
					}
				}else{
					if(!dicDP[xl.parent().@id]){
						dicDP[xl.parent().@id]=[];
						build();
					}
					refreshByDP();
					currParent=xl;
				}
			}
		}
		public function get dataProvider():XMLList{
			return _dataProvider;
		}
		protected function hideMenu():void{
			//子类覆盖，隐藏目录
		}
		protected function showMenu():void{
			//子类覆盖，显示目录
		}
		protected function refreshByEnable():void{
			//子类覆盖，由于改变enable而刷新状态
		}
		protected function refreshBySelect():void{
			//子类覆盖，由于改变选中项而刷新状态
		}
		protected function refreshByDP():void{
			//子类覆盖，由于改变数据源而刷新状态
		}
		protected function build():void{
			//创建DP对应的items并保存
		}
	}
}