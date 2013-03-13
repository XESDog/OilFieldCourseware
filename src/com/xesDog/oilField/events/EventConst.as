package com.xesDog.oilField.events 
{
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:06
	 */
	public class EventConst
	{
		//鼠标移上
		public static const OPERATE_MENU_ROLLOVER:String = "operate_menu_rollOver";
		//鼠标移走
		static public const OPERATE_MENU_ROLLOUT:String = "operate_MenuRoll_out";
		//鼠标按下
		static public const OPERATE_MENU_PRESS:String = "operate_Menu_Press";
		//读取swf
		public static const SYS_LOAD_SWF:String = "sys_load_swf";
		//读取movie
		public static const SYS_LOAD_VIDEO:String = "sys_load_video";
		//图片加载
		static public const SYS_LOAD_IMAGE:String = "sys_Load_Image";
		//随便播放个颜色
		static public const SYS_COLOR:String = "sys_Color";
		//进度
		public static const SYS_PROGRESS:String = "sys_progress";
		//读取完成
		public static const SYS_LOADED:String = "sys_loaded";
		//出错
		static public const SYS_ERROR:String = "sys_sError";
		
		//视频初始化
		static public const SYS_INIT_VIDEO:String = "sysInitVideo";
		
		//给videolist赋值
		static public const ASSIGN_VIDEO_LIST:String = "assign_video_list";
		//清除videolist
		static public const CLEAR_VIDEO_LIST:String = "clear_video_list";
		
		//显示，隐藏动画控制
		static public const HIDE_ANIMAL_CONTROL:String = "hideAnimalControl";
		
		
		static public const SHOW_ANIMAL_CONTROL:String = "showAnimalControl";
		
		//移除菜单list
		static public const REMOVE_MENU_LIST:String = "removeMenuList";
		//显示菜单list
		static public const SHOW_MENU_LIST:String = "showMenuList";
		
		//暂停动画，继续播放动画
		static public const PAUSE_AND_PLAY_ANIMAL:String = "pause_and_play_animal";
		
	}
	
}