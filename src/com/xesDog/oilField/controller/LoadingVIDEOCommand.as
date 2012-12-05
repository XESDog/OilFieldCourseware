package com.xesDog.oilField.controller 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.VideoLoader;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.mediator.MediaContainerMediator;
	import com.xesDog.oilField.model.LoaderProxy;
	import com.xesDog.oilField.model.MenuNode;
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
		/* public function */
		
		/* override function */
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			var node:MenuNode = notification.getBody() as MenuNode;
			var mediaContainer:Sprite = facade.retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as Sprite;
			var videoLoader:VideoLoader = new VideoLoader(node.val.url, { 
				estimatedBytes:size,
				bufferTime:10, 
				container:mediaContainer,
				autoPlay:false,
				scaleMode:"proportionalInside",
				width:mediaContainer.stage.stageWidth,
				height:mediaContainer.stage.stageHeight,
				volume:0, 
				onInit:function() {
					sendNotification(EventConst.SYS_INIT_VIDEO);
				},
				onProgress:progressHandler,
				onComplete:completeHandler,
				onError:errorHandler
			});
			var loaderProxy:LoaderProxy = facade.retrieveProxy(LoaderProxy.NAME) as LoaderProxy;
			var size:int = node.val.size;
			
			videoLoader.load();
			
			loaderProxy.currentLoader = videoLoader;
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
			sendNotification(EventConst.SYS_LOADED);
		}
		
		private function progressHandler(e:LoaderEvent):void 
		{
			//trace("progress: " + e.target.progress);
			
			trace("e.target.bufferProgress:"+e.target.bufferProgress);
			trace("e.target.playProgress:"+e.target.playProgress);
			
			sendNotification(EventConst.SYS_PROGRESS,e.target.progress);
		}
	}
	
}