package com.xesDog.oilField.mediator 
{
	
	import com.bit101.components.ProgressBar;
	import com.xesDog.oilField.events.EventConst;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	加载
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 17:27
	 */
	public class LoadingProgressMediator extends Mediator
	{
		private var _progressBar:ProgressBar;
		static public const NAME:String = "loading_progress_mediator";
		public function LoadingProgressMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			_progressBar = new ProgressBar(viewComponent as Sprite);
			_progressBar.x = -_progressBar.width >> 1;
			_progressBar.y = -_progressBar.height >> 1;
			viewComponent.removeChild(_progressBar);
		}
		/* public function */
		public function setProgress(rate:Number):void {
			_progressBar.value = rate;
		}
		/* override function */
		override public function onRegister():void 
		{
			super.onRegister();
		}
		override public function onRemove():void 
		{
			super.onRemove();
		}
		override public function listNotificationInterests():Array 
		{
			return [EventConst.SYS_LOAD_SWF,EventConst.SYS_LOAD_VIDEO,EventConst.SYS_PROGRESS,EventConst.SYS_LOADED];
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
			var type:String = notification.getName();
			switch (type) 
			{
				case EventConst.SYS_LOAD_SWF:
				case EventConst.SYS_LOAD_VIDEO:
					viewComponent.addChild(_progressBar);
				break;
				case EventConst.SYS_PROGRESS:
					setProgress(notification.getBody() as Number);
				break;
				case EventConst.SYS_LOADED:
					viewComponent.removeChild(_progressBar);
				break;
				default:
			}
		}
		
		/* private function */
	}
	
}