////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2008 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package com.morcha4.ui.advancedComboBox
{
	import adobe.utils.CustomActions;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.operations.CutOperation;
	import flashx.textLayout.operations.DeleteTextOperation;
	import flashx.textLayout.operations.FlowOperation;
	import flashx.textLayout.operations.InsertTextOperation;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.core.IIMESupport;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.styles.StyleProxy;
	
	import spark.components.Label;
	import spark.components.RichEditableText;
	import spark.components.TextInput;
	import spark.components.supportClasses.DropDownListBase;
	import spark.components.supportClasses.ListBase;
	import spark.core.NavigationUnit;
	import spark.events.DropDownEvent;
	import spark.events.IndexChangeEvent;
	import spark.events.ListEvent;
	import spark.events.TextOperationEvent;
	import spark.utils.LabelUtil;
	
	use namespace mx_internal;
	
	/**
	 *  Bottom inset, in pixels, for the text in the 
	 *  prompt area of the control.  
	 * 
	 *  @default 3
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")]
	
	/**
	 *  Left inset, in pixels, for the text in the 
	 *  prompt area of the control.  
	 * 
	 *  @default 3
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Style(name="paddingLeft", type="Number", format="Length", inherit="no")]
	
	/**
	 *  Right inset, in pixels, for the text in the 
	 *  prompt area of the control.  
	 * 
	 *  @default 3
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Style(name="paddingRight", type="Number", format="Length", inherit="no")]
	
	/**
	 *  Top inset, in pixels, for the text in the 
	 *  prompt area of the control.  
	 * 
	 *  @default 5
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")]
	
	//--------------------------------------
	//  Other metadata
	//--------------------------------------
	
	[AccessibilityClass(implementation="spark.accessibility.ComboBoxAccImpl")]
	
	/**
	 * Because this component does not define a skin for the mobile theme, Adobe
	 * recommends that you not use it in a mobile application. Alternatively, you
	 * can define your own mobile skin for the component. For more information,
	 * see <a href="http://help.adobe.com/en_US/Flex/4.0/UsingSDK/WS53116913-F952-4b21-831F-9DE85B647C8A.html">Spark Skinning</a>.
	 */
	[DiscouragedForProfile("mobileDevice")]
	
	/**
	 *  The ComboBox control is a child class of the DropDownListBase control. 
	 *  Like the DropDownListBase control, when the user selects an item from 
	 *  the drop-down list in the ComboBox control, the data item appears 
	 *  in the prompt area of the control. 
	 *
	 *  <p>One difference between the controls is that the prompt area of 
	 *  the ComboBox control is implemented by using the TextInput control, 
	 *  instead of the Label control for the DropDownList control. 
	 *  Therefore, a user can edit the prompt area of the control to enter 
	 *  a value that is not one of the predefined options.</p>
	 *
	 *  <p>For example, the DropDownList control only lets the user select 
	 *  from a list of predefined items in the control. 
	 *  The ComboBox control lets the user either select a predefined item, 
	 *  or enter a new item into the prompt area. 
	 *  Your application can recognize that a new item has been entered and, 
	 *  optionally, add it to the list of items in the control.</p>
	 *
	 *  <p>The ComboBox control also searches the item list as the user 
	 *  enters characters into the prompt area. As the user enters characters, 
	 *  the drop-down area of the control opens. 
	 *  It then and scrolls to and highlights the closest match in the item list.</p>
	 *
	 *  <p>To use this component in a list-based component, such as a List or DataGrid, 
	 *  create an item renderer.
	 *  For information about creating an item renderer, see 
	 *  <a href="http://help.adobe.com/en_US/flex/using/WS4bebcd66a74275c3-fc6548e124e49b51c4-8000.html">
	 *  Custom Spark item renderers</a>. </p>
	 *
	 *  <p><b>Note: </b>The Spark list-based controls (the Spark ListBase class and its subclasses
	 *  such as ButtonBar, ComboBox, DropDownList, List, and TabBar) do not support the BasicLayout class
	 *  as the value of the <code>layout</code> property. 
	 *  Do not use BasicLayout with the Spark list-based controls.</p>
	 * 
	 *  <p>The ComboBox control has the following default characteristics:</p>
	 *     <table class="innertable">
	 *        <tr>
	 *           <th>Characteristic</th>
	 *           <th>Description</th>
	 *        </tr>
	 *        <tr>
	 *           <td>Default size</td>
	 *           <td>146 pixels wide by 23 pixels high</td>
	 *        </tr>
	 *        <tr>
	 *           <td>Minimum size</td>
	 *           <td>20 pixels wide by 23 pixels high</td>
	 *        </tr>
	 *        <tr>
	 *           <td>Maximum size</td>
	 *           <td>10000 pixels wide and 10000 pixels high</td>
	 *        </tr>
	 *        <tr>
	 *           <td>Default skin class</td>
	 *           <td>spark.skins.spark.ComboBoxSkin
	 *               <p>spark.skins.spark.ComboBoxTextInputSkin</p></td>
	 *        </tr>
	 *     </table>
	 *
	 *  @mxml <p>The <code>&lt;s:ComboBox&gt;</code> tag inherits all of the tag 
	 *  attributes of its superclass and adds the following tag attributes:</p>
	 *
	 *  <pre>
	 *  &lt;s:ComboBox
	 *    <strong>Properties</strong>
	 *    itemMatchingFunction="null"
	 *    labelToItemFunction="null"
	 *    maxChars="0"
	 *    openOnInput="true"
	 *    prompt="null"
	 *    restrict=""
	 *
	 *    <strong>Styles</strong>
	 *    paddingBottom="3"
	 *    paddingLeft="3"
	 *    paddingRight="3"
	 *    paddingTop="5"
	 *  /&gt;
	 *  </pre>
	 *
	 *  @see spark.skins.spark.ComboBoxSkin
	 *  @see spark.skins.spark.ComboBoxTextInputSkin
	 *  @includeExample examples/ComboBoxExample.mxml
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public class AdvancedCombobox extends DropDownListBase implements IIMESupport
	{
		//--------------------------------------------------------------------------
		//
		//  Skin Parts
		//
		//--------------------------------------------------------------------------    
		/**
		 *  Optional skin part that holds the input text or the selectedItem text. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		[SkinPart(required="false")]
		public var textInput:TextInput;
		[SkinPart(required="false")]
		public var tip:Label;
		/**
		 *  Constructor. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		private var oldSelect:Object;
		public function AdvancedCombobox()
		{
			super();
			this.setStyle("skinClass",MyComSkin);
			dropDownController=new AdvancedComboBoxDropDownController;
			addEventListener(KeyboardEvent.KEY_DOWN, capture_keyDownHandler, true);
			addEventListener(IndexChangeEvent.CHANGE,function (e:IndexChangeEvent){if(selectedItem==oldSelect){e.stopImmediatePropagation();}oldSelect=selectedItem;});
			allowCustomSelectedItem = true;
			addEventListener(ListEvent.ITEM_ROLL_OVER,onItemOver);
			addEventListener(ListEvent.ITEM_ROLL_OUT,onItemOut);
		}
		/** 
		 * 过滤操作 
		 */ 
		public function set itemFilter(f:Function):void{ 
			var tmpCollection:ICollectionView = dataProvider as ICollectionView; 
			tmpCollection.filterFunction = f; 
			tmpCollection.refresh(); 
		} 

		private function onItemOver(e:ListEvent){
			try{
				if(tip){
					tip.text="描述：\n"+itemToLabel(e.item)+"的描述";
				}
			}catch(e){
				
			}
			
		}
		private function onItemOut(e:ListEvent){
			try{
				if(!tip){
					return;
				}
				if(caretItem){
					tip.text="描述：\n"+itemToLabel(caretItem)+"的描述";
				}else{
					tip.text="";
				}
			}catch(e){
				
			}
			
		}
		//--------------------------------------------------------------------------
		//
		//  Static Variables
		//
		//--------------------------------------------------------------------------
		/**
		 *  Static constant representing the value of the <code>selectedIndex</code> property
		 *  when the user enters a value into the prompt area, and the value is committed. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public static const CUSTOM_SELECTED_ITEM:int = ListBase.CUSTOM_SELECTED_ITEM;
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		private var isTextInputInFocus:Boolean;
		
		private var actualProposedSelectedIndex:Number = NO_SELECTION;  
		
		private var userTypedIntoText:Boolean;
		
		private var previousTextInputText:String = "";
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  itemMatchingFunction
		//--------------------------------------------------------------------------
		
		/**
		 *  Specifies a callback function used to search the item list as the user 
		 *  enters characters into the prompt area. 
		 *  As the user enters characters, the drop-down area of the control opens. 
		 *  It then and scrolls to and highlights the closest match in the item list.
		 * 
		 *  <p>The function referenced by this property takes an input string and returns
		 *  the index of the items in the data provider that match the input. 
		 *  The items are returned as a Vector.&lt;int&gt; of indices in the data provider. </p>
		 * 
		 *  <p>The callback function must have the following signature: </p>
		 * 
		 *  <pre>
		 *    function myMatchingFunction(comboBox:ComboBox, inputText:String):Vector.&lt;int&gt;</pre>
		 * 
		 *  <p>If the value of this property is null, the ComboBox finds matches 
		 *  using the default algorithm.  
		 *  By default, if an input string of length n is equivalent to the first n characters 
		 *  of an item (ignoring case), then it is a match to that item. For example, 'aRiz' 
		 *  is a match to "Arizona" while 'riz' is not.</p>
		 *
		 *  <p>To disable search, create a callback function that returns an empty Vector.&lt;int&gt;.</p>
		 * 
		 *  @default null
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */ 
		public var itemMatchingFunction:Function = null;     
		
		//--------------------------------------------------------------------------
		//  labelToItemFunction
		//--------------------------------------------------------------------------
		
		private var _labelToItemFunction:Function;
		private var labelToItemFunctionChanged:Boolean = false;
		
		/**
		 *  Specifies a callback function to convert a new value entered 
		 *  into the prompt area to the same data type as the data items in the data provider.
		 *  The function referenced by this properly is called when the text in the prompt area 
		 *  is committed, and is not found in the data provider. 
		 * 
		 *  <p>The callback function must have the following signature: </p>
		 * 
		 *  <pre>
		 *    function myLabelToItem(value:String):Object</pre>
		 * 
		 *  <p>Where <code>value</code> is the String entered in the prompt area.
		 *  The function returns an Object that is the same type as the items 
		 *  in the data provider.</p>
		 * 
		 *  <p>The default callback function returns <code>value</code>. </p>
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */ 
		public function set labelToItemFunction(value:Function):void
		{
			if (value == _labelToItemFunction)
				return;
			
			_labelToItemFunction = value;
			labelToItemFunctionChanged = true;
			invalidateProperties();
		}
		
		/**
		 *  @private 
		 */
		public function get labelToItemFunction():Function
		{
			return _labelToItemFunction;
		}
		
		//--------------------------------------------------------------------------
		//  maxChars
		//--------------------------------------------------------------------------
		
		private var _maxChars:int = 0;
		private var maxCharsChanged:Boolean = false;
		
		[Inspectable(category="General", defaultValue="0")]
		
		/**
		 *  The maximum number of characters that the prompt area can contain, as entered by a user. 
		 *  A value of 0 corresponds to no limit.
		 * 
		 *  @default 0
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */ 
		public function set maxChars(value:int):void
		{
			if (value == _maxChars)
				return;
			
			_maxChars = value;
			maxCharsChanged = true;
			invalidateProperties();
		}
		
		/**
		 *  @private 
		 */
		public function get maxChars():int
		{
			return _maxChars;
		}
		
		//--------------------------------------------------------------------------
		//  openOnInput
		//--------------------------------------------------------------------------
		
		/**
		 *  If <code>true</code>, the drop-down list opens when the user edits the prompt area.
		 * 
		 *  @default true 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */ 
		public var openOnInput:Boolean = true;
		
		//----------------------------------
		//  prompt
		//----------------------------------
		
		private var _prompt:String;
		private var promptChanged:Boolean;
		
		[Inspectable(category="General")]
		
		/**
		 *  Text to be displayed if/when the input text is null.
		 * 
		 *  <p>Prompt text appears when the control is first created. Prompt text disappears 
		 *  when the control gets focus, when the input text is non-null, or when an item in the list is selected. 
		 *  Prompt text reappears when the control loses focus, but only if no text was entered 
		 *  (if the value of the text field is null or the empty string).</p>
		 *  
		 *  <p>You can change the style of the prompt text with CSS. If the control has prompt text 
		 *  and is not disabled, the style is defined by the <code>normalWithPrompt</code> pseudo selector. 
		 *  If the control is disabled, then the styles defined by the <code>disabledWithPrompt</code> pseudo selector are used.</p>
		 *  
		 *  <p>The following example CSS changes the color of the prompt text in TextInput controls. The ComboBox control uses
		 *  a TextInput control as a subcomponent for the prompt text and input, so its prompt text changes when you use this CSS:
		 *  <pre>
		 *  &#64;namespace s "library://ns.adobe.com/flex/spark";
		 *  s|TextInput:normalWithPrompt {
		 *      color: #CCCCFF;
		 *  }
		 *  </pre>
		 *  </p>
		 *
		 *  @default null
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.0
		 *  @productversion Flex 4.5
		 */
		public function get prompt():String
		{
			return _prompt;
		}
		
		/**
		 *  @private
		 */
		public function set prompt(value:String):void
		{
			_prompt = value;
			promptChanged = true;
			invalidateProperties();
		}
		
		//--------------------------------------------------------------------------
		//  restrict
		//--------------------------------------------------------------------------
		
		private var _restrict:String;
		private var restrictChanged:Boolean;
		
		[Inspectable(category="General", defaultValue="")]
		
		/**
		 *  Specifies the set of characters that a user can enter into the prompt area.
		 *  By default, the user can enter any characters, corresponding to a value of
		 *  an empty string.
		 * 
		 *  @default ""
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */ 
		public function set restrict(value:String):void
		{
			if (value == _restrict)
				return;
			
			_restrict = value;
			restrictChanged = true;
			invalidateProperties();
		}
		
		/**
		 *  @private 
		 */
		public function get restrict():String
		{
			return _restrict;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  baselinePosition
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function get baselinePosition():Number
		{
			return getBaselinePositionForPart(textInput);
		}
		
		//--------------------------------------------------------------------------
		//  selectedIndex
		//--------------------------------------------------------------------------
		
		[Inspectable(category="General", defaultValue="-1")]
		
		/**
		 *  @private 
		 */
		override public function set selectedIndex(value:int):void
		{
			super.selectedIndex = value;
			actualProposedSelectedIndex = value;
		}
		
		//--------------------------------------------------------------------------
		//  typicalItem
		//--------------------------------------------------------------------------
		
		private var typicalItemChanged:Boolean = false;
		
		[Inspectable(category="Data")]
		
		/**
		 *  @private
		 */
		override public function set typicalItem(value:Object):void
		{   
			if (value == typicalItem)
				return;
			
			super.typicalItem = value;
			
			typicalItemChanged = true;
			invalidateProperties();
		}
		
		//--------------------------------------------------------------------------
		//  userProposedSelectedIndex
		//--------------------------------------------------------------------------
		
		/**
		 *  @private 
		 */
		override mx_internal function set userProposedSelectedIndex(value:Number):void
		{
			super.userProposedSelectedIndex = value;
			actualProposedSelectedIndex = value;
		}
		override public function set dataProvider(value:IList):void{
			super.dataProvider=value;
			if(value&&value.length>0&&_require){
				selectedItem=value[0];
			}
			if(value.length == 0){
				this.textInput.text = "";
			}
		}
		private var _require:Boolean=true;
		override public function set requireSelection(value:Boolean):void{
			_require=value;
		}
		override mx_internal function updateLabelDisplay(displayItem:* = undefined):void
		{
			super.updateLabelDisplay();
			if (textInput&&!isDropDownOpen)
			{
				if (displayItem == undefined)
					displayItem = selectedItem;
				if (displayItem != null && displayItem != undefined)
				{
					textInput.text = LabelUtil.itemToLabel(displayItem, labelField, labelFunction);
				}
			}
			if (textInput)
				textInput.selectRange(textInput.text.length,textInput.text.length);
			
		}
		override mx_internal function changeHighlightedSelection(newIndex:int, scrollToTop:Boolean = false):void
		{
			super.changeHighlightedSelection(newIndex, scrollToTop);
			
			if (newIndex >= 0)
			{
				var item:Object = dataProvider ? dataProvider.getItemAt(newIndex) : undefined;
				if (item && textInput&&tip)
				{
					//					var itemString:String = itemToLabel(item); 
					//					textInput.selectAll();
					//					textInput.insertText(itemString);
					//					textInput.selectAll();
					
//					userTypedIntoText = false;
					tip.text="描述：\n"+itemToLabel(item)+"的描述";
				}
			}
		}
		mx_internal function applySelection():void
		{
			if(actualProposedSelectedIndex<0&&_require){
				userProposedSelectedIndex=oldItem?dataProvider.getItemIndex(oldItem):-1;
				updateLabelDisplay(oldItem);
				userTypedIntoText = false;
				return;
			}
			if (actualProposedSelectedIndex == CUSTOM_SELECTED_ITEM)
			{
				var itemFromInput:* = getCustomSelectedItem();
				if (itemFromInput != undefined)
					setSelectedItem(itemFromInput, true);
				else
					setSelectedIndex(NO_SELECTION, true);
			}
			else
			{
				setSelectedIndex(actualProposedSelectedIndex, true);
			}
			userTypedIntoText = false;
		}
		/**
		 *  @private
		 */
		private var oldItem:Object;
		override mx_internal function dropDownController_openHandler(event:DropDownEvent):void
		{
			super.dropDownController_openHandler(event);
			oldItem=selectedItem;
			// If the user typed in text, start off by not showing any selection
			// If this does match, then processInputField will highlight the match
			userProposedSelectedIndex = userTypedIntoText ? NO_SELECTION : selectedIndex;
		}
		
		/**
		 *  @private 
		 */ 
		override protected function dropDownController_closeHandler(event:DropDownEvent):void
		{   
			if(!dataProvider){
				userTypedIntoText=false;
				super.dropDownController_closeHandler(event); 
				textInput.text="";
				return;
			}
			var item:Object;
			if(userProposedSelectedIndex>=0){
				item=dataProvider[userProposedSelectedIndex];
			}
			(dataProvider as ArrayCollection).filterFunction=null;
			(dataProvider as ArrayCollection).refresh();
			if(item){
				userProposedSelectedIndex=dataProvider.getItemIndex(item);
			}
			if(_require){
				super.changeHighlightedSelection(userProposedSelectedIndex<0?dataProvider.getItemIndex(oldItem):userProposedSelectedIndex);
			}else{
				super.changeHighlightedSelection(userProposedSelectedIndex);	
			}
			super.dropDownController_closeHandler(event);      
			
			// Commit the textInput text as the selection
			if (!event.isDefaultPrevented())
			{
				applySelection();
			}
			updateLabelDisplay();
			oldItem=null;
			userTypedIntoText=false;
		}
		/**
		 *  @private 
		 */ 
		private function processInputField():void
		{
			if(!dataProvider){
				return
			}
			actualProposedSelectedIndex = CUSTOM_SELECTED_ITEM; 
			(dataProvider as ArrayCollection).filterFunction=fil;
			(dataProvider as ArrayCollection).refresh();
			super.changeHighlightedSelection(CUSTOM_SELECTED_ITEM);
			if(tip){
				tip.text="";
			}
		}
		private function fil(item:Object):Boolean{
			return itemToLabel(item).indexOf(textInput.text)>=0;
		}
		override protected function dataProvider_collectionChangeHandler(event:Event):void{
//			super.changeHighlightedSelection(NO_SELECTION);  
		}
		override mx_internal function positionIndexInView(index:int, topOffset:Number=NaN, bottomOffset:Number=NaN, leftOffset:Number=NaN, rightOffset:Number=NaN):void{
			try{
				super.positionIndexInView(index,topOffset,bottomOffset,leftOffset,rightOffset);
			}catch(e){
				
			}
		}
		/**
		 *  @private 
		 */ 
		private function getCustomSelectedItem():*
		{
			// Grab the text from the textInput and process it through labelToItemFunction
			var input:String = textInput.text;
			if (input == "")
				return undefined;
			else if (labelToItemFunction != null)
				return _labelToItemFunction(input);
			else
				return input;
		}
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private 
		 */
		override protected function commitProperties():void
		{        
			// Keep track of whether selectedIndex was programmatically changed
			var selectedIndexChanged:Boolean = _proposedSelectedIndex != NO_PROPOSED_SELECTION;
			
			// If selectedIndex was set to CUSTOM_SELECTED_ITEM, and no selectedItem was specified,
			// then don't change the selectedIndex
			if (_proposedSelectedIndex == CUSTOM_SELECTED_ITEM && 
				_pendingSelectedItem == undefined)
			{
				_proposedSelectedIndex = NO_PROPOSED_SELECTION;
			}
			
			super.commitProperties();
			
			if (textInput)
			{
				if (maxCharsChanged)
				{
					textInput.maxChars = _maxChars;
					maxCharsChanged = false;
				}
				
				if (promptChanged)
				{
					textInput.prompt = _prompt;
					promptChanged = false;
				}
				
				if (restrictChanged)
				{
					textInput.restrict = _restrict;
					restrictChanged = false;
				}
				
				if (typicalItemChanged)
				{
					if (typicalItem != null)
					{
						var itemString:String = LabelUtil.itemToLabel(typicalItem, labelField, labelFunction);
						textInput.widthInChars = itemString.length;
					}
					else
					{
						// Just set it back to the default value
						textInput.widthInChars = 10; 
					}
					
					typicalItemChanged = false;
				}
			}
			
			// Clear the TextInput because we were programmatically set to NO_SELECTION
			// We call this after super.commitProperties because commitSelection might have
			// changed the value to NO_SELECTION
			if (selectedIndexChanged && selectedIndex == NO_SELECTION)
				textInput.text = "";
		}    
		
		/**
		 *  @private 
		 */     
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == textInput)
			{
				updateLabelDisplay();
				textInput.addEventListener(TextOperationEvent.CHANGE, textInput_changeHandler);
				textInput.addEventListener(TextOperationEvent.CHANGING, textInput_changingHandler);
				textInput.addEventListener(FocusEvent.FOCUS_IN, textInput_focusInHandler, true);
				textInput.addEventListener(FocusEvent.FOCUS_OUT, textInput_focusOutHandler, true);
				textInput.maxChars = maxChars;
				textInput.restrict = restrict;
				textInput.focusEnabled = false;
				
				if (textInput.textDisplay is RichEditableText)
					RichEditableText(textInput.textDisplay).batchTextInput = false;
			}
			if(instance==tip){
				tip.text="描述：\n"+itemToLabel(selectedItem)+"的描述";
			}
		}
		
		/**
		 *  @private 
		 */     
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			
			if (instance == textInput)
			{
				textInput.removeEventListener(TextOperationEvent.CHANGE, textInput_changeHandler);
				textInput.removeEventListener(TextOperationEvent.CHANGING, textInput_changingHandler);
				textInput.removeEventListener(FocusEvent.FOCUS_IN, textInput_focusInHandler, true);
				textInput.removeEventListener(FocusEvent.FOCUS_OUT, textInput_focusOutHandler, true);
			}
		}
		/**
		 *  @private 
		 */ 
		override mx_internal function findKey(eventCode:int):Boolean
		{
			return false;
		}
		
		// If the TextInput is in focus, listen for keyDown events in the capture phase so that 
		// we can process the navigation keys (UP/DOWN, PGUP/PGDN, HOME/END). If the ComboBox is in 
		// focus, just handle keyDown events in the bubble phase
		
		/**
		 *  @private 
		 */ 
		override protected function keyDownHandler(event:KeyboardEvent) : void
		{        
//			if (!isTextInputInFocus)
//				keyDownHandlerHelper(event);
		}
		
		/**
		 *  @private 
		 */ 
		protected function capture_keyDownHandler(event:KeyboardEvent):void
		{        
			if (isTextInputInFocus)
				keyDownHandlerHelper(event);
//			Alert.show("textinput");
		}
		
		/**
		 *  @private 
		 */ 
		mx_internal function keyDownHandlerHelper(event:KeyboardEvent):void
		{
			super.keyDownHandler(event);
			if (event.keyCode == Keyboard.ENTER && !isDropDownOpen) 
			{
				// commit the current text
				applySelection();
			}
			else if (event.keyCode == Keyboard.ESCAPE)
			{
				// Restore the previous selectedItem
				if (textInput)
				{
					if (selectedItem != null)
						textInput.text = itemToLabel(selectedItem);
					else
						textInput.text = "";
				}
				changeHighlightedSelection(selectedIndex);
			}
		}
		
		/**
		 *  @private
		 */
		override public function setFocus():void
		{
			if (stage && textInput)
			{            
				stage.focus = textInput.textDisplay as InteractiveObject;            
			}
		}
		
		/**
		 *  @private
		 */
		override protected function isOurFocus(target:DisplayObject):Boolean
		{
			if (!textInput)
				return false;
			
			return target == textInput.textDisplay;
		}
		
		/**
		 *  @private
		 */
		override protected function focusInHandler(event:FocusEvent):void
		{
			super.focusInHandler(event);
			
			// Since the API ignores the visual editable and selectable 
			// properties make sure the selection should be set first.
			if (textInput && 
				(textInput.editable || textInput.selectable))
			{
				// Workaround RET handling the mouse and performing its own selection logic
				callLater(textInput.selectAll);
			}
			
			userTypedIntoText = false;
		}
		
		/**
		 *  @private
		 */
		override protected function focusOutHandler(event:FocusEvent):void
		{
			// always commit the selection if we focus out        
			if (!isDropDownOpen)
			{
				if (textInput && 
					((selectedItem == null && textInput.text != "") ||
						textInput.text != itemToLabel(selectedItem)))
					applySelection();
			}
			
			dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
			
			super.focusOutHandler(event);
		}
		
		/**
		 *  @private 
		 */
		override protected function itemRemoved(index:int):void
		{
			if (index == selectedIndex)
				updateLabelDisplay("");
			
			super.itemRemoved(index);       
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private 
		 */ 
		private function textInput_focusInHandler(event:FocusEvent):void
		{
			isTextInputInFocus = true;
		}
		
		/**
		 *  @private 
		 */ 
		private function textInput_focusOutHandler(event:FocusEvent):void
		{
			isTextInputInFocus = false;
		}
		
		/**
		 *  @private 
		 */ 
		private function textInput_changingHandler(event:TextOperationEvent):void
		{
			previousTextInputText = textInput.text;
		}
		
		/**
		 *  @private 
		 */ 
		protected function textInput_changeHandler(event:TextOperationEvent):void
		{  
			userTypedIntoText = true;
			
			var operation:FlowOperation = event.operation;
			
			// Close the dropDown if we press delete or cut the selected text
//			if (operation is DeleteTextOperation || operation is CutOperation)
//			{
//				super.changeHighlightedSelection(CUSTOM_SELECTED_ITEM);
//			}
//			else 
				if (previousTextInputText != textInput.text)
			{
				if (openOnInput)
				{
					if (!isDropDownOpen)
					{
						// Open the dropDown if it isn't already open
						openDropDown();
						addEventListener(DropDownEvent.OPEN, editingOpenHandler);
						return;
					}   
				}
				
				processInputField();
			}
		}
		
		/**
		 *  @private 
		 */ 
		private function editingOpenHandler(event:DropDownEvent):void
		{
			removeEventListener(DropDownEvent.OPEN, editingOpenHandler);
			processInputField();
		}
		
		//----------------------------------
		//  enableIME
		//----------------------------------
		
		/**
		 *  @copy spark.components.TextInput#enableIME
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get enableIME():Boolean
		{
			if (textInput)
			{
				return textInput.enableIME;
			}
			
			return false;
		}
		
		//----------------------------------
		//  imeMode
		//----------------------------------
		
		/**
		 *  @copy spark.components.TextInput#imeMode
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get imeMode():String
		{
			if (textInput)
			{
				return textInput.imeMode;
			}
			return null;
		}
		
		/**
		 *  @public
		 */
		public function set imeMode(value:String):void
		{
			if (textInput)
			{
				textInput.imeMode = value;
				invalidateProperties();                    
			}
		}
		
	}
}