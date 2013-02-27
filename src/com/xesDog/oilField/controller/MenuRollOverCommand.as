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
			/*if (menuProxy.isMainMenu(node)) {
				return;
			}*/
			
			//sendNotification(EventConst.OPERATER_SHOWANDHIDE_MENU, node);
			var depthReduce:int = getDepthReduce(node, currNode);
			
			if (depthReduce < 0)
				{
					var num:int = depthReduce;
					while (num > 0)
					{
						currNode = currNode.parent as MenuNode;
						num--;
					}
					sendNotification(EventConst.REMOVE_MENU_LIST, currNode);
					sendNotification(EventConst.SHOW_MENU_LIST, node);
				}
			if (depthReduce == 0)
			{
				sendNotification(EventConst.REMOVE_MENU_LIST, currNode);
				sendNotification(EventConst.SHOW_MENU_LIST, node);
			}
			if (depthReduce > 0)
			{
				sendNotification(EventConst.SHOW_MENU_LIST, node);
			}
			menuProxy.currentRollOverNode = node;
			
		}
		
		/* private function */
		/**
		 * 获取当前显示的node和当前点击node的深度差值
		 * @param nodeA	当前显示node
		 * @param nodeB 当前点击node
		 * @return
		 */
		private function getDepthReduce(nodeA:MenuNode, nodeB:MenuNode):int
		{
			return nodeA.depth() - nodeB.depth();
		}
	}

}