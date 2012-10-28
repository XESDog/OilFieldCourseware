package com.xesDog.oilField.mediator 
{
	
	import com.bit101.components.PushButton;
	import com.xesDog.oilField.ApplicationFacad;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.ui.UIMenu;
	import com.xesDog.oilField.ui.UIMenuList;
	import flash.ui.ContextMenuBuiltInItems;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	主菜单按钮，点击之后弹出菜单list
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:04
	 */
	public class MenuMediator extends Mediator
	{
		private var _uiMenu:UIMenu;
		public static const MENU_X:int=20;
		public static const MENU_Y:int=500;
		public static const NAME:String = "menu_Mediator";
		/**
		 * 
		 * @param	mediatorName
		 * @param	viewComponent 值是文档类
		 */
		public function MenuMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
		}
		override public function onRemove():void 
		{
			super.onRemove();
		}
		override public function listNotificationInterests():Array 
		{
			return [ApplicationFacad.MVC_OVER];
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			var node:MenuNode = facade.retrieveProxy(MenuProxy.NAME).getData() as MenuNode;
			var menuItemMediator:MenuItemMediator = facade.retrieveMediator(MenuItemMediator.NAME + node.key) as MenuItemMediator;
			var uiMenu:UIMenu;
			switch (notification.getName()) 
			{
				case ApplicationFacad.MVC_OVER:
					uiMenu = menuItemMediator.getViewComponent() as UIMenu;
					viewComponent.addChild(uiMenu);
					//TODO:主菜单的位置
					uiMenu.x = 10;
					uiMenu.y = 500;
				break;
				default:
			}
		}
		/* private function */

	}
	
}