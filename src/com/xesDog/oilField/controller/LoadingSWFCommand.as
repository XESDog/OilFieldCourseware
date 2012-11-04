package com.xesDog.oilField.controller 
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.LoaderMaxVars;
	import com.greensock.loading.data.SWFLoaderVars;
	import com.greensock.loading.LoaderMax;
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
		private var _swfName:String;
		public function LoadingSWFCommand() 
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
			
			_swfName = "swf" + node.key;
			
			var swfContianer:Sprite = facade.retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as Sprite;
			queue.append(new SWFLoader(node.val.url, { name:_swfName, estimatedBytes:size, container:swfContianer, autoPlay:false } ));
			queue.load();
			
			loaderProxy.currentLoader = queue;
		}
		
		private function errorHandler(e:LoaderEvent):void 
		{
			trace("error occured with " + e.target + ": " + e.text);
			sendNotification(EventConst.SYS_ERROR);
		}
		
		private function completeHandler(e:LoaderEvent):void 
		{
			trace(e.target + " is complete!");
			var swf:DisplayObject = LoaderMax.getContent(_swfName);
			swf.alpha = 0;
			TweenLite.to(swf, .5, { alpha:1 } );
			sendNotification(EventConst.SYS_LOADED);
		}
		
		private function progressHandler(e:LoaderEvent):void 
		{
			trace("progress: " + e.target.progress);
			sendNotification(EventConst.SYS_PROGRESS,e.target.progress);
		}
		/* private function */
	}
	
}