package com.xesDog.oilField.controller 
{
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @describe  	鼠标按下时
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 16:32
	 */
	public class MenuPressCommand extends SimpleCommand
	{
		public function MenuPressCommand() 
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
			var currentPressNode:MenuNode = menuProxy.currentPressNode;
			//当前页已经显示
			if (currentPressNode == node) {
				return ;
			}
			if (node.isLeaf()){
				//播放flash，或者视频
				if (parseUrlExpandedName(node.val.url) == "swf") {
					sendNotification(EventConst.SYS_LOAD_SWF, node);
				}else {
					sendNotification(EventConst.SYS_LOAD_VIDEO, node);
				}
				menuProxy.currentPressNode = node;
			}
			//主菜单被点击
			if (menuProxy.isMainMenu(node)) {
				sendNotification(EventConst.OPERATER_SHOWANDHIDE_MENU, node);
			}
		}
		/* private function */
		/**
		 * 获取url的扩展名
		 * @param	url
		 * @return
		 */
		private function parseUrlExpandedName(url:String):String {
			var expendName:String = "";
			var index:int = url.lastIndexOf(".");
			expendName = url.slice(index + 1);
			return expendName;
		}
	}
	
}