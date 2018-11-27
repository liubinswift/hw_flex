////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2009 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package com.morcha4.ui.advancedComboBox
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.ISystemManager;
	
	import spark.components.supportClasses.ButtonBase;
	import spark.components.supportClasses.DropDownController;
	import spark.events.DropDownEvent;
	
	use namespace mx_internal;
	
	/**
	 *  The DropDownController class handles the mouse, keyboard, and focus
	 *  interactions for an anchor button and its associated drop down. 
	 *  This class is used by the drop-down components, such as DropDownList, 
	 *  to handle the opening and closing of the drop down due to user interactions.
	 * 
	 *  @see spark.components.DropDownList
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public class AdvancedComboBoxDropDownController extends DropDownController
	{
		/**
		 *  Constructor.
		 * 
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function AdvancedComboBoxDropDownController()
		{
			super();
		}
		
		override public function processKeyDown(event:KeyboardEvent):Boolean{
			if (event.isDefaultPrevented())
				return true;
			
			if (event.keyCode == Keyboard.ENTER)
			{
				// Close the dropDown and eat the event if appropriate.
				if (isOpen)
				{
					closeDropDown(true);
				}
				event.preventDefault();
				event.keyCode=9999;
			}
			var f:Boolean=super.processKeyDown(event);
			if(event.keyCode==9999){
				event.keyCode= Keyboard.ENTER;
			}
			return f;        
		}
		override public function processFocusOut(event:FocusEvent):void{
			if (isOpen)
			{
				// If focus is moving outside the dropdown...
				if (!event.relatedObject ||
					(!dropDown || 
						(dropDown is DisplayObjectContainer &&
							!DisplayObjectContainer(dropDown).contains(event.relatedObject))))
				{
					// Close the dropdown.
					closeDropDown(true);
				}
			}
		}
	}
		
}
