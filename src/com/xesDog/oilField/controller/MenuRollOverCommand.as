package com.xesDog.oilField.controller
{
	
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.mediator.MenuListMediator;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.ui.UIMenuList;
	import flash.display.DisplayObject;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @describe  	菜单被点击
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:02
	 */
	public class MenuRollOverCommand extends SimpleCommand
	{
		
		public function MenuRollOverCommand()
		{
			super();
		}
		
		/* public function */
		
		/* override function */
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			var node:MenuNode = notification.getBody() as MenuNode;
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			var currNode:MenuNode = menuProxy.currentRollOverNode;
			if (node.isLeaf())
			{
				return; //叶节点没有后续菜单
			}
			if (currNode == node)
			{
				return;
			}
			//主菜单不响应roll事件 ，只对press响应
			if (menuProxy.isMainMenu(node)) {
				return;
			}
			
			sendNotification(EventConst.OPERATER_SHOWANDHIDE_MENU, node);
		}
		
		/* private function */
		
	}

}