package com.xesDog.oilField.mediator 
{
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @describe  	媒体容器
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 17:20
	 */
	public class MediaContainerMediator extends Mediator
	{
		static public const NAME:String = "mediaContainer_mediator";
		
		public function MediaContainerMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
		}
		/* public function */
		
		/* override function */
		override public function onRegister():void{
			trace("onRegister");
		}
		/* private function */
	}
	
}