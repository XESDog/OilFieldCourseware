package com.xesDog.oilField.mediator
{
	import com.greensock.TweenLite;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import de.polygonal.ds.DLL;
	import de.polygonal.ds.DLLNode;
	import fl.controls.TileList;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	import flash.text.TextField;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	
	/**
	 * 视频列表管理 
	 * @author xiaxien
	 * 
	 */
	public class VideoListMediator extends Mediator
	{
		private var _tile:TileList;
		private var _dp:DataProvider;
		private var _title:TextField;
		
		public static const NAME:String="videolist_mediator";
		public function VideoListMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);

		}
		override public function onRegister():void {
			
			_tile = viewComponent.tile;
			_dp = new DataProvider();
			
			_title = viewComponent.title;
			
			//_tile.setStyle('cellRenderer', CellRenderer); 
			_tile.addEventListener(ListEvent.ITEM_CLICK, onItemClick);
			
			
		}
		override public function onRemove():void{
			
			viewComponent.container_mc.removeChild(_tile);
			_tile = null;
			_dp = null;
			_title = null;
			
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
					
					var dll:DLL = menuProxy.getLeafNodesBy(menuNode) as DLL;
					if (dll.size() <= 1) {
						return;
					}else {
						_title.text = menuNode.val.name;
						viewComponent.visible = true;
						viewComponent.alpha = 0;
						TweenLite.to(viewComponent, .5, { alpha:1 } );
						addItemsBy(dll);
						_tile.dataProvider = _dp;
					}
				break;
			case EventConst.CLEAR_VIDEO_LIST:
					_dp=new DataProvider();
					_tile.dataProvider = new DataProvider();
					TweenLite.to(viewComponent, .5, { alpha:0, onComplete:function():void {
						viewComponent.visible = false;
					} });
				break;
				default:
			}
		}

		
		/* private function */
		private function addItemsBy(dll:DLL):void {
			if (dll) {
				var node:DLLNode = dll.head;
				while (node) 
				{
					addItem(node.val as MenuNode);
					node = node.next;
				}
			}else {
				return ;
			}
		}
		private function addItem(menuNode:MenuNode):void {
			_dp.addItem({label:menuNode.val.name,source:menuNode.val.imgUrl,data:menuNode});
		}
		private function removeItem():void {
			
		}
		private function clearAll():void {
			
		}
		
		private function onItemClick(e:ListEvent):void 
		{
			sendNotification(EventConst.OPERATE_MENU_PRESS, e.item.data);
		}

	}
}