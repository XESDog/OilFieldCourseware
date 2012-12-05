package com.xesDog.oilField.mediator 
{
	
	import com.bit101.components.PushButton;
	import com.greensock.loading.VideoLoader;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.LoaderProxy;
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
		private var _loaderProxy:LoaderProxy;
		private var _videoLoader:VideoLoader;
		public static const NAME:String = "video_control_bar_mediator";
		public function VideoControlBarMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
			_loaderProxy = facade.retrieveProxy(LoaderProxy.NAME) as LoaderProxy;
			//TODO:控制条的定位
			viewComponent.percentX = .2;
			viewComponent.percentY = 1;
			viewComponent.offsetY = -200;
			viewComponent.visible = false;
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
			return [EventConst.SYS_LOAD_VIDEO,EventConst.SYS_LOAD_SWF,EventConst.SYS_COLOR,EventConst.SYS_INIT_VIDEO];
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			switch (notification.getName()) 
			{
				case EventConst.SYS_LOAD_VIDEO:
					viewComponent.visible = true;
					_videoLoader = _loaderProxy.currentLoader as VideoLoader;
					UIVideoControlBar(viewComponent).playBtn.enabled = false;
					UIVideoControlBar(viewComponent).progressSlider.enabled = false;
					
				break;
				case EventConst.SYS_INIT_VIDEO:
					UIVideoControlBar(viewComponent).maximum = _videoLoader.duration;
					UIVideoControlBar(viewComponent).playBtn.enabled = true;
					UIVideoControlBar(viewComponent).progressSlider.enabled = true;
				break;
				default:
					viewComponent.visible = false;
			}
		}
		
		/* private function */
		private function onPlayDown(e:MouseEvent):void 
		{
			//var videoLoader:VideoLoader = _loaderProxy.currentLoader;
			//videoLoader.videoPaused = !videoLoader.videoPaused;
			//TODO:修改按钮显示
			var btn:PushButton = e.target as PushButton;
			if (btn.selected) {//点击暂停，这里特别注意，初始化为selected=true
				btn.label = "play";
				_videoLoader.pauseVideo();
			}else {//点击播放
				btn.label = "pause";
				_videoLoader.playVideo();
			}
			trace("当前time:" + _videoLoader.videoTime,"总时间："+_videoLoader.duration);
		}
		private function onSliderChanged(e:Event):void 
		{
			_videoLoader.gotoVideoTime(e.target.value);
			trace("slider value:"+e.target.value);
		}
	}
	
}