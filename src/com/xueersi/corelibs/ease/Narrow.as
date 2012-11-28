package com.xueersi.corelibs.ease
{
	import gs.TweenLite;
	
	/**
	 * @describe  	缓动缩小
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-3-28 17:24
	 */
	public class Narrow extends Ease 
	{
		override public function executeEase(obj:Object):void 
		{
			TweenLite.to(obj, EASE_TIME,{ scaleX:.5, scaleY:.5, onComplete:onComplete,onCompleteParams:[obj]});
		}
		/* public function */
		
		/* override function */
		
		/* private function */
		private function onComplete(param:*):void{
			param.scaleX=1;
			param.scaleY=1;
			onEaseCompleted();
		}
	}
	
}