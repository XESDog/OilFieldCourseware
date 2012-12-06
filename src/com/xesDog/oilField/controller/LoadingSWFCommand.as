package com.xesDog.oilField.controller 
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
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
	 * @describe  	读取swf文件
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 19:42
	 */
	public class LoadingSWFCommand extends SimpleCommand
	{
		/* public function */
		
		/* override function */
		
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			var node:MenuNode = notification.getBody() as MenuNode;
			var swfContianer:Sprite = facade.retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as Sprite;
			var swfLoader:SWFLoader = new SWFLoader( node.val.url, {
				//estimatedBytes:size, 
				container:swfContianer, 
				autoPlay:true,
				scaleMode:"proportionalInside",
				width:swfContianer.stage.stageWidth,
				height:swfContianer.stage.stageHeight-40,//这里要剪掉bottom_mc的高度
				onComplete :completeHandler,
				onError :errorHandler,
				onProgress :progressHandler 
				} );
			var size:int = node.val.size;
			var loaderProxy:LoaderProxy = facade.retrieveProxy(LoaderProxy.NAME) as LoaderProxy;
			
			swfLoader.load();
			loaderProxy.currentLoader = swfLoader;
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
			var swf:DisplayObject = e.target.content;
			swf.alpha = 0;
			//swf.scaleX = swf.scaleY = .8;
			TweenLite.to(swf, .5, { alpha:1,scaleX:1,scaleY:1 } );
			sendNotification(EventConst.SYS_LOADED);
		}
		
		private function progressHandler(e:LoaderEvent):void 
		{
			trace("progress: " + e.target.progress);
			sendNotification(EventConst.SYS_PROGRESS,e.target.progress);
		}
		
	}
	
}