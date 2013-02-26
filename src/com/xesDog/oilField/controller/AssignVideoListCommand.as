package com.xesDog.oilField.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 给videolist赋值 
	 * 1、根据dll生成对应的videolistItem对象
	 * 2、将videolistItem对象添加到videolist中
	 * @author xiaxien
	 * 
	 */
	public class AssignVideoListCommand extends SimpleCommand
	{
		//TODO:videolist 赋值
		override public function execute(notification:INotification):void{
			
		}
	}
}