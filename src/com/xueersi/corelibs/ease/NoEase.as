package com.xueersi.corelibs.ease
{
	public class NoEase extends Ease
	{
		override public function executeEase(obj:Object):void 
		{
			onEaseCompleted();
		}
	}
}