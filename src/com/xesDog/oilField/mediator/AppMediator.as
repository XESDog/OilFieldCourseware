package com.xesDog.oilField.mediator 
{
	
	import com.bit101.components.PushButton;
	import com.xesDog.oilField.ApplicationFacad;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	主菜单按钮，点击之后弹出菜单list
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:04
	 */
	public class AppMediator extends Mediator
	{
		public static const NAME:String = "app_Mediator";
		/**
		 * 
		 * @param	mediatorName
		 * @param	viewComponent 值是文档类
		 */
		public function AppMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
			viewComponent.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		override public function onRemove():void 
		{
			super.onRemove();
			viewComponent.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		override public function listNotificationInterests():Array 
		{
			return [ApplicationFacad.MVC_OVER];
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			switch (notification.getName()) 
			{
				case ApplicationFacad.MVC_OVER:
				break;
				default:
			}
		}
		/* private function */
		private function onMouseDown(e:MouseEvent):void 
		{
			if (e.target is PushButton) {
				
			}
			//点击在菜单外围，如果菜单处于显示状态，则将其关闭
			else {
				var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
				var mainMenu:MenuNode = menuProxy.getData().getFirstChild() as MenuNode;
				var listMediator:MenuListMediator = facade.retrieveMediator(MenuListMediator.NAME + mainMenu.key) as MenuListMediator
				if(listMediator.inStage){
					sendNotification(EventConst.OPERATER_SHOWANDHIDE_MENU, mainMenu );
				}
			}
		}
	}
}