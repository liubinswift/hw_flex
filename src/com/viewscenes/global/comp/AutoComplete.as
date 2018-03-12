package com.viewscenes.global.comp
{
	import flash.events.Event; 
	import flash.events.FocusEvent; 
	import flash.events.KeyboardEvent; 
	import flash.ui.Keyboard; 
	
	import mx.collections.ICollectionView; 
	import mx.controls.Alert; 
	import mx.controls.ComboBox; 
	import mx.core.UIComponent; 
	
	
	
	public class AutoComplete extends ComboBox 
	{ 
		public function AutoComplete() 
		{ 
			super(); 
			init(); 
		} 
		
		private function init():void{ 
			editable=true; 
			rowCount=5; 
			selectedIndex=-1; 
			isTextBoxStringChange=false; 
			isfocusInDropDown=false; 
			isAutoComplete=false; 
			//伪装成TextBox 
			setStyle("cornerRadius",0); 
			setStyle("arrowButtonWidth",0); 
			setStyle("fontWeight","normal"); 
			setStyle("paddingLeft",0); 
		} 
		
		
		
		//获得焦点时，是否自动弹出下拉框，get set 
		private var isfocusInDropDown:Boolean=false; 
		
		//是否自动完成,get set 
		private var isAutoComplete:Boolean=false; 
		
		//类默认过滤函数,get set 
		private var _filterFunction:Function = myFilterFunction; 
		
		//文本是否发生了变化 
		private var isTextBoxStringChange:Boolean=false; 
		
		//按下的键是否是退格键 
		private var isBackSpaceKeyDown:Boolean=false; 
		
		/** 
		 * 处理退格键按下的情况 
		 */ 
		override protected function keyDownHandler(event:KeyboardEvent):void 
		{ 
			if(!event.ctrlKey&&!event.shiftKey) 
			{ 
				if(event.keyCode == Keyboard.BACKSPACE) 
				{ 
					close(); 
					isBackSpaceKeyDown=true; 
				} 
				else 
				{ 
					isBackSpaceKeyDown=false; 
				} 
				//当按UP键向上选择时，到达最顶时，显示用户原来所需文字 
				if(event.keyCode == Keyboard.UP && selectedIndex==0) 
				{ 
					selectedIndex=-1; 
				} 
			} 
			super.keyDownHandler(event); 
		} 
		
		/** 
		 * 数据源发生变化,数据不为0弹出下拉列表 
		 */ 
		override protected function collectionChangeHandler(event:Event):void 
		{ 
			super.collectionChangeHandler(event); 
			if(dataProvider.length>0&&text!="") 
			{ 
				// Alert.show(textInput.text+","+textInput.text.length); 
				open(); 
			} 
		} 
		
		/** 
		 *  Displays the drop-down list. 
		 */ 
		override public function open():void{ 
			
			if(text!=""){ 
				//     Alert.show(textInput.text+","+text+"open()!!!"+isTextBoxStringChange); 
				super.open(); 
			} 
		} 
		/** 
		 * 获得焦点 
		 */ 
		override protected function focusInHandler(event:FocusEvent):void{ 
			if(isfocusInDropDown) open(); 
			// 
			super.focusInHandler(event); 
		} 
		
		/** 
		 * 文本发生变化时 
		 */ 
		override protected function textInput_changeHandler(event:Event):void 
		{ 
			// Alert.show(textInput.text+" text change!"); 
			if(textInput.text == ""){ 
				// Alert.show(textInput.text+",null"); 
				isTextBoxStringChange=false; 
			} 
			else{ 
				// Alert.show(textInput.text+","+event.toString()); 
				isTextBoxStringChange=true; 
				super.textInput_changeHandler(event); 
				invalidateProperties();//调用该方法，随后会触发调用commitProperties() 
			} 
		} 
		
		override protected function commitProperties():void{ 
			if(isTextBoxStringChange&&textInput.text!=""){ 
				prompt=text; 
				filter(); //进行匹配项的查找 
				if(isAutoComplete&&!isBackSpaceKeyDown){ 
					var autoCompleteString:String=""; 
					if(dataProvider.length>0) 
					{ 
						autoCompleteString=itemToLabel(dataProvider[0]); 
						textInput.selectRange(prompt.length,autoCompleteString.length); 
						prompt=autoCompleteString; 
					} 
					else{ 
						textInput.selectRange(textInput.selectionActivePosition,textInput.selectionActivePosition); 
					} 
				} 
				else{ 
					textInput.selectRange(textInput.selectionActivePosition,textInput.selectionActivePosition); 
				} 
			} 
			super.commitProperties(); 
		} 
		
		/** 
		 * 与TextBox同样的宽度 
		 */ 
		override protected function measure():void 
		{ 
			super.measure(); 
			measuredWidth=UIComponent.DEFAULT_MEASURED_WIDTH; 
		} 
		
		/** 
		 * 过滤操作 
		 */ 
		private function filter():void{ 
			var tmpCollection:ICollectionView = dataProvider as ICollectionView; 
			tmpCollection.filterFunction = _filterFunction; 
			tmpCollection.refresh(); 
		} 
		
		/** 
		 * 过滤函数 
		 */ 
		private function myFilterFunction(item:Object):Boolean 
		{ 
			var myLabel:String = itemToLabel(item); 
//			if(myLabel.substr(0,text.length).toLowerCase() == prompt.toLowerCase()) 
			if(myLabel.toLowerCase().indexOf(prompt.toLowerCase())>-1) 
			{ 
				return true; 
			} 
			return false; 
		} 
//		// filter function         
//		public function filterFunction(item : Object) : Boolean {
//			var itemLabel : String = itemToLabel(item).toLowerCase();
//			// prefix search mode
//			if (searchMode == SearchModes.PREFIX_SEARCH) {
//				if (itemLabel.substr(0, enteredText.length) == enteredText.toLowerCase()) {
//					return true;
//				}
//				else { 
//					return false;
//				}
//			}
//				// infix search mode
//			else {
//				if (itemLabel.search(enteredText.toLowerCase()) != -1) {
//					return true;   
//				}
//			}
//			return false;
//		}
		/************************Get Set 属性**********************************/ 
		
		public function get FilterFunction():Function{ 
			return _filterFunction; 
		} 
		
		public function set FilterFunction(filterFunction:Function):void{ 
			_filterFunction=filterFunction; 
		} 
		
		
		public function get IsfocusInDropDown():Boolean{ 
			return isfocusInDropDown; 
		} 
		
		public function set IsfocusInDropDown(value:Boolean):void{ 
			isfocusInDropDown=value; 
		} 
		
		public function get IsAutoComplete():Boolean{ 
			return isAutoComplete; 
		} 
		
		public function set IsAutoComplete(value:Boolean):void{ 
			isAutoComplete=value; 
		} 
		
	} 
	} 
