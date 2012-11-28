package com.xueersi.corelibs.ease
{
	import gs.TweenLite;

	public class LeftLeave extends Ease
	{
		override public function executeEase(obj:Object):void 
		{
			TweenLite.to(obj, EASE_TIME, { x:-obj.width, onComplete:onEaseCompleted,onCompleteParams:[] } );
		}
	}
}