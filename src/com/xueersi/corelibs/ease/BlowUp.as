package com.xueersi.corelibs.ease 
{
	
	import gs.TweenLite;
	
	/**
	 * @describe  	放大
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-3-28 16:54
	 */
	public class BlowUp extends Ease
	{
		
		override public function executeEase(obj:Object):void 
		{
			obj.scaleX = obj.scaleY = .25;
			TweenLite.to(obj, EASE_TIME, { scaleX:1, scaleY:1, onComplete:onEaseCompleted,onCompleteParams:[] } );
		}
		/* public function */
		
		/* override function */
		
		/* private function */
	}
	
}