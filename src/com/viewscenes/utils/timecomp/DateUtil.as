package com.viewscenes.utils.timecomp 
{ 
	/** 
	 * @author zyh 
	 * @explain:  时间工具类 来自省网
	 * @version 1.0.0 
	 * 创建时间：2012-2-23 上午10:24:28 * 
	 */  
	import mx.controls.Alert;
	
	public class DateUtil
	{
		
		public static  const  DATE_FORMAT:String = "YYYY-MM-DD JJ:NN:SS";
		public  static const TIME_FORMAT:String = "JJ:NN:SS";	
		public function DateUtil()
		{
		}
		
		/** 
		 * 添加时间-周
		 */
		public static function addWeeks(date:Date, weeks:Number):Date {
			return addDays(date, weeks*7);
		}
		/** 
		 * 添加时间-日
		 */
		public static function addDays(date:Date, days:Number):Date {
			return addHours(date, days*24);
		}
		/** 
		 * 添加时间-小时
		 */
		public static function addHours(date:Date, hrs:Number):Date {
			return addMinutes(date, hrs*60);
		}
		/** 
		 * 添加时间-分钟
		 */
		public static function addMinutes(date:Date, mins:Number):Date {
			return addSeconds(date, mins*60);
		}
		/** 
		 * 添加时间-秒钟
		 */
		public static function addSeconds(date:Date, secs:Number):Date {
			var mSecs:Number = secs * 1000;
			var sum:Number = mSecs + date.getTime();
			return new Date(sum);
		}
		
		/**
		 * Date类型时间变为字符串
		 * datetype: '' 字符串格式yyyy-mm-dd HH:mi:ss;'date' 字符串格式yyyy-mm-dd;'time' 字符串格式HH:mi:ss
		 * 			"yyyy年mm月dd日HH时mi分ss秒" 
		 */
		public static function date2str(date:Date,datetype:String = ""):String
		{
			var datetime:String = "";
			var year:String = date.getFullYear().toString();
			
			var month:String =date.getMonth()+1<10?"0"+(date.getMonth()+1).toString():(date.getMonth()+1).toString();
			var day:String = date.getDate()<10?"0"+date.getDate().toString():date.getDate().toString();
			var hour:String = date.getHours()<10?"0"+date.getHours().toString():date.getHours().toString();
			var minute:String = date.getMinutes()<10?"0"+date.getMinutes().toString():date.getMinutes().toString();
			var second:String = date.getSeconds()<10?"0"+date.getSeconds().toString():date.getSeconds().toString();
			if(datetype=="")
				datetime = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
			else if(datetype=="date")
				datetime = year+"-"+month+"-"+day;
			else if(datetype == "time")
				datetime = hour+":"+minute+":"+second;
			else if(datetype == "yyyy年mm月dd日HH时mi分ss秒")
				datetime = year+"年"+month+"月"+day+"日"+hour+"时"+minute+"分"+second+"秒";
			return datetime;
		}
		
		/**
		 * 字符串变为Date类型  字符串格式yyyy-mm-dd HH:mi:ss
		 */
		public static function str2date(str:String):Date
		{
			if (str == null){
				var d:Date = new Date();
				return new Date(d.fullYear,d.month,d.date,d.hours,d.minutes,d.seconds);;
			}
			
			//匹配 2008-02-02
			var reg:RegExp = /(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)/;
			
			var strdate:String = "";   //日期
			var strtime:String = "";   //时间
			if(str.indexOf(" ")>=0)
			{
				var arr:Array = str.split(" ");
				strdate = arr[0];
				strtime = arr[1];
			}
			else
			{
				strdate = str.substr(0,10);
				
				if(str.length>10)
					strtime = str.substr(10,8);
			}
			
			if(!reg.test(strdate))	
			{
				Alert.show("错误的日期格式!");
				return new Date(); 
			}
			
			var datearr:Array = strdate.split("-");
			var timearr:Array = strtime.indexOf(":")>=0?strtime.split(":"):new Array();
			
			for(var i:int=0;i<3-timearr.length;i++)   //补足00
			{
				timearr.push("00");
			}
			
			return new Date(datearr[0],Number(datearr[1])-1,Number(datearr[2]),Number(timearr[0]),Number(timearr[1]),Number(timearr[1]));
		}
		
		/**
		 * 
		 * 日期字符串比较
		 * param:data1  data2 标准日期格式的字符串 如：2011-11-11 12:01:01
		 * 如果 data1 > data2  返回1;
		 * 如果 data1 < data2  返回-1;
		 * 如果 data1 = data2  返回0;
		 * 
		 * 
		 */ 
		public static function compareDateStr(date1:String,date2:String):Number{
			
			var a1:Array = date1.split(" ");
			var a2:Array = date2.split(" ");
			if(a1.length > 1 && a2.length > 1){
				var d1:String = a1[0];
				var d2:String = a2[0];
				
				var ad1:Array = d1.split("-");
				var ad2:Array = d2.split("-");
				
				for(var i:int=0; i<ad1.length; i++){
					var n1:Number = parseInt(ad1[i]);
					var n2:Number = parseInt(ad2[i]);
					
					if(n1 > n2){
						return 1;
					}else if(n1 < n2){
						return -1;
					}
				}
				var t1:String = a1[1];
				var t2:String = a2[1];
				
				var at1:Array = t1.split(":");
				var at2:Array = t2.split(":");
				for(var i:int=0; i<at1.length; i++){
					var n1:Number = parseInt(at1[i]);
					var n2:Number = parseInt(at2[i]);
					
					if(n1 > n2){
						return 1;
					}else if(n1 < n2){
						return -1;
					}
				}
			}
			return 0;
		}
		
		/**
		 * 
		 * 日期比较
		 * param:data1  data2 日期
		 * 如果 data1 > data2  返回1;
		 * 如果 data1 < data2  返回-1;
		 * 如果 data1 = data2 返回 0
		 * 
		 * 
		 */ 
		public static function compareDate(date1:Date,date2:Date):Number{
			
			var d1:Number = date1.getTime();
			var d2:Number = date2.getTime();
			
			if(d1>d2){
				return 1;
			}else if(d1 < d2){
				return -1;
			}else{
				return 0;
			}
		}
		
		/**
		 * 计算两个时间的时间差
		 * type=sec 返回时间差之间的秒数
		 * type=hms 返回时分秒格式，如hh:mm:ss
		 */ 
		public static function timeDiff(date1:Date,date2:Date,type:String='sec'):String{
			
			var ret:int = compareDate(date1,date2);
			
			if (ret != -1)
				return "-1";
			var time:Number = date2.time - date1.time;
			
//			var year:int = 0;
//			var month:int = 0;
//			var day:int = 0;
			var h:int = 0;
			var m:int = 0;
			var s:int = 0;
			
			if (type == "sec"){
				h = time/1000/60/60;
				m = (time - (h*60*60*1000))/1000/60;
				s = (time - (h*60*60*1000) - (m*60*1000))/1000;
				
				return ((h<10?"0"+h:h) + ":" + (m<10?"0"+m:m) + ":" + (s<10?"0"+s:s));
			}else{
				return time/1000+"";
			}
		}
		
		/**
		 *	得到时段 如12:30-13:00
		 */
		public static function getCurrPlayTime(qdate:Date=null):String{
			if(qdate == null){
				qdate = new Date();
			}
			var res:String  = "";
			var qHour:int = qdate.hours;
			var qHourStr:String = qHour+"";
			if(qHour<10){
				qHourStr = "0"+qHour;
			}
			var qMinute:int = qdate.minutes;
			var qMinuteStr:String = qMinute+"";
			if(qMinute < 10){
				qMinuteStr = "0"+qMinute;
			}
			if(qMinute <30){
				res = qHourStr+":00-"+qHourStr+":30";
			} else{
				qHour += 1;
				var qHourStr = qHour+"";
				if(qHour<10){
					qHourStr = "0"+qHour;
				}
				res = qHourStr+":30-"+qHourStr+":00";
			}
			
			return res;
		}
	}
} 