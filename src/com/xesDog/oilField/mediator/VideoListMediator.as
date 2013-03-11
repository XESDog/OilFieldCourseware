package com.xesDog.oilField.mediator
{
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import de.polygonal.ds.DLL;
	import de.polygonal.ds.DLLNode;
	
	import fl.containers.ScrollPane;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	
	/**
	 * 视频列表管理 
	 * @author xiaxien
	 * 
	 */
	public class VideoListMediator extends Mediator
	{
		private var _scrollPane:ScrollPane;
		/**
		 * 当前显示的node
		 */
		private var _currNode:MenuNode;
		
		//private var _dp:DataProvider;
		//private var _title:TextField;
		
		public static const NAME:String="videolist_mediator";
		public function VideoListMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);

		}
		override public function onRegister():void {
			
			_scrollPane = viewComponent.scrollPane;
			
			
		}
		override public function onRemove():void{
			
			//_dp = null;
			
		}
		override public function listNotificationInterests():Array{
			
			return [EventConst.ASSIGN_VIDEO_LIST,EventConst.CLEAR_VIDEO_LIST];
		}
		override public function handleNotification(notification:INotification):void{
			var type:String = notification.getName();
			var body:*= notification.getBody();
			var menuNode:MenuNode;
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			switch (type) 
			{
				case EventConst.ASSIGN_VIDEO_LIST:
					menuNode = body as MenuNode;
					//menuNode是点击菜单的parent对象，如果menuNode没有videoDisplay属性，像父级查找
					while (menuNode) {
						if (menuNode.val.videoDisplay == "") {
							menuNode = menuNode.parent as MenuNode;
						}else {
							break;
						}
						
					}
					
					var dll:DLL = menuProxy.getLeafNodesBy(menuNode) as DLL;
					if (dll.size() <= 1) {
						return;
					}else {
						viewComponent.visible = true;
						
						
						if (_currNode == menuNode) {
							return;
						}
						
						_currNode = menuNode;
						//viewComponent.alpha = 0;
						//TweenLite.to(viewComponent, .5, { alpha:1 } );
						
						if(menuNode.val.videoDisplay=="icon"){
							addItemsBy(dll,IconTileItem);
						}
						if(menuNode.val.videoDisplay=="txt"){
							addItemsBy(dll, TxtTileItem);
						}
					}
				break;
			case EventConst.CLEAR_VIDEO_LIST:
					//TweenLite.to(viewComponent, .5, { alpha:0, onComplete:function():void {
						viewComponent.visible = false;
					//} });
				break;
				default:
			}
		}

		
		/* private function */
		
		private function addItemsBy(dll:DLL,className:Class):void {
			if (dll) {
				var node:DLLNode = dll.head;
				var tileItem:*;
				var sp:Sprite = new Sprite();
				var i:uint = 0;
				var loader:Loader;
				_scrollPane.source = sp;
				if (className == IconTileItem) {
					
					//同一个父对象的有分隔符区分
					var parentNode:MenuNode;
					var ball:Sprite;
					var span:uint=1;
					
					while (node) 
					{
						if (parentNode == null) {
							parentNode = node.val.parent as MenuNode;
							//创建分隔符
							ball = addTitle(parentNode);
							sp.addChild(ball);
							ball.x = 70;
							ball.y = _scrollPane.source.height;
						}else {
							if (parentNode == node.val.parent) {
								
							}
							//创建分隔符
							else {
								span++;
								parentNode = node.val.parent as MenuNode;
								ball = addTitle(parentNode);
								sp.addChild(ball);
								ball.x = 70;
								ball.y = _scrollPane.source.height;
							}
						}
						
						tileItem= new className();
						tileItem.txt.text = node.val.val.name;
						
						loader = new Loader();
						loader.load(new URLRequest(node.val.val.imgUrl));
						tileItem.container_mc.addChild(loader);
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
						function onComplete(e:Event):void {
							loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
							loader.width = tileItem.size_mc.width;
							loader.height = tileItem.size_mc.height;
						}
						sp.addChild(tileItem);
						tileItem.x = i % 2 * 140;
						tileItem.y = int(i / 2) * 107 + 10 + span * 50;
						
						tileItem.addEventListener(MouseEvent.MOUSE_DOWN, onItemClick);
						tileItem.node = node;
						
						i++;
						node = node.next;
					}
					
				}
				i = 0;
				if (className==TxtTileItem) {
					while (node) {
						tileItem = new className();
						tileItem.txt.text = node.val.val.name;
						sp.addChild(tileItem);
						tileItem.y = i * 60+ 10;
						
						tileItem.addEventListener(MouseEvent.MOUSE_DOWN, onItemClick);
						tileItem.node = node;
						i++
						node = node.next;
					}
				}
				_scrollPane.update();
			}else {
				return ;
			}
		}
		private function onItemClick(e:Event):void {
			var node:MenuNode = e.currentTarget.node.val as MenuNode;
			sendNotification(EventConst.OPERATE_MENU_PRESS,node);
		}
		private function removeItem():void {
			
		}
		private function clearAll():void {
			
		}
		
		private function addTitle(menuNode:MenuNode):Sprite {
			var titleMc:TitleMC = new TitleMC();
			titleMc.title.text = menuNode.val.name;
			return titleMc;
		}
	}
}