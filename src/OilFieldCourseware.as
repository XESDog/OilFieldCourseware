package
{
	import com.bit101.components.Style;
	import com.xesDog.oilField.ApplicationFacad;
	import com.xesDog.oilField.manager.ResizeManager;
	import com.xesDog.oilField.manager.XmlManager;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * @describe 一个课件的框架，用来播放视频和swf文件，主要功能
	 * 1.菜单的显示
	 * 2.swf和视频的导入
	 * 3.一些缓动效果
	 * @author   zihua.zheng
	 * @time     2012-10-27
	 */
	public class OilFieldCourseware extends Sprite
	{
		public function OilFieldCourseware()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			XmlManager.instance.loadMenuXml(XmlManager.MENU_XML_URL);
			XmlManager.instance.dispatcher.addEventListener(XmlManager.MENU_XML_PARSED, onMenuXmlParsed);
			
			ResizeManager.instance.init(this);
			
			//ui样式
			Style.setStyle(Style.DARK);
		}
		/**
		 * xml解析完毕
		 * @param	e
		 */
		private function onMenuXmlParsed(e:Event):void 
		{
			ApplicationFacad.instance.setUp(this);
		}
	}
}