package com.xesDog.oilField.mediator 
{
	
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.model.ConfigProxy;
	import com.xesDog.oilField.model.SoundProxy;
	import com.xueersi.corelibs.uiCore.ICSBtn;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	
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
		private var _soundMc:MovieClip;
		private var _soundSlid:Slider;//声音控制条
		
		private var _playMc:ICSBtn;
		private var _transparentPlayMc:MovieClip;
		private var _fullScreenMc:ICSBtn;
		private var _homeMc:ICSBtn;
		
		private var _downX:int, _downY:int;
		
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
			_fullScreenMc = viewComponent.fullScreen_mc;
			_homeMc = viewComponent.home_mc;
			_transparentPlayMc.visible = false;
			_transparentPlayMc.buttonMode = true;
			
			
			//初始化状态是播放
			_transparentPlayMc.visible = _playMc.selected = !_playMc.selected;
			
			_soundSlid = _soundMc["slid"] as Slider;
			_soundSlid.visible = false;
			_soundSlid.addEventListener(SliderEvent.CHANGE, onChanged);
			_soundMc.addEventListener(MouseEvent.MOUSE_DOWN, onSoundMouseDown);
			_playMc.addEventListener(MouseEvent.MOUSE_DOWN, onPlayMouseDown);
			_transparentPlayMc.addEventListener(MouseEvent.MOUSE_DOWN, onTransparentPlayDown);
			_fullScreenMc.addEventListener(MouseEvent.MOUSE_DOWN, onFullscreenDown);
			_homeMc.addEventListener(MouseEvent.MOUSE_DOWN, onHomeDown);
			
			SoundMixer.soundTransform = new SoundTransform(_soundSlid.value / 10,1);
		}
		
		private function onChanged(e:SliderEvent):void 
		{
			SoundMixer.soundTransform = new SoundTransform(_soundSlid.value / 10,1);
		}
		
		private function onHomeDown(e:MouseEvent):void 
		{
			var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			navigateToURL(new URLRequest("http://"+configProxy.homePage));
		}
		
		private function onFullscreenDown(e:MouseEvent):void 
		{
			
			if (Stage(viewComponent.stage).displayState.indexOf(StageDisplayState.FULL_SCREEN)==-1) {
				var proxy:ConfigProxy=facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
				proxy.fullScreenClick=true;
				Stage(viewComponent.stage).displayState = StageDisplayState.FULL_SCREEN;
			}else {
				Stage(viewComponent.stage).displayState = StageDisplayState.NORMAL;
			}

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
			_soundMc.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_soundMc.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//_downX = _soundMc.stage.mouseX;
			//_downX = _soundMc.stage.mouseY;
			_soundSlid.visible = true;
			
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			_soundMc.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_soundMc.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_soundSlid.visible = false;
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var y:int = _soundMc.stage.mouseY;
			var num:int = (_soundMc.y-y)/10;
			_soundSlid.value = num;
			SoundMixer.soundTransform = new SoundTransform(_soundSlid.value / 10,1);
		}
		private function onPlayMouseDown(e:MouseEvent):void 
		{
			pauseSound();
			e.stopImmediatePropagation();
		}
		private function onTransparentPlayDown(e:MouseEvent):void 
		{
			pauseSound();
		}
		private function pauseSound():void {
			_transparentPlayMc.visible = _playMc.selected = !_playMc.selected;
			
			//var soundProxy:SoundProxy = facade.retrieveProxy(SoundProxy.NAME) as SoundProxy;
			//soundProxy.pauseBgSound();
			
			sendNotification(EventConst.PAUSE_AND_PLAY_ANIMAL);
		}
	}
}