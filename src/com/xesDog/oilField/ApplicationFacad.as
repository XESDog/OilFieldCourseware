package com.xesDog.oilField
{
	import com.bit101.components.ProgressBar;
	import com.xesDog.oilField.controller.InitMenuCommand;
	import com.xesDog.oilField.controller.LoadingColorCommand;
	import com.xesDog.oilField.controller.LoadingSWFCommand;
	import com.xesDog.oilField.controller.LoadingVIDEOCommand;
	import com.xesDog.oilField.controller.MenuPressCommand;
	import com.xesDog.oilField.controller.MenuRollOutCommand;
	import com.xesDog.oilField.controller.MenuRollOverCommand;
	import com.xesDog.oilField.controller.ShowAndHideMenuCommand;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.manager.ResizeManager;
	import com.xesDog.oilField.manager.XmlManager;
	import com.xesDog.oilField.mediator.AppMediator;
	import com.xesDog.oilField.mediator.LoadingProgressMediator;
	import com.xesDog.oilField.mediator.MediaContainerMediator;
	import com.xesDog.oilField.mediator.VideoControlBarMediator;
	import com.xesDog.oilField.model.LoaderProxy;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.ui.UIVideoControlBar;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import org.puremvc.as3.patterns.facade.Facade;
	
	
	
	/**
	 * 
	 * 单例模式类
	 * @describe		...
	 * @author			zihua.zheng
	 * @time 			2012-10-27 13:02
	 */
	public class ApplicationFacad extends Facade
	{
		private static var _instance:ApplicationFacad = null;
		
		public function ApplicationFacad(single:Single){
			super();
			
			if(single == null)
			{
				throw new Error("Can't create instance , Single is Null!");
			}
		}
		/**
		 * 单例引用
		 */
		public static function get instance():ApplicationFacad
		{
			if(_instance == null)
			{
				_instance = new ApplicationFacad(new Single());
			}
			return _instance;
		}
		
		public function get contextView():DisplayObjectContainer 
		{
			return _contextView;
		}
		
		//start-----------------------------------------------------------------------------
		private var _contextView:DisplayObjectContainer;
		/**
		 * mvc初始化完毕
		 */
		public static const MVC_OVER:String = "mvc_over";
		/** override function */
		override protected function initializeModel():void 
		{
			super.initializeModel();
			//注册menuProxy
			registerProxy(new MenuProxy(MenuProxy.NAME, XmlManager.instance.menuNode));
			registerProxy(new LoaderProxy(LoaderProxy.NAME));
		}
		override protected function initializeController():void 
		{
			super.initializeController();
			
			registerCommand(MVC_OVER, InitMenuCommand);
			registerCommand(EventConst.OPERATE_MENU_ROLLOVER, MenuRollOverCommand);
			registerCommand(EventConst.OPERATE_MENU_PRESS, MenuPressCommand);
			registerCommand(EventConst.OPERATE_MENU_ROLLOUT, MenuRollOutCommand);
			registerCommand(EventConst.SYS_LOAD_SWF, LoadingSWFCommand);
			registerCommand(EventConst.SYS_LOAD_VIDEO, LoadingVIDEOCommand);
			registerCommand(EventConst.SYS_COLOR, LoadingColorCommand);
			registerCommand(EventConst.OPERATER_SHOWANDHIDE_MENU, ShowAndHideMenuCommand);
		}
		override protected function initializeView():void 
		{
			super.initializeView();
			registerMediator(new MediaContainerMediator(MediaContainerMediator.NAME,new MovieClip()));
			registerMediator(new LoadingProgressMediator(LoadingProgressMediator.NAME, new MovieClip()));
			registerMediator(new VideoControlBarMediator(VideoControlBarMediator.NAME, new UIVideoControlBar()));
		}
		/* public function */
		public function setUp(contextView:DisplayObjectContainer):void {
			this._contextView = contextView;
			//媒体容器
			var mediaContainer:MovieClip = retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as MovieClip;
			ResizeManager.instance.addResizeObj(mediaContainer);
			this._contextView.addChild(mediaContainer);
			
			//视频控制条
			var videoControlBar:UIVideoControlBar = retrieveMediator(VideoControlBarMediator.NAME).getViewComponent() as UIVideoControlBar;
			ResizeManager.instance.addResizeObj(videoControlBar);
			this._contextView.addChild(videoControlBar);
			
			//进度条容器
			var loadingProgressMediator:LoadingProgressMediator = retrieveMediator(LoadingProgressMediator.NAME) as LoadingProgressMediator;
			var progressContainer:MovieClip =loadingProgressMediator.getViewComponent() as MovieClip;
			ResizeManager.instance.addResizeObj(progressContainer);
			this._contextView.addChild(progressContainer);
			
			registerMediator(new AppMediator(AppMediator.NAME, _contextView));
			sendNotification(MVC_OVER,contextView);
		}
		/* private function */
	}
}
class Single{}