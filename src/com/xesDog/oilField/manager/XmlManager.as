package com.xesDog.oilField.manager 
{
	import com.xesDog.oilField.ApplicationFacad;
	import com.xesDog.oilField.model.ConfigProxy;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuNodeVo;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * 
	 * 单例模式类
	 * @describe		管理xml
	 * @author			zihua.zheng
	 * @time 			2012-10-27 16:14
	 */
	public class XmlManager
	{
		private static var _instance:XmlManager = null;
		public function XmlManager(single:Single){
			
			if(single == null)
			{
				throw new Error("Can't create instance , Single is Null!");
			}
		}
		/**
		 * 单例引用
		 */
		public static function get instance():XmlManager
		{
			if(_instance == null)
			{
				_instance = new XmlManager(new Single());
			}
			return _instance;
		}
		
		public function get dispatcher():EventDispatcher 
		{
			return _dispatcher;
		}
		
		public function get menuNode():MenuNode 
		{
			return _menuNode;
		}
		
		//start-----------------------------------------------------------------------------
		
		private var _urlLoader:URLLoader;
		private var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _menuNode:MenuNode;
		public static const MENU_XML_URL:String = "../assets/xml/menu.xml";
		public static const CONFIG_URL:String = "../assets/xml/config.xml";
		static public const MENU_XML_PARSED:String = "menu_Xml_Parsed";
		
		/* public function */
		/**
		 * 读取menuXml文件
		 * @param	url
		 */
		public function loadMenuXml(url:String):void {
			_urlLoader = new URLLoader(new URLRequest(url));
			_urlLoader.addEventListener(Event.COMPLETE, onMenuXmlLoaded);
		}
		/* private function */
		private function onMenuXmlLoaded(e:Event):void 
		{
			parseMenuXml(new XML(_urlLoader.data));
			
			_urlLoader = new URLLoader(new URLRequest(CONFIG_URL));
			_urlLoader.addEventListener(Event.COMPLETE,onConfigXmlLoaded);
		}
		
		private function onConfigXmlLoaded(e:Event):void 
		{
			var configProxy:ConfigProxy = ApplicationFacad.instance.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			var xml:XML = new XML(_urlLoader.data);
			configProxy.homePage = xml.homePage;
			configProxy.menuSpace = xml.menuSpace;
			_dispatcher.dispatchEvent(new Event(MENU_XML_PARSED));
			
		}
		/**
		 * 解析menu文件
		 * @return
		 */
		private function parseMenuXml(xml:XML):void {
			//菜单根节点
			_menuNode = new MenuNode();
			
			//主菜单
			var mainMenu:MenuNode = new MenuNode();
			_menuNode.appendNode(mainMenu);
			menuXmlIteration(mainMenu,xml);
		}
		/**
		 * 迭代取值
		 * @param	node
		 * @param	xml
		 * @param	isRoot
		 */
		private function menuXmlIteration(node:MenuNode,xml:XML):void {
			var nodeVo:MenuNodeVo;
			var xmlList:XMLList;
			var len:int;
			var sonNode:MenuNode;
			
			nodeVo= new MenuNodeVo();
			nodeVo.name = xml.@name;
			nodeVo.url = xml.@url;
			nodeVo.imgUrl = xml.@imgUrl;
			
			var size:int = xml.@size;
			if (size) nodeVo.size = size;
			
			node.val = nodeVo;
			
			//设定子的值
			xmlList = xml.children();
			len = xmlList.length();
			for (var i:int = 0; i < len; i++) 
			{
				xml = xmlList[i];
				sonNode = new MenuNode();
				node.appendNode(sonNode);
				menuXmlIteration(sonNode, xml);
			}
			
		}
	}
}
class Single{}