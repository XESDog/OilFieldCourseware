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
		 * 当前鼠标移上的node
		 */
		public var currentRollOverNode:MenuNode;
		/**
		 * 当前点击的node
		 */
		public var currentPressNode:MenuNode;
		
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
			//return MenuNode(data).getFirstChild() == node;
			return node.depth()<=2;
		}
		/**
		 * 在父级中是第几个孩子
		 * @param	node
		 * @return
		 */
		public function numInParent(node:MenuNode):int {
			if (node.parent == null) throw new Error("没有父节点");
			var tempNode:MenuNode = node.parent.getFirstChild() as MenuNode;
			var num:int=0;
			while (tempNode) 
			{
				if (tempNode == node) {
					return num;
				}
				num++;
				tempNode = tempNode.next as MenuNode;
			}
			
			return -1;
		}
		/* override function */
		
		/* private function */
	}
	
}