package com.xesDog.oilField.controller 
{
	
	import com.xesDog.oilField.manager.XmlManager;
	import com.xesDog.oilField.mediator.MenuItemMediator;
	import com.xesDog.oilField.mediator.MenuListMediator;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.ui.UIMenu;
	import com.xesDog.oilField.ui.UIMenuList;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @describe  	初始化菜单
	 * 注册MenuItemMediator、MenuListMediator
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 23:02
	 */
	public class InitMenuCommand extends SimpleCommand
	{
		
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			var node:MenuNode = XmlManager.instance.menuNode;
			var uiMenu:UIMenu = new UIMenu();
			uiMenu.setMenuName(node.val.name);
			facade.registerMediator(new MenuItemMediator(node, MenuItemMediator.NAME + node.key, uiMenu));
			
			initMenuByNode(node);
		}
		/**
		 * 根据node初始化菜单
		 * @param	node
		 */
		private function initMenuByNode(node:MenuNode):void {
			if (node.numChildren() <= 0) return;
			var uiMenuList:UIMenuList = new UIMenuList();
			var uiMenu:UIMenu;
			facade.registerMediator(new MenuListMediator(node, MenuListMediator.NAME + node.key, uiMenuList));
			
			node = node.getFirstChild() as MenuNode;
			while (node) 
			{
				uiMenu = new UIMenu();
				uiMenuList.addMenu(uiMenu);
				uiMenu.setMenuName(node.val.name);
				facade.registerMediator(new MenuItemMediator(node, MenuItemMediator.NAME + node.key, uiMenu));
				initMenuByNode(node);
				node = node.next as MenuNode;
			}
			
			//TODO:调试,显示菜单
			/*ApplicationFacad.instance.contextView.addChild(uiMenuList);
			uiMenuList.x = Math.random() * 700;
			uiMenuList.y = Math.random() * 500;*/
		}
	}
	
}