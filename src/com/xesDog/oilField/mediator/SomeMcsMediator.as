package com.xesDog.oilField.mediator 
{
	
	import com.xueersi.corelibs.uiCore.ICSBtn;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @描述		散件
	 * @作者		Mr.zheng
	 * @webSite	http://blog.sina.com.cn/zihua2007
	 * @创建日期	2012/12/6 17:41
	 */
	public class SomeMcsMediator extends Mediator
	{
		private var _soundMc:ICSBtn;
		private var _playMc:ICSBtn;
		private var _transparentPlayMc:MovieClip;
		
		public static const NAME:String = "somemcs_mediator";
		public function SomeMcsMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
		}
		override public function onRegister():void 
		{
			super.onRegister();
			_soundMc = viewComponent.sound_mc;
			_playMc = viewComponent.play_mc;
			_transparentPlayMc = viewComponent.transparentPlay_mc;
			_transparentPlayMc.visible = false;
			_transparentPlayMc.buttonMode = true;
			_soundMc.addEventListener(MouseEvent.MOUSE_DOWN, onSoundMouseDown);
			_playMc.addEventListener(MouseEvent.MOUSE_DOWN, onPlayMouseDown);
			_transparentPlayMc.addEventListener(MouseEvent.MOUSE_DOWN, onTransparentPlayDown);
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			_soundMc.removeEventListener(MouseEvent.MOUSE_DOWN, onSoundMouseDown);
			_playMc.removeEventListener(MouseEvent.MOUSE_DOWN, onPlayMouseDown);
			_transparentPlayMc.removeEventListener(MouseEvent.MOUSE_DOWN, onTransparentPlayDown);
		}
		override public function handleNotification(notification:INotification):void 
		{
			super.handleNotification(notification);
		}
		override public function listNotificationInterests():Array 
		{
			return super.listNotificationInterests();
		}
		
		private function onSoundMouseDown(e:MouseEvent):void 
		{
		}
		private function onPlayMouseDown(e:MouseEvent):void 
		{
			_playMc.selected = !_playMc.selected;
			_transparentPlayMc.visible = _playMc.selected;
		}
		private function onTransparentPlayDown(e:MouseEvent):void 
		{
			_playMc.selected = !_playMc.selected;
			_transparentPlayMc.visible = false;
		}
	}
}