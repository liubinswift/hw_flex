package com.viewscenes.utils
{
	import com.as3xls.xls.Cell;
	import com.as3xls.xls.ExcelFile;
	import com.as3xls.xls.Sheet;
	
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	

	
	public class ExportExcel {
		/**
		 * 导出Excel文件 by DataGrid
		 */
		public static function exportToExcelByDg(dg:DataGrid,list:ArrayCollection, xlsName:String="exportExcel"):FileReference {
			var _sheet:Sheet = new Sheet();  //Excel选项卡
			var _fields:Array = []; //需要呈现的字段数组	
			var iList:ArrayCollection = list; //DataGrid数据源
			var rowCount:int=iList.length; //有多少行数据
			var columns:Array=dg.columns.toArray(); //DataGrid有多少列
			_sheet.resize(rowCount + 1, dg.columnsLength); //设置当前选项卡 有多少行多少列
			
			//循环所有列
			for(var i:uint=0;i<columns.length;i++){
				var dgc:GridColumn=columns[i];
				_sheet.setCell(0, i, dgc.headerText); //设置单元格 参数:1、行号；2、列号；3、单元格的值				 
				_fields.push(dgc);  //保存字段
				
			}
			
			//循环所有数据
			for (var r:int=0;r<rowCount;r++) {
				var record:Object=iList.getItemAt(r);
				//把数据写入某行某列
				for(var c:uint=0;c<_fields.length;c++){
					_sheet.setCell(r+1,c,record[_fields[c].dataField]); //设置单元格 参数:1、行号；2、列号；3、单元格的值
				}
			}
			
			var xls:ExcelFile=new ExcelFile();
			xls.sheets.addItem(_sheet);  //把选项卡写入Excel文件中
			var bytes:ByteArray=xls.saveToByteArray();
			var fr:FileReference=new FileReference(); //保存对话框
			fr.save(bytes, xlsName + ".xls");
			return fr;
		}
	}
}


