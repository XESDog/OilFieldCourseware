package com.xesDog.oilField
{
	import com.xesDog.oilField.controller.InitMenuCommand;
	import com.xesDog.oilField.controller.LoadingColorCommand;
	import com.xesDog.oilField.controller.LoadingIMAGECommand;
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
	import com.xesDog.oilField.mediator.BigBtnsMediator;
	import com.xesDog.oilField.mediator.LoadingProgressMediator;
	import com.xesDog.oilField.mediator.MediaContainerMediator;
	import com.xesDog.oilField.mediator.SomeMcsMediator;
	import com.xesDog.oilField.model.ConfigProxy;
	import com.xesDog.oilField.model.LoaderProxy;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.model.SoundProxy;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
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
		private var _mainMc:MovieClip;
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
			registerProxy(new SoundProxy(SoundProxy.NAME));
			registerProxy(new ConfigProxy(ConfigProxy.NAME));
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
			registerCommand(EventConst.SYS_LOAD_IMAGE, LoadingIMAGECommand);
			registerCommand(EventConst.SYS_COLOR, LoadingColorCommand);
			registerCommand(EventConst.OPERATER_SHOWANDHIDE_MENU, ShowAndHideMenuCommand);
		}
		override protected function initializeView():void 
		{
			super.initializeView();
			registerMediator(new MediaContainerMediator(MediaContainerMediator.NAME,new MovieClip()));
			registerMediator(new LoadingProgressMediator(LoadingProgressMediator.NAME, new MovieClip()));
//			registerMediator(new VideoControlBarMediator(VideoControlBarMediator.NAME, new UIVideoControlBar()));
		}
		/* public function */
		public function setUp(contextView:DisplayObjectContainer):void {
			this._contextView = contextView;
			_mainMc = _contextView.getChildByName("mainMc") as MovieClip;
			
			//注册散件管理
			registerMediator(new SomeMcsMediator(SomeMcsMediator.NAME, _mainMc));
			
			var bigBtnsMc:MovieClip = _mainMc.bigBtns_mc;
			registerMediator(new BigBtnsMediator(BigBtnsMediator.NAME, bigBtnsMc));
			
			var content_mc:MovieClip = _mainMc.content_mc;
			//媒体容器
			var mediaContainer:MovieClip = retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as MovieClip;
			content_mc.addChild(mediaContainer);
			ResizeManager.instance.addResizeObj(mediaContainer);
			
			//视频控制条
//			var videoControlBar:UIVideoControlBar = retrieveMediator(VideoControlBarMediator.NAME).getViewComponent() as UIVideoControlBar;
//			content_mc.addChild(videoControlBar);
//			ResizeManager.instance.addResizeObj(videoControlBar);
			
			//进度条容器，进度条在所有对象的最上层
			var loadingProgressMediator:LoadingProgressMediator = retrieveMediator(LoadingProgressMediator.NAME) as LoadingProgressMediator;
			var progressContainer:MovieClip =loadingProgressMediator.getViewComponent() as MovieClip;
			_mainMc.addChild(progressContainer);
			ResizeManager.instance.addResizeObj(progressContainer);
			
			registerMediator(new AppMediator(AppMediator.NAME, _contextView));
			sendNotification(MVC_OVER, contextView);
			
			//默认触发一下主菜单的点击，显示二级菜单
			var node:MenuNode = retrieveProxy(MenuProxy.NAME).getData() as MenuNode;
			sendNotification(EventConst.OPERATE_MENU_PRESS, node.getFirstChild());
		}
		/* private function */
	}
}
class Single{}