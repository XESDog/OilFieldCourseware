package com.xesDog.oilField.mediator 
{
	
	import com.xesDog.oilField.ui.UIVideoControlBar;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	...
	 * @author  	Mr.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012/11/28 17:00
	 */
	public class VideoControlBarMediator extends Mediator
	{
		public static const NAME:String = "video_control_bar_mediator";
		public function VideoControlBarMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
			//TODO:控制条的定位
			viewComponent.percentX = .5;
			viewComponent.percentY = 1;
			viewComponent.offsetY = -200;
			viewComponent.onResize = function(e:Event=null ):void {
				
			}
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
			UIVideoControlBar(viewComponent).playBtn.addEventListener(MouseEvent.MOUSE_DOWN, onPlayDown);
			UIVideoControlBar(viewComponent).progressSlider.addEventListener(Event.CHANGE, onSliderChanged);
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			UIVideoControlBar(viewComponent).playBtn.removeEventListener(MouseEvent.MOUSE_DOWN, onPlayDown);
			UIVideoControlBar(viewComponent).progressSlider.removeEventListener(Event.CHANGE, onSliderChanged);
		}
		override public function listNotificationInterests():Array 
		{
			return super.listNotificationInterests();
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
		}
		
		/* private function */
		private function onPlayDown(e:MouseEvent):void 
		{
			
		}
		private function onSliderChanged(e:Event):void 
		{
			
		}
	}
	
}