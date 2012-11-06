package com.xesDog.oilField
{
	import com.xesDog.oilField.controller.InitMenuCommand;
	import com.xesDog.oilField.controller.LoadingSWFCommand;
	import com.xesDog.oilField.controller.LoadingVIDEOCommand;
	import com.xesDog.oilField.controller.MenuPressCommand;
	import com.xesDog.oilField.controller.MenuRollOutCommand;
	import com.xesDog.oilField.controller.MenuRollOverCommand;
	import com.xesDog.oilField.controller.ShowAndHideMenuCommand;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.manager.XmlManager;
	import com.xesDog.oilField.mediator.AppMediator;
	import com.xesDog.oilField.mediator.LoadingProgressMediator;
	import com.xesDog.oilField.mediator.MediaContainerMediator;
	import com.xesDog.oilField.model.LoaderProxy;
	import com.xesDog.oilField.model.MenuProxy;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
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
			registerCommand(EventConst.OPERATER_SHOWANDHIDE_MENU, ShowAndHideMenuCommand);
		}
		override protected function initializeView():void 
		{
			super.initializeView();
			registerMediator(new MediaContainerMediator(MediaContainerMediator.NAME,new Sprite()));
			registerMediator(new LoadingProgressMediator(LoadingProgressMediator.NAME,new Sprite()));
		}
		/* public function */
		public function setUp(contextView:DisplayObjectContainer):void {
			this._contextView = contextView;
			//媒体容器
			var mediaContainer:Sprite = retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as Sprite;
			this._contextView.addChild(mediaContainer);
			
			//进度条
			var progressContainer:Sprite = retrieveMediator(LoadingProgressMediator.NAME).getViewComponent() as Sprite;
			this._contextView.addChild(progressContainer);
			progressContainer.x = _contextView.stage.stageWidth >> 1;
			progressContainer.y = _contextView.stage.stageHeight >> 1;
			
			registerMediator(new AppMediator(AppMediator.NAME, _contextView));
			sendNotification(MVC_OVER,contextView);
		}
		/* private function */
	}
}
class Single{}