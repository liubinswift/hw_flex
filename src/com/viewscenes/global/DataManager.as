package com.viewscenes.global
{
	import com.morcha4.RPC.RPCException;
	import com.viewscenes.beans.pub.ResHeadendBean;
	import com.viewscenes.beans.user.PubUserBean;
	import com.viewscenes.global.comp.MM;
	
	import mx.collections.ArrayCollection;;
	import mx.controls.Alert;
	
	import spark.components.Label;

	/*************************
	 * 系统公共数据存放
	 *************************/

	public class DataManager
	{
		public static  var server_default_id = "dataServer";
		public static  var server_app_id = "dataServer_app";
		public static  var code:String="";//存放系统拓扑点击某个站点导航时的站点code
		/**
		 *  大洲
		 * */
		[Bindable]
		public static var statetypeColl:ArrayCollection = new ArrayCollection(
			[  {label:"亚洲", data:0}, 
				{label:"欧洲", data:1},
				{label:"非洲", data:2}, 
				{label:"北美洲", data:3},
				{label:"南美洲", data:4}, 
				{label:"大洋洲", data:5},
				{label:"南极洲", data:6} ]);
		[Bindable]
		public  static var bpsColl:ArrayCollection = new ArrayCollection(
			[ {label:"8000", data:"8000"}, 
				{label:"16000", data:"16000"},
				{label:"32000", data:"32000"},
				{label:"64000", data:"64000"},
				{label:"128000", data:"128000"} ]);
		[Bindable]
		public  static var upTypeColl:ArrayCollection = new ArrayCollection(
			[ {label:"不主动上报结果", data:"2"}, 
				{label:"等待间隔后上报", data:"1"}]);
		[Bindable]
		public static var dayofweekColl:ArrayCollection = new ArrayCollection(
			[ {label:"每天", data:"All"}, 
				{label:"周日", data:"0"},
				{label:"周一", data:"1"},
				{label:"周二", data:"2"},
				{label:"周三", data:"3"},
				{label:"周四", data:"4"},
				{label:"周五", data:"5"},
				{label:"周六", data:"6"}]);
		[Bindable]
		public static var bandColl:ArrayCollection = new ArrayCollection(
			[  {label:"短波", data:"0"}, 
				{label:"中波", data:"1"}, 
				{label:"调频", data:"2"} ]);
		[Bindable]
		public static var bandCollWithAll:ArrayCollection = new ArrayCollection(
			[  {label:"全部", data:""}, 
				{label:"短波", data:"0"}, 
				{label:"中波", data:"1"}, 
				{label:"调频", data:"2"} ]);
		[Bindable]
		public static var taskHeadenEqu:ArrayCollection = new ArrayCollection(
			[ {label:"自动选择", data:""},
				{label: "R1", data: "R1"}, {label: "R2", data: "R2"},
				{label: "R3", data: "R3"}, {label: "R4", data: "R4"},
				{label: "R5", data: "R5"}, {label: "R6", data: "R6"},
				{label: "R7", data: "R7"}, {label: "R8", data: "R8"},
				{label: "R9", data: "R9"}, {label: "R10", data: "R10"},
				{label: "R11", data: "R11"}, {label: "R12", data: "R12"},
				{label: "R13", data: "R13"}, {label: "R14", data: "R14"},
				{label: "R15", data: "R15"}, {label: "R16", data: "R16"},
				{label: "R17", data: "R17"}, {label: "R18", data: "R18"},
				{label: "R19", data: "R19"}, {label: "R20", data: "R20"},
				{label: "R21", data: "R21"}, {label: "R22", data: "R22"},
				{label: "R23", data: "R23"}, {label: "R24", data: "R24"},
				{label: "R25", data: "R25"}, {label: "R26", data: "R26"},
				{label: "R27", data: "R27"}, {label: "R28", data: "R28"},
				{label: "R29", data: "R29"}, {label: "R30", data: "R30"},
				{label: "R31", data: "R31"}, {label: "R32", data: "R32"}]);
		/**
		 * 菜单配置 
		 */		
		public static var menu:XML;
		/**
		 * 与设备交互后台服务的地址
		 */		
		public static var dataServerAppAddress:String = "";
		/**
		 * 当前报警数量
		 */
		[Bindable]
		public static var alarmNum:int = 0;
		/**
		 * 当前用户信息
		 */
		public static var user:PubUserBean =new PubUserBean;
		/**
		 * 大洲Bean集合
		 */
		public static var satateBeanArr:ArrayCollection = new ArrayCollection();
		/**
		* 大洲Bean集合带全部的
		*/
		[Bindable]
		public static var satateBeanArrAll:ArrayCollection = new ArrayCollection();
		/**
		 * 站点Bean集合
		 */
		[Bindable]
		public static var headendBeanArr:ArrayCollection = new ArrayCollection();
		
		/**
		 * 站点Bean集合全部带ALL
		 */
		[Bindable]
		public static var headendBeanAll:ArrayCollection = new ArrayCollection();
		/**
		 * 站点Bean集合(遥控站的站点AB当成一个)
		 */
		[Bindable]
		public static var headendNoABArr:ArrayCollection = new ArrayCollection();
		
		/**
		 * 已经创建的模块
		 */
		public static var createdModuleObj:Object = new Object();
		/**
		 * 发射台集合  发射台 station_id name
		 */
		[Bindable]
		public static var stationBeanAll:ArrayCollection = new ArrayCollection();
		/**
		 * 语言集合 语言 language_id language_name
		 */
		[Bindable]
		public static var languageBeanAll:ArrayCollection = new ArrayCollection();
		public function DataManager()
		{
		}

		
		
		/**
		 * 根据站点code得到站点是否在线。
		 */
		public static function getHeadendIsOnline(code:String):Boolean{
			for(var i:int=0;i<headendBeanArr.length;i++)
			{
				var headend:ResHeadendBean=headendBeanArr.getItemAt(i) as ResHeadendBean;
				if(headend.code==code)
				{
					if(headend.is_online=="true")
					{
						return true;
					}
					else 
						return false;
				}
			}
			return false;	
		}
		
		
		/**
		 * 根据大洲得到站点不区分AB,stationType:all全部，101采集点，102遥控站。
		 */
		public static function headendNoABArrByState(state:String,stationType:String):ArrayCollection{
			
			var returnArrayColl:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<headendBeanArr.length;i++)
			{
				var headend:ResHeadendBean=headendBeanArr.getItemAt(i) as ResHeadendBean;
				
				if(stationType=="all")
				{
					if(state=="all"){
						returnArrayColl.addItem(headend);
					}
					if(headend.state==state){
						
						returnArrayColl.addItem(headend);
					}
				}else
				{
					if(headend.state==state&&headend.type_id==stationType){
						returnArrayColl.addItem(headend);
					}
				}
				
			}
		
			return returnArrayColl;
		}
		
		/**
		 * 根据大洲得到站点,stationType:all全部，101采集点，102遥控站。
		 */
		public static function getHeadendByState(state:String,stationType:String):ArrayCollection{
			
			var returnArrayColl:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<headendBeanArr.length;i++)
			{
				var headend:ResHeadendBean=headendBeanArr.getItemAt(i) as ResHeadendBean;
				
				if(stationType=="all")
				{
					if(state=="all"){
						returnArrayColl.addItem(headend);
					}
					if(headend.state==state){
						
						returnArrayColl.addItem(headend);
					}
				}else
				{
					if(headend.state==state&&headend.type_id==stationType){
						returnArrayColl.addItem(headend);
					}
				}
				
			}
			
			return returnArrayColl;
		}
		
		/**
		 * 获取在线的站点
		 */
		public static function getOnline_Headend():ArrayCollection{
			
			var returnArrayColl:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<headendBeanArr.length;i++)
			{
				var headend:ResHeadendBean=headendBeanArr.getItemAt(i) as ResHeadendBean;
				
				if(headend.is_online=="1")
				{
						
						returnArrayColl.addItem(headend);
				}
			}
			
			return returnArrayColl;
		}
		
		/**
		 * 根据名称得到站点
		 */
		public static function getHeadendByName(shortname:String):ArrayCollection{
			var returnArrayColl:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<headendBeanArr.length;i++)
			{
				var headend:ResHeadendBean=headendBeanArr.getItemAt(i) as ResHeadendBean;
				
				if(headend.shortname.indexOf(shortname)>-1){
					returnArrayColl.addItem( headend);
				}
				
			}
			
			return returnArrayColl;
		}
		/**
		 * 根据code得到站点
		 */
		public static function getHeadendByCode(code:String):ResHeadendBean{
			var returnArrayColl:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<headendBeanArr.length;i++)
			{
				var headend:ResHeadendBean=headendBeanArr.getItemAt(i) as ResHeadendBean;
				
				if(headend.code==code){
					return headend;
				}
				
			}
			
			return null;
		}

		/**
		 * 根据code得到站点(从不分AB的站点列表中读取)
		 */
		public static function getHeadendByCodeNoAB(code:String):ResHeadendBean{
			var returnArrayColl:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<headendNoABArr.length;i++)
			{
				var headend:ResHeadendBean=headendNoABArr.getItemAt(i) as ResHeadendBean;
				if(headend.code==code){
					
					return headend;
				}
				
			}
			
			return null;
		}
		/**
		 * 根据ID得到站点
		 */
		public static function getHeadendById(id:String):ResHeadendBean{
			var returnArrayColl:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<headendBeanArr.length;i++)
			{
				var headend:ResHeadendBean=headendBeanArr.getItemAt(i) as ResHeadendBean;
				
				if(headend.head_id==id){
					return headend;
				}
				
			}
			
			return null;
		}

	
		/**
		 * 返回错误方法，输出错误信息
		 */
		public static function showErrorMessageBack(obj:RPCException,priObj:Object=null):void{
			MM.show(obj.message,"提示");
		}
		/**
		 * 返回错误方法Alert，输出错误信息
		 */
		public static function alertShowErrorMessageBack(obj:RPCException,priObj:Object=null):void{
			Alert.show(obj.message);
		}
		/**
		 * 输出错误信息
		 */
		public static function showErrorMessage(message:String):void{
			MM.show(message,"提示");
		}
		/**
		* Alert输出错误信息
		*/
		public static function alertShowErrorMessage(message:String):void{
			Alert.show(message);
		}
		
		/**
		 * 控制datagrid的提示框是否显示，以及显示内容
		 * author:cht
		 * **/
		public static function datagridTrip(_component:spark.components.Label,_visible:Boolean,_label:String="")
		{
			_component.visible=_visible;
			_component.includeInLayout=_visible;
			_component.text=_label;
		}
	}
	
}