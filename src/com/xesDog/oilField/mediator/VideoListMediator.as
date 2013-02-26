package com.xesDog.oilField.mediator
{
	import com.xesDog.oilField.ui.UIVideoList;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 视频列表管理 
	 * @author xiaxien
	 * 
	 */
	public class VideoListMediator extends Mediator
	{
		private var _videoList:UIVideoList= new UIVideoList();
		public static const NAME:String="videolist_mediator";
		public function VideoListMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			viewComponent.addChild(_videoList);
			viewComponent.onResize = function(e:Event=null):void {
				viewComponent.offsetY =_videoList.stage.stageHeight-_videoList.height>>1;
			}
			viewComponent.percentX=1;
			viewComponent.offsetX=-_videoList.width-20;
		}
		override public function onRegister():void{
		}
		override public function onRemove():void{
			
		}
		override public function listNotificationInterests():Array{
			
			return [];
		}
		override public function handleNotification(notification:INotification):void{
			
		}
	}
}