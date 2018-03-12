package  com.morcha4.frame.transEffects
{
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	public class Mask extends UIComponent
	{
		private var ltr:Boolean=true;
		public function Mask(num:int=10,during:int=500,ratio:Number=0.5,ltr:Boolean=true)
		{
			this.ltr=ltr;
			super();
			this.num=num<1?10:num;
			this.during=during<50?500:during;
			this.ratio=ratio<0?0:(ratio>1?1:ratio);
			proTime=this.during/((this.num-1)*this.ratio+1);
			proDuring=proTime*this.ratio;
		}
		private var proTime:int;
		private var proDuring:int;
		private var num:int;
		private var during:int;
		private var ratio:Number;
		private var _time:int;
		public function set time(value:int):void{
			_time=value;
			invalidateDisplayList();
		}
		override protected function updateDisplayList(uw:Number, uh:Number):void{
			super.updateDisplayList(uw,uh);
			graphics.clear();
			//top->bottom
//			graphics.beginFill(0x000000,1);
//			for(var i:int=1;i<=num;i++){
//				if(getStartTime(i)<=_time){
////					graphics.drawRect(getStartPosition(i,uw),0,getStepLen(i,_time,uw),uh);
//					graphics.drawRect(0,getStartPosition(i,uh),uw,getStepLen(i,_time,uh));
//				}
//			}
//			graphics.endFill();
			
			graphics.beginFill(0x000000,1);
			if(ltr){
				//left->right
				for(var i:int=1;i<=num;i++){
					if(getStartTime(i)<=_time){
						graphics.drawRect(getStartPosition(i,uw),0,getStepLen(i,_time,uw),uh);
						//					graphics.drawRect(0,getStartPosition(i,uh),uw,getStepLen(i,_time,uh));
					}
				}
			}else{
				//right->left
				for(var i:int=1;i<=num;i++){
					if(getStartTime(i)<=_time){
						graphics.drawRect(uw-getStartPosition(i,uw)-getStepLen(i,_time,uw),0,getStepLen(i,_time,uw),uh);
					}
				}
			}
			graphics.endFill();
//			graphics.beginFill(0x000000,1);
//			for(var i:int=1;i<=num;i++){
//				if(getStartTime(i)<=_time){
//					graphics.drawRect(0,uh-getStartPosition(i,uh)-getStepLen(i,_time,uh),uw,getStepLen(i,_time,uh));
//				}
//			}
//			graphics.endFill();
		}
		private function getStartTime(n:int):int{
			return (n-1)*proDuring;
		}
		private function getStartPosition(n:int,len:int):int{
			return (n-1)*len/num;
		}
		private function getStepLen(n:int,t:int,len:int):int{
			var di:int=t-getStartTime(n);
			if(di>=proTime){
				return getStartPosition(n+1,len);//len/num;
			}else{
				return (t-getStartTime(n))*(len/num/proTime);
			}
			
		}
	}
}