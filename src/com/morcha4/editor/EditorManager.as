package com.morcha4.editor
{
	import spark.events.GridItemEditorEvent;

	public class EditorManager
	{
		public function EditorManager()
		{
		}
		public static function getRelatedField(event:GridItemEditorEvent):String{
			return event.column.headerText;;
		}
		public static function getRelatedData(event:GridItemEditorEvent):Object{
			return event.column.grid.dataGrid.dataProvider.getItemAt(event.rowIndex);;
		}
	}
}