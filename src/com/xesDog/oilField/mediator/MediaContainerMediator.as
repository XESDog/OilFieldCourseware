package com.xesDog.oilField.mediator
{
	
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.display.ContentDisplay;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.LoaderProxy;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import fl.video.FLVPlayback;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	/**
	 * @describe  	媒体容器
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 17:20
	 */
	public class MediaContainerMediator extends Mediator
	{
		private var _video:FLVPlayback=new FLVPlayback();
		static public const NAME:String = "mediaContainer_mediator";
		
		public function MediaContainerMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
		
		}
		
		/* public function */
		
		/* override function */

		public function get video():FLVPlayback
		{
			return _video;
		}

		override public function onRegister():void
		{
			trace("onRegister");
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		override public function listNotificationInterests():Array
		{
			return [Event.RESIZE,EventConst.SYS_INIT_VIDEO];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			super.handleNotification(notification);
			switch (notification.getName())
			{
				case Event.RESIZE: 
					onResize();
					break;
				case EventConst.SYS_INIT_VIDEO:
					viewComponent.addChild(video);
					setVideoPos();
					break;
				default: 
			}
		}
		
		/* private function */ /**
		 * 舞台变化
		 */
		private function onResize():void
		{
			if(Sprite(viewComponent).numChildren>0){
				var loaderProxy:LoaderProxy = facade.retrieveProxy(LoaderProxy.NAME) as LoaderProxy;
				//swf,video,etc.
				if (loaderProxy.currentLoader)
				{
					//video
					if(loaderProxy.currentLoader is VideoLoader){
						setVideoPos();
						setVideoScale();
					}else{
						var contentDisplay:ContentDisplay = loaderProxy.currentLoader.content;
						contentDisplay.fitWidth = viewComponent.stage.stageWidth;
						contentDisplay.fitHeight = viewComponent.stage.stageHeight;
					}
					
				}
				//colcor
				else
				{
					var sp:Sprite = viewComponent.getChildAt(0) as Sprite;
					sp.width = viewComponent.stage.stageWidth;
					sp.height = viewComponent.stage.stageHeight;
				}
			}else {
				//没有显示对象，不做处理
			}
		}
		
		private function setVideoScale():void 
		{
			var w:uint = viewComponent.stage.stageWidth - 480;
			var scale:Number = w / 1080;
			if (scale<=0||scale>=2)return;
			_video.width = 1080 * scale;
			_video.height = 600 * scale;
		}
		
		public function setVideoUrl(url:String):void{
			_video.source = url;
			_video.skin = "MinimaFlatCustomColorAll.swf";
			
			setVideoScale();
		}
		public function unLoadVideo():void{
			_video.stop();
		}
		public function setVideoPos():void{
			//_video.x=viewComponent.stage.stageWidth-_video.width>>1;
			_video.x = 160;
			_video.y=viewComponent.stage.stageHeight-_video.height-40>>1;
		}
	}

}