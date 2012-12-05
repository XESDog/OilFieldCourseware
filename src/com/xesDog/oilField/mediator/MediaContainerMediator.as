package com.xesDog.oilField.mediator
{
	
	import com.greensock.loading.display.ContentDisplay;
	import com.xesDog.oilField.model.LoaderProxy;
	import flash.display.Sprite;
	import flash.events.Event;
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
		static public const NAME:String = "mediaContainer_mediator";
		
		public function MediaContainerMediator(mediatorName:String = null, viewComponent:Object = null)
		{
			super(mediatorName, viewComponent);
		
		}
		
		/* public function */
		
		/* override function */
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
			return [Event.RESIZE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			super.handleNotification(notification);
			switch (notification.getName())
			{
				case Event.RESIZE: 
					onResize();
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
					var contentDisplay:ContentDisplay = loaderProxy.currentLoader.content;
					contentDisplay.fitWidth = viewComponent.stage.stageWidth;
					contentDisplay.fitHeight = viewComponent.stage.stageHeight;
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
	}

}