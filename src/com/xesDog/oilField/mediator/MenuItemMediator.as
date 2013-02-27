package com.xesDog.oilField.mediator 
{
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.SoundProxy;
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
		private var _soundProxy:SoundProxy;
		
		static public const NAME:String = "menu_item_mediator";
		
		public function MenuItemMediator(menuNode:MenuNode,mediatorName:String="",viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			_menuNode = menuNode;
			
			_soundProxy = facade.retrieveProxy(SoundProxy.NAME) as SoundProxy;
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
			viewComponent.addEventListener(MouseEvent.CLICK, onMouseDown);
			viewComponent.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver);
			viewComponent.addEventListener(MouseEvent.ROLL_OUT, onMouseRollOut);
		}
		override public function onRemove():void 
		{
			super.onRemove();
			viewComponent.removeEventListener(MouseEvent.CLICK, onMouseDown);
			viewComponent.removeEventListener(MouseEvent.ROLL_OVER, onMouseRollOver);
			viewComponent.removeEventListener(MouseEvent.ROLL_OUT, onMouseRollOut);
		}
		private function onMouseRollOut(e:MouseEvent):void 
		{
			//sendNotification(EventConst.OPERATE_MENU_ROLLOUT, _menuNode);
			_soundProxy.playRollOut();
		}
		
		private function onMouseRollOver(e:MouseEvent):void 
		{
			sendNotification(EventConst.OPERATE_MENU_ROLLOVER, _menuNode);
			_soundProxy.playRollOver();
		}
		/* private function */
		private function onMouseDown(e:MouseEvent):void 
		{
			sendNotification(EventConst.OPERATE_MENU_PRESS, _menuNode);
			_soundProxy.playPress();
		}
	}
	
}