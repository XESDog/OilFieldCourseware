package com.xesDog.oilField.controller 
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.VideoLoader;
	import com.greensock.TweenLite;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.mediator.MediaContainerMediator;
	import com.xesDog.oilField.model.LoaderProxy;
	import com.xesDog.oilField.model.MenuNode;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @describe  	读取视频
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 19:43
	 */
	public class LoadingVIDEOCommand extends SimpleCommand
	{
		private var _mediaName:String;
		public function LoadingVIDEOCommand() 
		{
			super();
		}
		/* public function */
		
		/* override function */
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			var queue:LoaderMax = new LoaderMax( { name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler } );
			var node:MenuNode = notification.getBody() as MenuNode;
			var loaderProxy:LoaderProxy = facade.retrieveProxy(LoaderProxy.NAME) as LoaderProxy;
			var size:int = node.val.size;
			
			loaderProxy.unLoad();
			
			_mediaName = "video" + node.key;
			
			var mediaContainer:Sprite = facade.retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as Sprite;
			queue.append(new VideoLoader(node.val.url, { name:_mediaName,width:mediaContainer.stage.stageWidth,height:mediaContainer.stage.stageHeight, estimatedBytes:size, container:mediaContainer, autoPlay:false,scaleMode:"proportionalInside",volume:0} ));
			queue.load();
			
			loaderProxy.currentLoader = queue;
		}
		/* private function */
		private function errorHandler(e:LoaderEvent):void 
		{
			trace("error occured with " + e.target + ": " + e.text);
			sendNotification(EventConst.SYS_ERROR);
		}
		
		private function completeHandler(e:LoaderEvent):void 
		{
			trace(e.target + " is complete!");
			var videoContainer:ContentDisplay = LoaderMax.getContent(_mediaName) as ContentDisplay;
			var video:VideoLoader = videoContainer.loader as VideoLoader;
			video.playVideo();
			videoContainer.alpha = 0;
			TweenLite.to(video, 2, {volume:1} );
			TweenLite.to(videoContainer, .5, {alpha:1} );
			sendNotification(EventConst.SYS_LOADED);
		}
		
		private function progressHandler(e:LoaderEvent):void 
		{
			trace("progress: " + e.target.progress);
			sendNotification(EventConst.SYS_PROGRESS,e.target.progress);
		}
	}
	
}