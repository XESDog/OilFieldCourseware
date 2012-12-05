package com.xesDog.oilField.controller 
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
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
	 * @describe  	图片加载
	 * @author  	Mr.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012/11/29 14:49
	 */
	public class LoadingIMAGECommand extends SimpleCommand
	{
		
		public function LoadingIMAGECommand() 
		{
			super();
			
			
		}
		/* public function */
		
		/* override function */
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			var node:MenuNode = notification.getBody() as MenuNode;
			var imageContainer:Sprite = facade.retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as Sprite;
			var imageLoader:ImageLoader = new ImageLoader( node.val.url, {
				estimatedBytes:size, 
				container:imageContainer, 
				autoPlay:true,
				scaleMode:"proportionalInside",
				width:imageContainer.stage.stageWidth,
				height:imageContainer.stage.stageHeight,
				onComplete :completeHandler,
				onError :errorHandler,
				onProgress :progressHandler 
				} );
			var size:int = node.val.size;
			var loaderProxy:LoaderProxy = facade.retrieveProxy(LoaderProxy.NAME) as LoaderProxy;
			
			imageLoader.load();
			loaderProxy.currentLoader = imageLoader;
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
			var image:DisplayObject = e.target.content;
			image.alpha = 0;
			//swf.scaleX = swf.scaleY = .8;
			TweenLite.to(image, .5, { alpha:1,scaleX:1,scaleY:1 } );
			sendNotification(EventConst.SYS_LOADED);
		}
		
		private function progressHandler(e:LoaderEvent):void 
		{
			trace("progress: " + e.target.progress);
			sendNotification(EventConst.SYS_PROGRESS,e.target.progress);
		}
	}
	
}