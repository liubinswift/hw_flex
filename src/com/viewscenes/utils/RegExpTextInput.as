package com.viewscenes.utils
	
{
	
	import flashx.textLayout.operations.InsertTextOperation;
	
	
	import spark.components.TextInput;
	
	import spark.events.TextOperationEvent;
	
	
	
	/** 
	 * 正则：正整数和小数/^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|[1-9]*$/
	 * 正则：Number /^(\-\d+\.\d+|\-\d+\.|\-\d+|\-)|(\d+\.\d+|\d+\.|\d+)$/
	 * 正则：日期 /^\d{1,4}\-\d{1,2}\-\d{1,2}\s\d{1,2}\:\d{1,2}\:\d{1,2}|\d{1,4}\-\d{1,2}\-\d{1,2}\s\d{1,2}\:\d{1,2}\:|\d{1,4}\-\d{1,2}\-\d{1,2}\s\d{1,2}\:\d{1,2}|\d{1,4}\-\d{1,2}\-\d{1,2}\s\d{1,2}\:|\d{1,4}\-\d{1,2}\-\d{1,2}\s\d{1,2}|\d{1,4}\-\d{1,2}\-\d{1,2}\s|\d{1,4}\-\d{1,2}\-\d{1,2}|\d{1,4}\-\d{1,2}\-|\d{1,4}\-\d{1,2}|\d{1,4}\-|\d{1,4}$/
	 * 使用方法：
	 * 1、<RegExpTextInput regex="/^\d+\.\d+|\d+\.|\d+$/"/>
	 * 
	 * 2、private var reg:RegExp =   /^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|[1-9]*$/;
	 * <utils:RegExpTextInput regex="{reg}" />
	 */
	
	public class RegExpTextInput extends TextInput
		
	{
		
		public function RegExpTextInput()
			
		{
			
			
		}
		
		
		//regex pattern
		
		private var _regex:RegExp;
		
		override protected function childrenCreated():void
			
		{
			
			super.childrenCreated();
			
			
			
			//listen for the text change event
			
			addEventListener(TextOperationEvent.CHANGING, onTextChange);
			
		}
		
		
		public function onTextChange(event:TextOperationEvent):void
			
		{
			
			if (_regex && event.operation is InsertTextOperation)
				
			{
				
				// What will be the text if this input is allowed to happen
				
				var textToBe:String = "";
				
				// Check selection
				
				if (selectionActivePosition > 0)
					
				{
					
					textToBe += text.substr(0, selectionActivePosition)
					
				}
				
				//append the newly entered text with the existing text
				
				textToBe += InsertTextOperation(event.operation).text;
				
				if (selectionAnchorPosition > 0)
					
				{
					
					textToBe += text.substr(selectionAnchorPosition, text.length - selectionAnchorPosition);
					
				}
				
				var match:Object = _regex.exec(textToBe);
				
				if (!match || match[0] != textToBe)
					
				{
					
					// The textToBe didn't match the expression... stop the event
					
					event.preventDefault();
					
				}
				
				//special condition checking to prevent multiple dots
				
				var firstDotIndex:int = textToBe.indexOf(".");
				
				if( firstDotIndex != -1)
					
				{
					
					var lastDotIndex:int = textToBe.lastIndexOf(".");
					
					if(lastDotIndex != -1 && lastDotIndex != firstDotIndex)
						
						event.preventDefault();
					
				}
				
			}
			
		}
		
		
		/**
		 * 修改regex属性改变正则表达式
		 */
		[Bindable]
		public function set regex(value:RegExp):void{
			if(value != _regex){
				_regex = value;
			}
		}
		
		public function get regex():RegExp{
			return _regex;
		}
		
	}
	
}