package com.xesDog.oilField.mediator 
{
	
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.ui.UIMenu;
	import com.xesDog.oilField.ui.UIMenuList;
	import flash.events.MouseEvent;
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
		/**
		 * 在舞台上
		 */
		public function get inStage():Boolean {
			return viewComponent.stage != null;
		}
		/**
		 * 添加到舞台
		 */
		public function addToStage():void {
			
		}
		/**
		 * 移除出舞台
		 */
		public function removeToStage():void {
			
		}
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
			viewComponent.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		override public function onRemove():void 
		{
			super.onRemove();
			viewComponent.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		override public function listNotificationInterests():Array 
		{
			return [EventConst.OPERATE_MENU_ROLLOVER];
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			switch(notification.getName()) {
				case EventConst.OPERATE_MENU_ROLLOVER:
					
				break;
			}
		}
		/* private function */
		private function onRollOut(e:MouseEvent):void 
		{
			sendNotification(EventConst.OPERATE_MENU_ROLLOUT, _menuNode);
		}
	}
	
}