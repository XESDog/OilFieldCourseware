package com.xesDog.oilField.controller 
{
	
	import com.xesDog.oilField.mediator.MenuListMediator;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.ui.UIMenuList;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @describe  	...
	 * @author  	Mr.zheng
	 * @website 	@彪客
	 * @time		2013/2/27 15:19
	 */
	public class ShowMenuListCommand extends SimpleCommand
	{
		
		/* override function */
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			addMenuList(notification.getBody() as MenuNode);
		}
		/* private function */
		/**
		 * 添加该node后面的list
		 * @param	node
		 */
		private function addMenuList(node:MenuNode):void
		{
			var listMediator:MenuListMediator = getListMediatorByNode(node);
			var parentMediator:MenuListMediator = getListMediatorByNode(node.parent as MenuNode);
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			var numInParent:int = menuProxy.numInParent(node);
			(parentMediator.getViewComponent() as UIMenuList).addSonList(listMediator.getViewComponent() as UIMenuList,numInParent);
		
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
	}
	
}