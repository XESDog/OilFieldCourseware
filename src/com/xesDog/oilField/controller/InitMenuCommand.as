package com.xesDog.oilField.controller 
{
	
	import com.xesDog.oilField.manager.XmlManager;
	import com.xesDog.oilField.mediator.MenuItemMediator;
	import com.xesDog.oilField.mediator.MenuListMediator;
	import com.xesDog.oilField.mediator.AppMediator;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xesDog.oilField.ui.UIMenu;
	import com.xesDog.oilField.ui.UIMenuList;
	import flash.display.Sprite;
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
			var node:MenuNode = XmlManager.instance.menuNode;//所有菜单根节点
			var uiMenuList:UIMenuList = new UIMenuList();//主菜单list
			var uiMenu:UIMenu = new UIMenu();//主菜单
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			var mainMenuNode:MenuNode = node.getFirstChild() as MenuNode;
			menuProxy.currentNode = node;
			uiMenu.setMenuName(node.getFirstChild().val.name);
			facade.registerMediator(new MenuListMediator(node, MenuListMediator.NAME + node.key, uiMenuList));
			facade.registerMediator(new MenuItemMediator(mainMenuNode, MenuItemMediator.NAME + node.key, uiMenu));
			uiMenuList.addMenu(uiMenu);
			
			var appRoot:Sprite = facade.retrieveMediator(AppMediator.NAME).getViewComponent() as Sprite;
			initMenuByNode(node, 0, uiMenuList);
			appRoot.addChild(uiMenuList);
			uiMenuList.x = XmlManager.MAIN_MENU_X;
			uiMenuList.y = XmlManager.MAIN_MENU_Y;
		}
		/**
		 * 根据node初始化菜单
		 * @param	node
		 * @param	container	
		 */
		private function initMenuByNode(node:MenuNode,count:int=0,container:UIMenuList=null):void {
			if (node.numChildren() <= 0) return;
			var uiMenuList:UIMenuList = new UIMenuList();
			var uiMenu:UIMenu;
			var num:int = 0;//list编号
			facade.registerMediator(new MenuListMediator(node, MenuListMediator.NAME + node.key, uiMenuList));
			/*if (container) {
				container.addSonList(uiMenuList);
				uiMenuList.x = count * 10;
				uiMenuList.y = count * 10;
			}*/
			node = node.getFirstChild() as MenuNode;
			while (node) 
			{
				uiMenu = new UIMenu();
				uiMenuList.addMenu(uiMenu);
				uiMenu.setMenuName(node.val.name);
				facade.registerMediator(new MenuItemMediator(node, MenuItemMediator.NAME + node.key, uiMenu));
				initMenuByNode(node,num,uiMenuList);
				node = node.next as MenuNode;
				num++;
			}	
		}
	}
	
}