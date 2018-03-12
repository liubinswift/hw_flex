package com.morcha4.util
{
	import mx.controls.Alert;
	
	public class Queue
	{
		private var sourearr:Array=new Array();
		private var max:int;
		private var curr:int=-1;
		public function Queue(max:int=100)
		{
			if(max>0){
				this.max=max;
			}else{
				Alert.show("队列中的元素个数应该为正整数。");
			}
		}
		/**
		 * 那段是否还有下一个或前一个元素
		 */
		public function hasnext():Boolean{
			return curr!=sourearr.length-1;
		}
		public function haspre():Boolean{
			return curr>0;
		}
		/**
		 * 加入一个新元素,最多容纳max个元素的队列
		 */ 
		public function push(obj:Object):void{
			if(obj==null){
				Alert.show("队列中的元素不能为null。");
			}
			sourearr[++curr]=obj;
			if(sourearr[curr+1]){
				sourearr.splice(curr+1);
			}
			if(curr==max){
				sourearr.shift();
				curr--;
			}
		}
		/**
		 * 导航到下一元素
		 */ 
		public function getnext():Object{
			if(hasnext()){
				return sourearr[++curr];
			}else{
				return null;
			}
		}
		/**
		 * 导航到前一元素
		 */ 
		public function getpre():Object{
			if(haspre()){
				return sourearr[--curr];
			}else{
				return null;
			}
		}
	}
}