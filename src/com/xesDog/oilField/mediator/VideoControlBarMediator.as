package com.xesDog.oilField.mediator 
{
	
	import com.bit101.components.PushButton;
	import com.greensock.loading.VideoLoader;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.manager.ResizeManager;
	import com.xesDog.oilField.model.LoaderProxy;
	import com.xesDog.oilField.ui.UIVideoControlBar;
	import flash.display.MovieClip;
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
			viewComponent.visible = false;
			viewComponent.percentX = .5;
			viewComponent.percentY = 1;
			viewComponent.offsetX = -270;
			viewComponent.offsetY = -40-viewComponent.height;
			ResizeManager.instance.addResizeObj(viewComponent as MovieClip);
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
					addEvent();
					
				break;
				default:
					viewComponent.visible = false;
					removeEvent();
					setPlayBtnPlay();
					_videoLoader.videoTime = 0;
			}
		}
		
		private function onVideoComplete(e:Event):void 
		{
			setPlayBtnPlay();
			_videoLoader.videoTime = 0;
		}
		
		/* private function */
		private function onPlayDown(e:MouseEvent=null):void 
		{
			//var videoLoader:VideoLoader = _loaderProxy.currentLoader;
			//videoLoader.videoPaused = !videoLoader.videoPaused;
			//TODO:修改按钮显示
			var btn:VideoPlay = UIVideoControlBar(viewComponent).playBtn;
			if (btn.currentFrame == 2) {
				btn.gotoAndStop(1);
				_videoLoader.pauseVideo();
			}else {//点击播放
				_videoLoader.playVideo();
				btn.gotoAndStop(2);
			}
			trace("当前time:" + _videoLoader.videoTime,"总时间："+_videoLoader.duration);
		}
		private function setPlayBtnPlay():void {
			UIVideoControlBar(viewComponent).playBtn.gotoAndStop(1);
		}
		private function setPlayBtnPause():void {
			UIVideoControlBar(viewComponent).playBtn.gotoAndStop(2);
		}
		private function onSliderChanged(e:Event):void 
		{
			_videoLoader.gotoVideoTime(e.target.value);
			trace("slider value:"+e.target.value);
		}
		private function addEvent():void {
			viewComponent.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_videoLoader.addEventListener(VideoLoader.VIDEO_COMPLETE, onVideoComplete);
			_videoLoader.content.addEventListener(MouseEvent.MOUSE_DOWN, onPlayDown);
		}
		private function removeEvent():void {
			viewComponent.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			if (_videoLoader)_videoLoader.removeEventListener(VideoLoader.VIDEO_COMPLETE, onVideoComplete);
			if (_videoLoader)_videoLoader.content.removeEventListener(MouseEvent.MOUSE_DOWN, onPlayDown);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			UIVideoControlBar(viewComponent).progressSlider.value = _videoLoader.videoTime;
		}
	}
	
}