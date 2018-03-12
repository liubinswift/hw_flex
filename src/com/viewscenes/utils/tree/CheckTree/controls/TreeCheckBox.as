package  com.viewscenes.utils.tree.CheckTree.controls
{
	import com.viewscenes.utils.tree.CheckTree.controls.treeClasses.TreeCheckListData;
	import com.viewscenes.utils.tree.CheckTree.renderers.TreecheckboxItemRenderer;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.controls.Tree;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.controls.treeClasses.TreeListData;
	import mx.core.ClassFactory;
	import mx.core.mx_internal;
	import mx.events.TreeEvent;
	
	use namespace mx_internal;

	[Event(name="checkFieldChanged", type="flash.events.Event")]
	[Event(name="checkFunctionChanged", type="flash.events.Event")]
	[Event(name="itemCheck", type="mx.events.TreeEvent")]
	
	
	public class TreeCheckBox extends Tree
	{
		
		
		protected var _checkField: String;
		private var _checkFunction: Function;
		private var updateFirst:Boolean = true;
		
		private var _checkedItems:ArrayCollection = new ArrayCollection();  //所有checkbox值为1的叶子节点
		private var _checkedBranchItems:ArrayCollection = new ArrayCollection(); //所有checkbox值不为0的非叶子节点
			
		public function set checkedItems(items:ArrayCollection):void{
				this._checkedItems = items;
		}
		[Bindable]
		public function get checkedItems():ArrayCollection{
				return this._checkedItems;
		}
		public function set checkedBranchItems(items:ArrayCollection):void{
				this._checkedBranchItems = items;
		}
		[Bindable]
		public function get checkedBranchItems():ArrayCollection{
				return this._checkedBranchItems;
		}
		
		/**
		 *  
		 * 需要的xml数据格式
		 *
		 *  <node label="home" >
		 * 			<node label="p21" checked="2" state="schrodinger">
		 * 				<node label="p31" checked="2" >
		 * 					<node label="1" checked="1"/>
		 * 					<node label="2" checked="0" />
		 * 				</node>
		 * 			</node>
		 * 			<node label="p22" checked="0">
		 * 				<node label="p221" checked="0" >
		 * 					<node label="p32" checked="0" >
		 * 					</node>
		 * 				</node>
		 * 			</node>
		 * 	</node>
		 * 
		 * 节点名称必须为node 需要checked域 checked=0/1/2 
		 * 0 为未选中   1 为选中  2 为中间状态
		 * 
		 * 
		 * 使用	<controls:TreeCheckBox id="mytree"
		 *			showRoot="false"
		 *			width="100%"
		 *			height="100%"
		 *			dataProvider="{treeSource}"
		 *			openItems="{treeSource..node}"
		 *			labelField="@label"
		 *			checkField="@checked"
		 *			change="changeCheck()"
		 *			itemCheck="onItemCheck( event )"
		 *		/>
		 * */
		public function TreeCheckBox()
		{
			super( );
			setStyle("folderClosedIcon",null);
			setStyle("folderOpenIcon",null);
			setStyle("defaultLeafIcon",null);
			this.itemRenderer = new ClassFactory( TreecheckboxItemRenderer );
			addEventListener( "itemCheck", checkHandler );
			addEventListener("creationComplete",initChecked );
		}
		
		public function initChecked(e:Event):void{
			if(dataProvider){
				var str:String = dataProvider.toString();
			//	walkDataProvider(new XML(str));
				setCheckedData();
			}
			
		//	this.updateChilds(new XML(str),0);
		}
		
	    mx_internal function isBranch( item: Object ): Boolean
	    {
	        if ( item != null )
	            return _dataDescriptor.isBranch( item, iterator.view );
	        return false;
	    }
	    
		
 		private function checkHandler( event: TreeEvent ): void
	    {
	    	var value: String;
	        var state: int = ( event.itemRenderer as TreecheckboxItemRenderer ).checkBox.checkState;
	        var middle: Boolean = ( state & 2 << 1 ) == ( 2 << 1 );
	        var selected: Boolean = ( state & 1 << 1 ) == ( 1 << 1 );

			if( isBranch( event.item ) )
			{
				middle = false;
			}  
	        
	        if( middle )
	        {
	            value = "2";
	        } else {
	            value = selected ? "1" : "0";
	        }
	        
	        var data:Object = event.item;

	        if (data == null) {
	            return;
	        }
	
	        if( checkField )
	        {
	            if ( data is XML )
	            {
	                try
	                {
	                       data[ checkField ] = value;
	                }
	                catch ( e: Error )
	                {
	                }
	            } else if ( data is Object ) {
	                try
	                {
	                    data[ checkField ] = value;
	                }
	                catch( e: Error )
	                {
	                }
	            }
	         }
	
	        if ( data is String ) {
	            data = String( value );
	        }
	        commitProperties( );
	        updateFirst = true;
	        updateParents( event.item as XML, ( event.itemRenderer as TreecheckboxItemRenderer ).checkBox.checkState );
			updateChilds( event.item as XML, ( event.itemRenderer as TreecheckboxItemRenderer ).checkBox.checkState );
			setCheckedData();
			
	    }
		
		private function updateChilds( item:XML, value: uint ):void
            {
            	
		        var middle: Boolean = ( value & 2 << 1 ) == ( 2 << 1 );
		        var selected: Boolean = ( value & 1 << 1 ) == ( 1 << 1 );
	      //  	trace(item.@label+":" + selected + " &  middle:" +middle);
	        	
//	        	if(item.children().length() ==0 ){ 
//	        		if(selected && !checkedItems.contains(item)){
//	        			checkedItems.addItem(item);
//	        		}else if(!selected){
//	        			checkedItems.removeItemAt(checkedItems.getItemIndex(item));
//	        		}
//	        	}else{
//	        		if(selected && !checkedBranchItems.contains(item)){
//	        			checkedBranchItems.addItem(item);
//	        		}else if(!selected && !updateFirst){
//	        			checkedBranchItems.removeItemAt(checkedBranchItems.getItemIndex(item));
//	        		}
//	        	}
	        	
                if( item.children( ).length( ) > 0 && !middle )
                {
                    for each(var x: XML in item.node )
                    {
                        x.@checked = value == ( 1 << 1 | 2 << 1 ) ? "2" : value == ( 1 << 1 ) ? "1" : "0";
                        
                        updateChilds( x, value );
                    }
                }
                
            }
            
            private function updateParents( item: XML, value: uint ): void
            {
            	var checkValue: String = ( value == ( 1 << 1 | 2 << 1 ) ? "2" : value == ( 1 << 1 ) ? "1" : "0" );
                var parentNode: XML = item.parent( );
               
                if( parentNode )
                {
                    for each(var x: XML in parentNode.node )
                    {
                        if( x.@checked != checkValue )
                        {
                            checkValue = "2"
                        }
                    }
//                    if(item.children().length() !=0 ){
//                    	trace(item.toXMLString());
//                    	var checkedValue:String = item.@checked;
//	                    if(checkedValue != '0' && !checkedBranchItems.contains(item)){
//	                    	checkedBranchItems.addItem(item);
//	                    }else if(checkedValue == '0' && !updateFirst){
//	                    	checkedBranchItems.removeItemAt(checkedBranchItems.getItemIndex(item));
//	                    }
//	                  }
                    parentNode.@checked = checkValue;
                    this.updateFirst = false;
                    updateParents( parentNode, value );
                }
            }
		
	    override protected function makeListData( data: Object, uid: String, rowNum: int): BaseListData
	    {
	        var treeListData: TreeListData = new TreeCheckListData( itemToLabel( data ), uid, this, rowNum );
	        initListData( data, treeListData );
	        return treeListData;
	    }
	    
	    override protected function initListData( item: Object, treeListData: TreeListData ): void
	    {
	    	
//	    	trace("initlistdata:************");
//	    	trace(item.@text);
//	    	trace(treeListData.label);
//	    	trace("initlistdata:************");
	    	super.initListData( item, treeListData );
	    	
	        if (item == null)
	            return;
	
	        ( treeListData as TreeCheckListData ).checkedState = itemToCheck( item );
	    }	    
		
    	[Bindable("checkFieldChanged")]
    	[Inspectable(category="Data", defaultValue="checked")]		
	    public function get checkField( ): String
	    {
	        return _checkField;
	    }
	
	    public function set checkField( value: String ): void
	    {
	        _checkField = value;
	        itemsSizeChanged = true;
	        invalidateDisplayList( );
	        dispatchEvent( new Event("checkFieldChanged") );
	    }
	    
	    public function itemToCheck( data: Object ): int
	    {
	        if (data == null )
	            return 0;
	
	        if ( checkFunction != null )
	            return checkFunction( data );
	
	        if ( data is XML )
	        {
	        	
	            try
	            {
	                if ( data[ checkField ].length( ) != 0 )
	                	var tempData:XML = data as XML;
	                    data = data[ checkField ];
	                //    trace(tempData.@text+": "+data);
//	                    if(data == 1 && tempData.children().length()==0 && !checkedItems.contains(tempData)){
//	                    	checkedItems.addItem(tempData);
//	                    }
//	                    else if(data !=0 && tempData.children().length()>0 && !checkedBranchItems.contains(tempData)){
//	                    	checkedBranchItems.addItem(tempData);
//	                    }
	            } catch( e: Error )
	            {
	            }
	        }
	        else if ( data is Object )
	        {
	            try
	            {
	                if ( data[ checkField ] != null )
	                    data = data[ checkField ];
	            } catch( e: Error )
	            {
	            }
	        }
	
	        if ( data is String )
	            return parseInt( String( data ) );
	        try
	        {
	            return parseInt( String( data ) );
	        }
	        catch( e: Error )
	        {
	        }
	        return 0;
	    }
	    
	    [Bindable("checkFunctionChanged")]
	    [Inspectable(category="Data")]
	
	    public function get checkFunction( ): Function
	    {
	        return _checkFunction;
	    }
	
	    public function set checkFunction( value: Function ): void
	    {
	        _checkFunction = value;
	        itemsSizeChanged = true;
	        invalidateDisplayList( );
	        dispatchEvent( new Event("checkFunctionChanged") );
	    }
	    
		private function walkDataProvider(xmlData:XML):void{
			trace(xmlData.toString());
			if(xmlData){
				for each (var data:XML in xmlData..node){
					try
					{
						trace(data.@text+": "+data.@checked);
						if ( data[ checkField ].length( ) != 0 )
						var tempData:XML = data as XML;
						var checkedData:String = data[ checkField ];
					   trace(tempData.@text+": "+checkedData);
						if(checkedData == '1' && tempData.children().length()==0 && !checkedItems.contains(tempData)){
							checkedItems.addItem(tempData);
						}
						else if(checkedData != '0' && tempData.children().length()>0 && !checkedBranchItems.contains(tempData)){
							checkedBranchItems.addItem(tempData);
						}
					} catch( e: Error )
					{
					}
				}
			}
		}
		private function setCheckedData():void{
			checkedBranchItems.removeAll();
			checkedItems.removeAll();
			var str:String = dataProvider.toString();
		//	walkDataProvider(new XML(str));
			walkTree(this,new XML(str),false);
		}
	    
	    private function walkTree(tree:TreeCheckBox, item:Object, startAtParent:Boolean = false):void{
	    	
//	    	this.checkedBranchItems.removeAll();
//	    	this.checkedItems.removeAll();
		    // get the Tree's data descriptor

		    var descriptor:ITreeDataDescriptor = tree.dataDescriptor;
		    var cursor:IViewCursor;
		    
		    var parentItem:Object;
		    var childItem:Object;
		    var childItems:Object;
		    
		    // if the item is null, stop
		    if(item == null)
		        return;
		        
		    // do we back up one level to the item's parent
		    if(startAtParent)
		    {
		        // get the parent
		        parentItem = tree.getParentItem(item);
		        var tmpitem:Object =item;
		        while(true){
		        	var tmparent:Object = tree.getParentItem(tmpitem);
		        	if(tmparent){
		        		parentItem=tmparent;
		        		tmpitem = tmparent;
		        	}else{
		        		break;
		        	}
		        }
		        
		        // is the parent real
		        if(parentItem)
		        {
		         //   trace("|-- Parent Node ", parentItem[tree.labelField]);
		            // if the parent is a branch
		            if(descriptor.isBranch(parentItem))
		            {
		                // if the branch has children to run through
		                if(descriptor.hasChildren(parentItem))
		                {
		                    // get the children of the branch
		                    // this part of the algorithm contains the item
		                    // passed
		                    childItems = descriptor.getChildren(parentItem);
		                }
		            }
		            // if the branch has valid child items
		            if(childItems)
		            {
		                // create our back step cursor
		                cursor = childItems.createCursor();
		                // loop through the items parent's children (item)
		                while(!cursor.afterLast)
		                {
		                    // get the current child item
		                    childItem = cursor.current; 
		                    
		                    var xmlItem:XML = childItem as XML;
		                    var label:String = childItem[tree.labelField];
		                    var isCheck:String = childItem[tree.checkField];
		                    var branch:Boolean = descriptor.isBranch(childItem);
		                   
		                   	if (!(isCheck == "0")){	
		                   		if((!branch) && (!checkedItems.contains(xmlItem))){
		                   			checkedItems.addItem(xmlItem);
		                   		}
		                   		else if(branch &&(!checkedBranchItems.contains(xmlItem))){
		                   			checkedBranchItems.addItem(xmlItem);
		                   		}
		                   	}
		                    // good place for a custom method()
		              //      trace("Nodes ::", label, " Is Branch :: ", branch," checked:",isCheck); 
		                    
		                    // if the child item is a branch
		                    if(descriptor.isBranch(childItem))
		                        // traverse the childs branch all the way down 
		                        // before returning
		                        walkTree(tree, childItem);
		                    // do it again!
		                    cursor.moveNext();
		                }
		            }
		        }
		    }
		    else// we don't want the parent OR this is the second iteration
		    {
		        // if we are a branch
		        if(descriptor.isBranch(item))
		        {
		            // if the branch has children to run through
		            if(descriptor.hasChildren(item))
		            {
		                // get the children of the branch
		                childItems = descriptor.getChildren(item);
		            }
		            
		            // if the child items exist
		            if(childItems)
		            {
		                // create our cursor pointer
		                cursor = childItems.createCursor();
		                // loop through all of the children
		                // if one of these children are a branch we will recurse
		                while(!cursor.afterLast)
		                {
		                    // get the current child item
		                    childItem = cursor.current;
		                    
							var xmlItem:XML = childItem as XML;
		                    var label:String =  childItem[tree.labelField];
		                    var isCheck:String = childItem[tree.checkField];
		                    var branch:Boolean = descriptor.isBranch(childItem);
		                    
		                    if (!(isCheck == "0")){	
		                   		if((!branch) && (!checkedItems.contains(xmlItem))){
		                   			checkedItems.addItem(xmlItem);
		                   		}
		                   		else if(branch &&(!checkedBranchItems.contains(xmlItem))){
		                   			checkedBranchItems.addItem(xmlItem);
		                   		}
		                   	}
		                    
		                    // good place for a custom method()
		           //         trace("Nodes ::", label, " Is Branch :: ", branch," checked:",isCheck); 
		
		                    // if the child item is a branch
		                    if(descriptor.isBranch(childItem))
		                        // traverse the childs branch all the way down 
		                        // before returning
		                        walkTree(tree, childItem);
		                    // check the next child
		                    cursor.moveNext();
		                }
		            }
		        }
		    }
		}
	}
}