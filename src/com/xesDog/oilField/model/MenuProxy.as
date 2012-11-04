package com.xesDog.oilField.model 
{
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 13:13
	 */
	public class MenuProxy extends Proxy
	{
		/**
		 * 最后一次点击的按钮对应的node
		 */
		public var currentNode:MenuNode;
		
		public static const NAME:String = "menu_proxy";
		public function MenuProxy(proxyName:String=null, data:Object=null) 
		{
			super(proxyName, data);
		}
		/* public function */
		/**
		 * 该节点是主菜单
		 * @param	node
		 * @return
		 */
		public function isMainMenu(node:MenuNode):Boolean {
			return MenuNode(data).getFirstChild() == node;
		}
		/* override function */
		
		/* private function */
	}
	
}