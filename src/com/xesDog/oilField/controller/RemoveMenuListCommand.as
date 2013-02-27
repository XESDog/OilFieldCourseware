package com.xesDog.oilField.controller 
{
	
	import com.xesDog.oilField.mediator.MenuListMediator;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.ui.UIMenuList;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @describe  移除菜单list
	 * @author  	Mr.zheng
	 * @website 	@彪客
	 * @time		2013/2/27 15:02
	 */
	public class RemoveMenuListCommand extends SimpleCommand
	{
		
		public function RemoveMenuListCommand() 
		{
			
			
		}
		/* public function */
		
		/* override function */
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			
			var node:MenuNode = notification.getBody() as MenuNode;
			removeMenuList(node);
		}
		/* private function */
		
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
		 * 移除该node下面的所有list
		 * @param	node
		 */
		private function removeMenuList(node:MenuNode):void
		{
			var parentMediator:MenuListMediator = getListMediatorByNode(node.parent as MenuNode);
			(parentMediator.getViewComponent() as UIMenuList).removeSonList();
		}
	}
	
}