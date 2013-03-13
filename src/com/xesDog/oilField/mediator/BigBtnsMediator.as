package com.xesDog.oilField.mediator 
{
	
	import com.greensock.TweenLite;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import de.polygonal.ds.TreeNode;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  场景中间大按钮的控制
	 * @author  	Mr.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012/12/5 17:05
	 */
	public class BigBtnsMediator extends Mediator
	{
		public static const NAME:String = "bigBtns_mediator";
		
		private var _theoryMc:MovieClip;//理论
		private var _faultMc:MovieClip;//错误
		private var _operateMc:MovieClip;//操作
		
		public function BigBtnsMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
			
			viewComponent.mouseEnabled = false;
			_theoryMc = viewComponent.theory_mc;
			_faultMc = viewComponent.fault_mc;
			_operateMc = viewComponent.operate_mc;
			_theoryMc.buttonMode = _faultMc.buttonMode = _operateMc.buttonMode = true;
			
			_theoryMc.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			_theoryMc.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			_theoryMc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			_faultMc.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			_faultMc.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			_faultMc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			_operateMc.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			_operateMc.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			_operateMc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		override public function onRemove():void 
		{
			super.onRemove();
		}
		override public function listNotificationInterests():Array 
		{
			return [];
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			switch (notification.getName()) 
			{
				case "":
					
				break;
				default:
			}
		}
		/* private function */
		private  function onRollOver(e:MouseEvent):void {
			var mc:MovieClip = e.target as MovieClip;
			TweenLite.to(mc,.5, { scaleX:1.2,scaleY:1.2} );
		}
		private function onRollOut(e:MouseEvent):void {
			var mc:MovieClip = e.target as MovieClip;
			TweenLite.to(mc, .5,{ scaleX:1,scaleY:1} );
		}
		private function onMouseDown(e:MouseEvent):void {
			var mc:MovieClip = e.target as MovieClip;
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			var node:MenuNode;
			
			switch (mc) 
			{
				case _theoryMc:
					/*node = menuProxy.getTheoryNode();
					node = menuProxy.getFirstNode(node);
					sendNotification(EventConst.OPERATE_MENU_PRESS,node );*/
					viewComponent.gotoAndStop(2);
					for (var i:int = 0; i < 4; i++) 
					{
						MovieClip(viewComponent["pump_" + i]).addEventListener(MouseEvent.MOUSE_DOWN, onBengDown);
						MovieClip(viewComponent["pump_" + i]).num = i;
					}
				break;
				case _faultMc:
					node = menuProxy.hetFaultNode();
					node = menuProxy.getFirstNode(node);
					sendNotification(EventConst.OPERATE_MENU_PRESS,node );
				break;
				case _operateMc:
					node = menuProxy.getOperateNode();
					node = menuProxy.getFirstNode(node);
					sendNotification(EventConst.OPERATE_MENU_PRESS,node );
				break;
				default:
			}
		}
		
		private function onBengDown(e:MouseEvent):void 
		{
			var node:TreeNode;
			var num:uint = MovieClip(e.currentTarget).num;
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			var i:uint = 0;
			node = menuProxy.getTheoryNode();
			node = node.getFirstChild();
			while (node) 
			{
				if (i == num) {
					break;
				}
				node=node.next;
				i++;
			}
			node = menuProxy.getFirstNode(node as MenuNode);
			sendNotification(EventConst.OPERATE_MENU_PRESS,node );
		}
	}
	
}