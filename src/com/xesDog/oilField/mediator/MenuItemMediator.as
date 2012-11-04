package com.xesDog.oilField.mediator 
{
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import flash.events.MouseEvent;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:42
	 */
	public class MenuItemMediator extends Mediator
	{
		/**
		 * 该菜单项的描述
		 */
		private var _menuNode:MenuNode;
		
		static public const NAME:String = "menu_item_mediator";
		
		public function MenuItemMediator(menuNode:MenuNode,mediatorName:String="",viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			_menuNode = menuNode;
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
			viewComponent.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			viewComponent.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver);
			viewComponent.addEventListener(MouseEvent.ROLL_OUT, onMouseRollOut);
		}
		
		private function onMouseRollOut(e:MouseEvent):void 
		{
			//sendNotification(EventConst.OPERATE_MENU_ROLLOUT, _menuNode);
		}
		
		private function onMouseRollOver(e:MouseEvent):void 
		{
			sendNotification(EventConst.OPERATE_MENU_ROLLOVER, _menuNode);
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			viewComponent.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			viewComponent.removeEventListener(MouseEvent.ROLL_OVER, onMouseRollOver);
			viewComponent.removeEventListener(MouseEvent.ROLL_OUT, onMouseRollOut);
		}
		/* private function */
		private function onMouseDown(e:MouseEvent):void 
		{
			trace("点击:" + _menuNode.val.name);
			sendNotification(EventConst.OPERATE_MENU_PRESS, _menuNode);

		}
	}
	
}