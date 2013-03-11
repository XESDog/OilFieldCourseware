package com.xesDog.oilField.model 
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**	
	 * @描述		声音proxy
	 * @作者		Mr.zheng
	 * @webSite	http://blog.sina.com.cn/zihua2007
	 * @创建日期	2012/12/6 12:55
	 */
	public class SoundProxy extends Proxy
	{
		//private var _xmlLoader:XMLLoader;
		private var _xmlLoader:URLLoader;
		private var _queue:LoaderMax;
		private var _bgSounds:Array = [];
		//播放方式，0为顺序播放，1为随机播放
		private var _playType:int = 0;
		//播放状态，0为没有播放，1为暂停播放，2为正在播放
		private var _playState:int = 0;
		private var _currentBgSound:MP3Loader;//当前背景音乐
		private var _isLoaded:Boolean=false;
		
		public static const TYPE_ORDER:int = 0;
		public static const TYPE_RANDON:int = 1;
		
		public static const STATE_STOP:int = 0;
		public static const STATE_PAUSE:int = 1;
		public static const STATE_PLAY:int = 2;
		
		public static const NAME:String = "sound_proxy";
		private static const SOUND_XML_URL:String = "../assets/xml/sound.xml";
		
		public static const SOUND_PRESS:String = "press";
		public static const SOUND_ORLLOVER:String = "rollover";
		public static const SOUND_ORLLOUT:String = "rollout";
		
		public function SoundProxy(proxyName:String=null, data:Object=null) 
		{
			super(proxyName, data);
		}
		/** public function */
		public function playPress():void {
			if(!_isLoaded)return;
			var soundLoader:MP3Loader = LoaderMax.getLoader(SOUND_PRESS) as MP3Loader;
			if (soundLoader == null) return;
			soundLoader.gotoSoundTime(0, true);
		}
		public function playRollOver():void {
			if(!_isLoaded)return;
			var soundLoader:MP3Loader = LoaderMax.getLoader(SOUND_ORLLOVER) as MP3Loader;
			if (soundLoader == null) return;
			soundLoader.gotoSoundTime(0, true);
		}
		public function playRollOut():void {
			/*var soundLoader:MP3Loader = LoaderMax.getLoader(SOUND_ORLLOUT) as MP3Loader;
			var a:*= LoaderMax.getContent(SOUND_ORLLOUT);
			if (soundLoader == null) return;
			soundLoader.playSound();*/
		}
		public function playBgSound(mp3Loader:MP3Loader):void {
			_currentBgSound = mp3Loader;
			mp3Loader.playSound();
			mp3Loader.volume = 1;
			_playState = STATE_PLAY;
			mp3Loader.addEventListener(MP3Loader.SOUND_COMPLETE, onBgSoundComplete);
		}
		/**
		 * 在暂停和播放中间切换
		 */
		public function pauseBgSound():void {
			if (_currentBgSound == null) return;
			if (_currentBgSound.soundPaused) {
				_currentBgSound.playSound();
			}else {
				_currentBgSound.pauseSound();
			}
		}
		public function stopBgSound():void {
			
		}
		/** override function */
		override public function onRegister():void 
		{
			super.onRegister();
			//读取声音素材
			loadSoundXml();
		}
		override public function onRemove():void 
		{
			super.onRemove();
		}
		
		/** private function */
		private function loadSoundXml():void {
			/*var xmlLoaderVars:XMLLoaderVars = new XMLLoaderVars();
			xmlLoaderVars.name("soundXmlLoader");
			xmlLoaderVars.onInit(onInit);
			xmlLoaderVars.onChildOpen(onChildOpen);
			xmlLoaderVars.onChildComplete (onChildComplete);
			xmlLoaderVars.onChildFail(onChildFail);
			xmlLoaderVars.onComplete(onComplete);
			xmlLoaderVars.onChildComplete(onChildComplete);
			xmlLoaderVars.onError(onError);
			_xmlLoader = new XMLLoader(SOUND_XML_URL, xmlLoaderVars);
			_xmlLoader.load();*/
			
			_xmlLoader = new URLLoader(new URLRequest(SOUND_XML_URL));
			_xmlLoader.addEventListener(Event.COMPLETE, onSoundXmlComplete);
		}
		
		private function onInit(e:LoaderEvent):void 
		{
			trace("on init!")
		}
		
		private function onError(e:LoaderEvent):void 
		{
			trace("on error!");
		}
		
		private function onChildOpen(e:LoaderEvent):void 
		{
			trace("on child open ");
		}
		
		private function onChildFail(e:LoaderEvent):void 
		{
			trace("child failed!");
		}
		
		private function onFail(e:LoaderEvent):void 
		{
			trace("load failed!");
		}
		
		/**
		 * 自对象loaded
		 * @param e
		 */
		private function onChildComplete(e:LoaderEvent):void 
		{
			var mp3Loader:MP3Loader = e.target as MP3Loader;
			if (mp3Loader.name.split("_")[0] == "bg") {
				_bgSounds.push(mp3Loader);
				if (_currentBgSound == null) {
					playBgSound(mp3Loader);
				}
			}
		}
		/**
		 * 声音播放完毕，播放下一首
		 * @param	e
		 */
		private function onBgSoundComplete(e:Event):void 
		{
			var index:int = _bgSounds.indexOf(_currentBgSound);
			var len:int = _bgSounds.length;
			e.target.removeEventListener(Event.COMPLETE, onSoundXmlComplete);
			//顺序播放
			if (_playType == TYPE_ORDER) {
				index++;
				if (index >= len) {
					index = 0;
				}
				playBgSound(_bgSounds[index]);
			}
			//随机播放
			if (_playType == TYPE_RANDON) {
				var temp:MP3Loader=_bgSounds.splice(index, 1);
				len = _bgSounds.length;
				var num:int = Math.random() * len;
				playBgSound(_bgSounds[num]);
				_bgSounds.splice(index,0,temp);
			}
		}
		/**
		 * xml加载完毕
		 * @param	e
		 */
		private function onSoundXmlComplete(e:Event):void 
		{
			_queue = new LoaderMax( { name:"loaderMax",onComplete:onComplete } );
			var xml:XML= new XML(_xmlLoader.data);
			var xmlList:XMLList = xml.descendants("MP3Loader");
			var len:int = xmlList.length();
			for (var i:int = 0; i < len; i++) 
			{
				var item:XML = xmlList[i];
				_queue.append(new MP3Loader(item.@url, { name:item.@name ,onComplete:onChildComplete,autoPlay:false} ));
			}
			_queue.load();
		}
		
		/**
		 * 所有声音加载完毕
		 * @param	e
		 */
		private function onComplete(e:LoaderEvent):void 
		{
			_isLoaded=true;
		}
	}

}





















