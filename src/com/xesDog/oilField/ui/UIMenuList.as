package com.xesDog.oilField.ui 
{
	
	import com.bit101.components.VBox;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:09
	 */
	public class UIMenuList extends Sprite
	{
		/**
		 * 菜单项的容器
		 */
		private var _menuVbox:VBox;
		/**
		 * 子菜单列表
		 */
		private var _sonList:UIMenuList;
		/**
		 * 子菜单容器
		 */
		private var _sonListContainer:Sprite;
		/**
		 * 固定的宽
		 */
		private var _width:int;
		
		public function UIMenuList() 
		{
			_menuVbox = new VBox(this, 0, 0);
			_sonListContainer = new Sprite();
			addChild(_sonListContainer);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddStage);
		}
		
		/* public function */
		/**
		 * 添加菜单项
		 */
		public function addMenu(uiMenu:UIMenu):void {
			_menuVbox.addChild(uiMenu);
			_width = width > _width?width:_width;
		}
		//public function 
		/**
		 * 删除菜单项估计用不上
		 */
		/*public function removeMenu(uiMenu:UIMenu):void {
			_menuVbox.removeChild(uiMenu);
		}*/
		/* override function */
		
		/* private function */
		private function onAddStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
		}
		
		private function onRemoveStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddStage);
			
			//移出舞台的时候，将该菜单列表下的子菜单列表移除
			removeSonList();
		}
		/**
		 * 添加子菜单项
		 * @param	sonList
		 */
		public function addSonList(sonList:UIMenuList):void {
			_sonListContainer.addChild(sonList);
			_sonList = sonList;
			_sonListContainer.x = _width;
		}
		/**
		 * 移除子菜单list
		 */
		public function removeSonList():void {
			if (_sonList == null) return;
			_sonListContainer.removeChild(_sonList);
			_sonList = null;
		}
	}
	
}