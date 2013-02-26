package com.xesDog.oilField.ui
{
	import com.bit101.components.VBox;
	
	import flash.display.Sprite;
	
	/**
	 * 视频列表 
	 * @author xiaxien
	 * 
	 */
	public class UIVideoList extends Sprite
	{
		private var _hBox:VBox=new VBox();
		private var _videoListBG:VideoListBG=new VideoListBG();
		public function UIVideoList()
		{
			addChild(_videoListBG);
			addChild(_hBox);
		}
		public function addItem(item:Sprite):void{
			_hBox.addChild(item);
		}
		public function removeItem(item:Sprite):void{
			
		}
		/**
		 * 清除所有的item 
		 * 
		 */
		public function clearAll():void{
			
		}
	}
}