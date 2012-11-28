package com.xueersi.corelibs.ease
{
	import com.xueersi.corelibs.event.EaseEvent;
	import com.xueersi.corelibs.interfaces.IEase;
	
	import flash.events.EventDispatcher;
	
	/**
	 * @describe  	缓动基类
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-3-28 17:31
	 */
	public class Ease extends EventDispatcher implements IEase
	{	
		/**
		 * 动画执行时间
		 */
		public static var EASE_TIME:Number = .5;
		/* INTERFACE com.sonModule.coreLib.interfaces.IEase */
		
		public function executeEase(obj:Object):void 
		{
			//子类继承
		}
		/* public function */
		
		/* override function */
		/**
		 * 缓动执行完成之后发送事件
		 * 子类覆写
		 */
		protected function onEaseCompleted():void {
			this.dispatchEvent(new EaseEvent(EaseEvent.EASE_COMPLETED));
		}
		/* private function */ 
	}
	
}