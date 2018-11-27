package com.morcha4.util
{
	import mx.charts.AreaChart;
	import mx.controls.Alert;

	/**
	 * 提供一些操作XML的方法
	 */ 
	public class XMLUtil
	{
		public function XMLUtil()
		{
		}
		/**
		 * 得到XMLList中符合条件的节点(且enable！=false)
		 * must：若为true则找不到相关项时返回第一项
		 */ 
		public static function getNodeByAttribute(nodes:XMLList,attr:String,currValue:Object,must:Boolean=true,mustEnable:Boolean=false):XML{
			if(mustEnable){
				if(nodes.(attribute(attr)==currValue&&attribute("enable")!="false").length()==0){
					if(must){
						if(nodes.(attribute("enable")!="false").length()==0){
							return null;
						}else{
							nodes.(attribute("enable")!="false")[0].@[attr]=
								(currValue==null||currValue=="")?new XMLList(""):currValue;
							return nodes.(attribute("enable")!="false")[0];
						}
					}else{
						return null;
					}
					
				}else{
					return nodes.(attribute(attr)==currValue&&attribute("enable")!="false")[0];
				}
			}else{
				if(nodes.(attribute(attr)==currValue).length()==0){
					if(must){
						nodes[0].@[attr]=
							(currValue==null||currValue=="")?new XMLList(""):currValue;
						return nodes[0];
					}else{
						return null;
					}
				}else{
					return nodes.(attribute(attr)==currValue)[0];
				}
			}
		}
		/**
		 * 得到node节点下符合条件的叶节点
		 * attr：符合条件的属性
		 * currValue：符合条件的属性值
		 * nodeName：节点名字
		 * queryChild：是否向下查询子节点
		 */ 
		public static function getFNodeByAttribute(node:XML,attr:String,currValue:Object,nodeName:String="node",queryChild:Boolean=true):XML{
			
//			var xml:XML = XMLUtil.getNodeByAttribute(node.*.(name()==nodeName),attr,currValue,false,true);
//			if(xml == null){
//				return node;
//			} else{
//				return xml;
//			}
				trace("nodeName"+nodeName+"==currValue"+currValue);
			if(queryChild){
				if(node[nodeName].length()==0){
					return node;
				}else{
					return getFNodeByAttribute(XMLUtil.getNodeByAttribute(node.*.(name()==nodeName),attr,currValue,true,true),attr,currValue,nodeName);
				}
			} else {
				return node;
			}
		}
		/**
		 * 得到某节点的路径名
		 */ 
		public static function getFullPath(node:XML,nodeName:String,pathAttr:String,del:String="/",callFun:Function=null):String{
			var str:String=node.attribute(pathAttr);
			if(str==""){
//				Alert.show("在节点上找不到属性"+pathAttr+"\n节点:"+node.toXMLString());
				trace("在节点上找不到属性"+pathAttr+"\n节点:"+node.toXMLString());
				return "";
			}
			while(node.parent()&&(node.parent().name()==nodeName)){
				if(callFun!=null){
					callFun(node.parent().*,node);
				}
				node=node.parent();
				if(node.attribute(pathAttr).toString()!=""){
					str=node.attribute(pathAttr)+del+str;
				}else{
//					Alert.show("在节点上找不到属性"+pathAttr+"\n节点:"+node.toXMLString());
					trace("在节点上找不到属性"+pathAttr+"\n节点:"+node.toXMLString());
					return str;
				}
				
			}
			if(callFun!=null){
				callFun(node.parent().*,node);
			}
			str=del+str;
			return str;
		}
		/**
		 * 得到某节点下所有叶节点
		 */ 
		public static function getAllFNode(node:XML,nodeName:String):Array{
			var arr:Array=[];
			if(node[nodeName].length()==0){
				arr.push(node);
			}else{
				for each(var xml:XML in node[nodeName]){
					arr=arr.concat(getAllFNode(xml,nodeName));
				}
			}
			return arr;
		}
		/**
		 * 根据路径名找到节点
		 */ 
		public static function getNodeByPath(nodes:XMLList,path:Array,attr:String,i:int=1,callFun:Function=null):XML{
			var node:XML=XMLUtil.getNodeByAttribute(nodes,attr,path[i]);
			if(callFun!=null){
				callFun(nodes,node);
			}
			if(i!=path.length-1){
				return getNodeByPath(node.*,path,attr,++i,callFun);
			}else{
				return node;
			}
		}
		/**
		 * 自顶向下或自底向上遍历节点
		 */ 
		public static function viewNode(node:XML,nodeName:String,fromTop:Boolean=true,callFun:Function=null):void{
			if(fromTop){
				callFun(node);
			}
			if(node[nodeName].length()!=0){
				for each(var xml:XML in node[nodeName]){
					viewNode(xml,nodeName,fromTop,callFun);
				}
			}
			if(!fromTop){
				callFun(node);
			}
			
		}
	}
}