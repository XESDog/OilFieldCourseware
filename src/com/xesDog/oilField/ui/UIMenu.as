package com.xesDog.oilField.ui 
{
	
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:08
	 */
	public class UIMenu extends Sprite
	{
		private var _menu:PushButton;
		public function UIMenu() 
		{
			_menu = new PushButton(this, 0, 0, "默认名称");
			
		}
		/* public function */
		public function setMenuName(name:String):void {
			_menu.label = name;
		}
		/* override function */
		
		/* private function */
	}
	
}