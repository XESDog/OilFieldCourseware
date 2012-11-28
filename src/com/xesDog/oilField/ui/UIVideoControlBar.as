package com.xesDog.oilField.ui 
{
	
	import com.bit101.components.HSlider;
	import com.bit101.components.PushButton;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @描述		视频控制条
	 * @作者		Mr.zheng
	 * @webSite	http://blog.sina.com.cn/zihua2007
	 * @创建日期	2012/11/28 16:39
	 */
	public dynamic class UIVideoControlBar extends MovieClip
	{
		/**
		 * 播放按钮
		 */
		private var _playBtn:PushButton;
		/**
		 * 控制条
		 */
		private var _progressSlider:HSlider;
		public function UIVideoControlBar() 
		{
			_playBtn = new PushButton(this, 0, 0, "play");
			_playBtn.toggle = true;
			_progressSlider = new HSlider(this, 100, 0);
			_progressSlider .width= 500;
		}
		
		public function get playBtn():PushButton 
		{
			return _playBtn;
		}
		
		public function get progressSlider():HSlider 
		{
			return _progressSlider;
		}
		
	}

}