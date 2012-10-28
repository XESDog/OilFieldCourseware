package com.xesDog.oilField.mediator 
{
	
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.ui.UIMenu;
	import com.xesDog.oilField.ui.UIMenuList;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:29
	 */
	public class MenuListMediator extends Mediator
	{
		private var _menuNode:MenuNode;
		public static const NAME:String = "menu_list_mediator";
		public function MenuListMediator(menuNode:MenuNode,mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			_menuNode = menuNode;
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
			//addMenu();
		}
		override public function onRemove():void 
		{
			super.onRemove();
		}
		override public function listNotificationInterests():Array 
		{
			return [EventConst.OPERATE_MENU_CLICK];
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			switch(notification.getName()) {
				case EventConst.OPERATE_MENU_CLICK:
					
				break;
			}
		}
		/* private function */

	}
	
}