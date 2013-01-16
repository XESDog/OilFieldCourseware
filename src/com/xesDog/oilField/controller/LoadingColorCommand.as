package com.xesDog.oilField.controller 
{
	
	import com.greensock.TweenLite;
	import com.xesDog.oilField.mediator.MediaContainerMediator;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @描述
	 * @作者		Mr.zheng
	 * @webSite	http://blog.sina.com.cn/zihua2007
	 * @创建日期	2012/11/28 16:06
	 */
	public class LoadingColorCommand extends SimpleCommand
	{

		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			var container:Sprite = facade.retrieveMediator(MediaContainerMediator.NAME).getViewComponent() as Sprite;
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginFill(0xFFFFFF*Math.random(),1);
			sprite.graphics.drawRect(0, 0, container.stage.stageWidth,container.stage.stageHeight);
			sprite.graphics.endFill();
			container.addChild(sprite);
			sprite.alpha = 0;
			TweenLite.to(sprite,.5,{alpha:1});
		}
	}
}