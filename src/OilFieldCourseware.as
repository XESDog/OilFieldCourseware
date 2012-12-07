package
{
	import com.bit101.components.Style;
	import com.xesDog.oilField.ApplicationFacad;
	import com.xesDog.oilField.manager.ResizeManager;
	import com.xesDog.oilField.manager.XmlManager;
	
	import flash.display.MovieClip;
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
			
			//放置mainMc
			var mainMc:MainMc = new MainMc();
			mainMc.name = "mainMc";
			mainMc.mouseEnabled = false;
			this.addChild(mainMc);
			setAutoPosition(mainMc);
		}
		/**
		 * xml解析完毕
		 * @param	e
		 */
		private function onMenuXmlParsed(e:Event):void 
		{
			ApplicationFacad.instance.setUp(this);
		}
		/**
		 * 设置mc中对象的自适应屏幕信息
		 * @param	mc
		 */
		private function setAutoPosition(mc:MovieClip):void {
			//背景的宽高和场景一样大
			mc.bg_mc.onResize = function():void {
				mc.bg_mc.width = stage.stageWidth;
				mc.bg_mc.height = stage.stageHeight;
			}
			
			ResizeManager.instance.addResizeObj(mc.bg_mc);
			
			mc.log_mc.visible = false;
			mc.bigBtns_mc.visible = false;
			
			//底部横条
			mc.bottom_mc.percentX = 0;
			mc.bottom_mc.percentY = 1;
			mc.bottom_mc.offsetY = -40;
			mc.bottom_mc.onResize = function():void {
				mc.bottom_mc.width=stage.stageWidth;
			}
			ResizeManager.instance.addResizeObj(mc.bottom_mc);
			
			//版本信息
			mc.version_mc.percentX = 0;
			mc.version_mc.percentY = 1;
			mc.version_mc.offsetX = 10;
			mc.version_mc.offsetY = -30;
			ResizeManager.instance.addResizeObj(mc.version_mc);
			
			//播放按钮
			mc.play_mc.percentX = 1;
			mc.play_mc.percentY = 1;
			mc.play_mc.offsetX = -262;
			mc.play_mc.offsetY = -30;
			ResizeManager.instance.addResizeObj(mc.play_mc);
			
			mc.transparentPlay_mc.percentX = 1;
			mc.transparentPlay_mc.percentY = 1;
			mc.transparentPlay_mc.offsetX = -262;
			mc.transparentPlay_mc.offsetY = -30;
			ResizeManager.instance.addResizeObj(mc.transparentPlay_mc);
			
			//声音
			mc.sound_mc.percentX = 1;
			mc.sound_mc.percentY = 1;
			mc.sound_mc.offsetX = -175;
			mc.sound_mc.offsetY = -30;
			ResizeManager.instance.addResizeObj(mc.sound_mc);
			
			//帮助
			mc.help_mc.percentX = 1;
			mc.help_mc.percentY = 1;
			mc.help_mc.offsetX = -218;
			mc.help_mc.offsetY = -30;
			ResizeManager.instance.addResizeObj(mc.help_mc);
			
			//全屏
			mc.fullScreen_mc.percentX = 1;
			mc.fullScreen_mc.percentY = 1;
			mc.fullScreen_mc.offsetX = -102;
			mc.fullScreen_mc.offsetY = -30;
			ResizeManager.instance.addResizeObj(mc.fullScreen_mc);
			
			//首页
			mc.home_mc.percentX = 1;
			mc.home_mc.percentY = 0;
			mc.home_mc.offsetX = -72;
			mc.home_mc.offsetY = 20;
			ResizeManager.instance.addResizeObj(mc.home_mc);
			
			//中间大按钮
			mc.bigBtns_mc.percentX = .5;
			mc.bigBtns_mc.percentY = .5;
			ResizeManager.instance.addResizeObj(mc.bigBtns_mc);
		}
	}
}