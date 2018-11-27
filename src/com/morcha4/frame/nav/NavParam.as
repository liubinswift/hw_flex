package  com.morcha4.frame.nav
{
	public class NavParam extends Object
	{
		/**
		 * 当次导航需要传递到新页面的参数
		 */ 
		public var param:Object=null;
		/**
		 * 当次导航要到达的页面路径，若此参数不为null则忽略node参数。
		 */ 
		public var path:Object=null;
		/**
		 * 当次导航要到达的页面节点，主要用于目录导航，程序中显示导航用path参数。
		 */ 
		public var node:Object=null;
		public var isnew:Boolean=true;
		public function NavParam(param:Object=null,path:String=null,node:XML=null)
		{
			super();
			this.param=param;
			this.path=path;
			this.node=node;
		}
	}
}