package com.viewscenes.global
{
	/**
	 * 
	 * @author lb
	 * 系统事件声明处，便与管理维护
	 */	
	public class EventDeclare
	{
		public function EventDeclare()
		{
		}
		/**
		 * 用户登录成功 
		 */		
		public static const LOGIN_SECCESS:String				="LOGIN_SECCESS";
		/**
		 * 初始化状态发生变化 
		 */		
		public static const SYSTEM_INIT_STATE:String			="system_init_state";
		/**
		 * 系统初始化完毕 
		 */		
		public static const SYSTEM_INIT_COMPLETED:String		="system_init_completed";
		
		/**
		 * 设置了同一事件源的公共事件
		 * */
		public static const COMMUNITY_BROADCAST:String 			= "community_broadcast";
		/**
		 * 系统错误事件
		 */
		public static const APP_ERROR:String 					= "appError";
		/**
		 *站点改变事件
		 */ 
		public static const STATION_CHANGE:String           	= "station_change";
		/**
		 * 
		 * 改变站点下拉列表的选中项
		 */ 
		public static const CHANGE_STATION_ITEM:String        = "change_station_item";
		/**
		 * 页面最大化事件
		 */
		public static const BIG_SCREEN:String = "use_big_screen";
		/**
		 * 页面全屏事件
		 */
		public static const FULL_SCREEN:String = "use_full_screen";
		
		/**
		 * 使原子组件显示事件
		 */ 
		public static const ATOM_SHOW:String = "atom_show";
		
		/**
		 * 使原子组件关闭事件
		 */ 
		public static const ATOM_CLOSE:String = "atom_close";
		/**
		 * 用户登录传递用户名事件
		 */ 
		public static const LOGIN_USERNAME:String = "login_username";
		/**
		 * 通过频谱新增任务事件
		 */ 
		public static const ADD_TASK_SPECTRUM:String = "add_task_spectrum";
		/**
		 * 显示二级菜单的时候出发事件
		 */ 
		public static const SHOW_MENU_2:String = "show_menu_2";
		/**
		 * 为其它模块提供的选择运行图发送的事件名称
		 * */
		public static const RUNPLAN:String="runplan";
		
	}
}