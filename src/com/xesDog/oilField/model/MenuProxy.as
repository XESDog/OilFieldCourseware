package com.xesDog.oilField.model 
{
	
<<<<<<< HEAD
	import com.xueersi.corelibs.utils.ParseUrl;
	
	import de.polygonal.ds.DLL;
	import de.polygonal.ds.DLLNode;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
=======
	import de.polygonal.ds.DLL;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
>>>>>>> 增加videolist控制
	
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
		
		//nodeDll(MenuNode,MenuNode....)
		private var _nodeDll:DLL=new DLL();
		private var _videoDll:DLL=new DLL();
		
		public static const NAME:String = "menu_proxy";
		public function MenuProxy(proxyName:String=null, data:Object=null) 
		{
			super(proxyName, data);
		}
		/* public function */

		public function get nodeList():DLL
		{
			return _nodeDll;
		}

		public function get videoList():DLL
		{
			return _videoDll;
		}
		/**
		 * 从dll中找出上一个menuNode 
		 * @param menuNode
		 * @param dll
		 * @return 
		 * 
		 */
		public function getPreMenuNode(menuNode:MenuNode,dll:DLL):MenuNode{
			var dllNode:DLLNode=dll.nodeOf(menuNode);
			return dllNode.prev?dllNode.prev.val as MenuNode:null;
		}
		/**
		 * 找出动力两种下一个menuNode 
		 * @param menuNode
		 * @param dll
		 * @return 
		 * 
		 */
		public function getNextMenuNode(menuNode:MenuNode,dll:DLL):MenuNode{
			var dllNode:DLLNode=dll.nodeOf(menuNode);
			return dllNode.next?dllNode.next.val as MenuNode:null;
		}
		/**
		 * 整理数据 
		 * 没有整理之前_nodeList _videoList都为null
		 */		
		public function tidyData():void{
			MenuNode(data).postorder(visitNode,true);
		}
		/**
		 * 该节点是主菜单
		 * @param	node
		 * @return
		 */
		public function isMainMenu(node:MenuNode):Boolean {
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
		/**
		 * 根据node获取该node下所有叶节点，并将他们存储成dll 
		 * @param node
		 * @return 
		 * 
		 */		
		public function getLeafNodesBy(node:MenuNode):DLL{
			var dll:DLL=new DLL();
			node.preorder(process,false,false,dll);
			return dll;
		}
		/* override function */
		
		/* private function */
<<<<<<< HEAD
		/**
		 * 遍历树，找出所有叶节点，所有视频节点 
		 * @param node
		 * @param userData
		 * @return 
		 * 
		 */		
		private function visitNode(node:MenuNode,userData:Object):Boolean{
			if(node.isLeaf()){
				_nodeDll.append(node);
				if((ParseUrl.parseUrlExpandedName(node.val.url)=="flv"||
					ParseUrl.parseUrlExpandedName(node.val.url)=="mp4")){
					_videoDll.append(node);
				}
=======
		private function process(node:MenuNode,preflight:Boolean,dll:DLL):Boolean{
			if(node.isLeaf()){
				dll.append(node.val);
>>>>>>> 增加videolist控制
			}
			return true;
		}
	}
	
}