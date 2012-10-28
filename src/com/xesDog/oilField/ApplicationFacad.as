package com.xesDog.oilField
{
	import com.xesDog.oilField.controller.InitMenuCommand;
	import com.xesDog.oilField.controller.MenuClickCommand;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.manager.XmlManager;
	import com.xesDog.oilField.mediator.MenuMediator;
	import com.xesDog.oilField.model.MenuProxy;
	import flash.display.DisplayObjectContainer;
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
			registerProxy(new MenuProxy(MenuProxy.NAME,XmlManager.instance.menuNode));
		}
		override protected function initializeController():void 
		{
			super.initializeController();
			
			registerCommand(MVC_OVER, InitMenuCommand);
			registerCommand(EventConst.OPERATE_MENU_CLICK, MenuClickCommand);
		}
		override protected function initializeView():void 
		{
			super.initializeView();
		}
		/* public function */
		public function setUp(contextView:DisplayObjectContainer):void {
			this._contextView = contextView;
			registerMediator(new MenuMediator(MenuMediator.NAME, _contextView));
			sendNotification(MVC_OVER,contextView);
		}
		/* private function */
	}
}
class Single{}