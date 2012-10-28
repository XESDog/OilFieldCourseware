package com.xesDog.oilField.controller 
{
	
	import com.xesDog.oilField.ApplicationFacad;
	import com.xesDog.oilField.mediator.MenuListMediator;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.ui.UIMenuList;
	import flash.display.DisplayObjectContainer;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
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
			
			if (node.isLeaf()) return;//叶节点没有后续菜单
			
			var menuRoot:DisplayObjectContainer;
			var listMediator:MenuListMediator = facade.retrieveMediator(MenuListMediator.NAME + node.key) as MenuListMediator;
			var list:UIMenuList = listMediator.getViewComponent() as UIMenuList;
			var parentMenuList:MenuListMediator;
			
			//检测和最近点击的按钮是不是同一个
			if (checkIsSameNode(node)) {
				
			}else {
				
			}
			
			
			//第一级菜单
			/*if (node.isRoot()) {
				menuRoot = ApplicationFacad.instance.contextView;
				if (list.stage) {
					menuRoot.removeChild(list);
				}else {
					menuRoot.addChild(list);
				}
			}
			//一级菜单的子孙级菜单
			else {
				parentMenuList = facade.retrieveMediator(MenuListMediator.NAME + node.parent.key) as MenuListMediator;
				menuRoot = parentMenuList.getViewComponent() as UIMenuList;
				if (list.stage) {
					list.parent.removeChild(list);
				}else {
					(menuRoot as UIMenuList).addSonList(list);
				}
			}*/
		}
		
		/* private function */
		/**
		 * 检测和最近一次点击的按钮是不是同一个
		 * @param	node
		 * @return
		 */
		private function checkIsSameNode(node:MenuNode):Boolean {
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			return node == menuProxy.currentNode;
		}
		/**
		 * 获取当前显示的node和当前点击node的深度差值
		 * @param nodeA	当前显示node 
		 * @param nodeB 当前点击node
		 * @return
		 */
		private function getDepthReduce(nodeA:MenuNode,nodeB:MenuNode):int {
			return nodeA.depth() - nodeB.depth();
		}
		/**
		 * 移除该node下面的所有list
		 * @param	node
		 */
		private function removeMenuList(node:MenuNode):void {
			
		}
		/**
		 * 添加该node后面的list
		 * @param	node
		 */
		private function addMenuList(node:MenuNode):void {
			
		}
	}
	
}