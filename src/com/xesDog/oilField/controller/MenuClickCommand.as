package com.xesDog.oilField.controller
{
	
	import com.xesDog.oilField.ApplicationFacad;
	import com.xesDog.oilField.mediator.AppMediator;
	import com.xesDog.oilField.mediator.MenuListMediator;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.ui.UIMenuList;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	菜单被点击
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:02
	 */
	public class MenuClickCommand extends SimpleCommand
	{
		
		public function MenuClickCommand()
		{
			super();
		}
		
		/* public function */
		
		/* override function */
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var node:MenuNode = notification.getBody() as MenuNode;
			
			if (node.isLeaf())
				return; //叶节点没有后续菜单
			
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			var currNode:MenuNode = menuProxy.currentNode;
			//检测和最近点击的按钮是不是同一个
			if (checkIsSameNode(node))
			{
				if (menuInStage(node))
				{
					removeMenuList(node);
				}
				else
				{
					addMenuList(node);
				}
			}
			//点击的不是同一个按钮
			else
			{
				var depthReduce:int = getDepthReduce(node, currNode);
				if (depthReduce < 0)
				{
					var num:int = depthReduce;
					while (num > 0)
					{
						currNode = currNode.parent as MenuNode;
						num--;
					}
					removeMenuList(currNode);
					addMenuList(node);
				}
				if (depthReduce == 0)
				{
					removeMenuList(currNode);
					addMenuList(node);
				}
				if (depthReduce > 0)
				{
					addMenuList(node);
				}
			}
			menuProxy.currentNode = node;
		}
		
		/* private function */ /**
		 * 检测和最近一次点击的按钮是不是同一个
		 * @param	node
		 * @return
		 */
		private function checkIsSameNode(node:MenuNode):Boolean
		{
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			return node == menuProxy.currentNode;
		}
		
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
		
		/**
		 * 根据node获取对应的list mediator
		 * @param	node
		 * @return
		 */
		private function getListMediatorByNode(node:MenuNode):MenuListMediator
		{
			var mediator:MenuListMediator = facade.retrieveMediator(MenuListMediator.NAME + node.key) as MenuListMediator;
			return mediator;
		}
		
		/**
		 * node对应的菜单list是都在舞台上
		 *
		 * @param	node
		 * @return
		 */
		private function menuInStage(node:MenuNode):Boolean
		{
			var viewComponent:DisplayObject = getListMediatorByNode(node).getViewComponent() as DisplayObject;
			return viewComponent.stage != null;
		}
		
		/**
		 * 移除该node下面的所有list
		 * @param	node
		 */
		private function removeMenuList(node:MenuNode):void
		{
			var parentMediator:MenuListMediator = getListMediatorByNode(node.parent as MenuNode);
			(parentMediator.getViewComponent() as UIMenuList).removeSonList();
		}
		
		/**
		 * 添加该node后面的list
		 * @param	node
		 */
		private function addMenuList(node:MenuNode):void
		{
			var listMediator:MenuListMediator = getListMediatorByNode(node);
			var parentMediator:MenuListMediator = getListMediatorByNode(node.parent as MenuNode);
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			
			(parentMediator.getViewComponent() as UIMenuList).addSonList(listMediator.getViewComponent() as UIMenuList,menuProxy.isMainMenu(node));
		
		}
	}

}