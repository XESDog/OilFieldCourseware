package com.xesDog.oilField.ui 
{
	
	import com.bit101.components.VBox;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-10-27 17:09
	 */
	public dynamic class UIMenuList extends MovieClip
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
		
		private var _space:int=1;
		
		public function UIMenuList(space:int) 
		{
			_menuVbox = new VBox();
			_space = space;
			_menuVbox.spacing = _space;
			super.addChild(_menuVbox);
			_sonListContainer = new Sprite();
			super.addChild(_sonListContainer);
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
		override public function addChild(child:DisplayObject):flash.display.DisplayObject 
		{
			throw new Error("请使用addMenu。");
			return super.addChild(child);
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
		 * @param	numInParent
		 */
		public function addSonList(sonList:UIMenuList,numInParent:int):void {
			removeSonList();
			_sonListContainer.addChild(sonList);
			sonList.alpha = 0;
			TweenLite.to(sonList, .5,{alpha:1});
			_sonList = sonList;
			//TODO:后去需要在这里作修改，改为随父级的宽度变换
			_sonListContainer.x = UIMenu.MENU_WIDTH+_space;
			var startY:int = numInParent * (30 + _menuVbox.spacing);
			_sonListContainer.y = startY;
			var globalY:int = _sonListContainer.localToGlobal(new Point(0,0)).y;
			var dValue:int =  globalY+ _sonListContainer.height - stage.stageHeight+40;//这里的40为bottom_mc高度
			if(dValue>0){
				_sonListContainer.y -= dValue;
			}else {
			}
		}
		/**
		 * 移除子菜单list
		 */
		public function removeSonList():void {
			if (_sonList == null) return;
			_sonListContainer.removeChild(_sonList);
			_sonList = null;
		}
		
		/* INTERFACE com.xesDog.oilField.core.IResize */
		
		public function onResize():void 
		{
		}
		
	}
	
}