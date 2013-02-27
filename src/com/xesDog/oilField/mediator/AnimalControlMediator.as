package com.xesDog.oilField.mediator 
{
	
	import com.greensock.TweenLite;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import de.polygonal.ds.DLL;
	import de.polygonal.ds.DLLNode;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @描述		swf控制
	 * @作者		Mr.zheng
	 * @webSite	@彪客
	 * @创建日期	2013/2/27 10:15
	 */
	public class AnimalControlMediator extends Mediator
	{
		public static const NAME:String = "animalControl_mediator";
		
		private var _leftBtn:MovieClip;
		private var _rightBtn:MovieClip;
		private var _dll:DLL;
		private var _node:DLLNode;
		
		public function AnimalControlMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
		}
		override public function onRegister():void 
		{
			super.onRegister();
			_leftBtn = viewComponent.leftBtn_mc;
			_rightBtn = viewComponent.rightBtn_mc;
			
			_leftBtn.addEventListener(MouseEvent.CLICK, onLeftClick);
			_rightBtn.addEventListener(MouseEvent.CLICK, onRightClick);
		}
		override public function onRemove():void 
		{
			super.onRemove();
			
			_leftBtn.removeEventListener(MouseEvent.CLICK, onLeftClick);
			_rightBtn.removeEventListener(MouseEvent.CLICK, onRightClick);
			_leftBtn =null;
			_rightBtn = null;
		}
		
		override public function listNotificationInterests():Array 
		{
			return [EventConst.SHOW_ANIMAL_CONTROL,EventConst.HIDE_ANIMAL_CONTROL,EventConst.OPERATE_MENU_PRESS];
		}
		override public function handleNotification(notification:INotification):void 
		{
			var type:String = notification.getName();
			var body:Object = notification.getBody();
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			
			switch (type) 
			{
				case EventConst.SHOW_ANIMAL_CONTROL:
					_dll = menuProxy.getLeafNodesBy(body as MenuNode);
					if (_dll.size() <= 1) {
						return;
					}
					_leftBtn.visible = true;
					_rightBtn.visible = true;
					_leftBtn.alpha = 0;
					_rightBtn.alpha = 0;
					TweenLite.to(_leftBtn, .5, { alpha:1} );
					TweenLite.to(_rightBtn, .5, { alpha:1} );
					
				break;
				case EventConst.HIDE_ANIMAL_CONTROL:
					_dll = null;
					//_leftBtn.visible = false;
					//_rightBtn.visible = false;
					
					TweenLite.to(_leftBtn, .5, { alpha:0, onComplete:function():void { _leftBtn.visible = false; }} );
					TweenLite.to(_rightBtn, .5, { alpha:0, onComplete:function():void { _rightBtn.visible = false; }} );
				break;
				case EventConst.OPERATE_MENU_PRESS:
					_node = getDllNodeBy(body as MenuNode);
				break;
				default:
			}
		}
		private function onRightClick(e:MouseEvent):void 
		{
			if(_node.next){
				_node = _node.next;
				sendNotification(EventConst.OPERATE_MENU_PRESS, _node.val);	
			}
				
		}
		
		private function onLeftClick(e:MouseEvent):void 
		{
			if(_node.prev){
				_node = _node.prev;
				sendNotification(EventConst.OPERATE_MENU_PRESS, _node.val);	
			}
		}
		/**
		 * 获取dll中val值为menuNode的dllNode
		 * @param	MenuNode
		 * @return
		 */
		private function getDllNodeBy(menuNode:MenuNode):DLLNode {
			if (_dll == null) return null;
			var isContain:Boolean = _dll.contains(menuNode);
			if (isContain) {
				_node = _dll.nodeOf(menuNode);
				return _node;
			}else {
				trace("dll中没有当前menuNode!");
				return null;
			}
		}
	}

}