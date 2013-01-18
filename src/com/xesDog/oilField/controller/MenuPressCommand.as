package com.xesDog.oilField.controller 
{
	import com.greensock.loading.VideoLoader;
	import com.xesDog.oilField.events.EventConst;
	import com.xesDog.oilField.mediator.BigBtnsMediator;
	import com.xesDog.oilField.mediator.MediaContainerMediator;
	import com.xesDog.oilField.model.LoaderProxy;
	import com.xesDog.oilField.model.MenuNode;
	import com.xesDog.oilField.model.MenuProxy;
	import com.xueersi.corelibs.utils.ParseUrl;
	
	import flash.display.MovieClip;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @describe  	鼠标按下时
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 16:32
	 */
	public class MenuPressCommand extends SimpleCommand
	{
		public function MenuPressCommand() 
		{
			super();
		}
		/* public function */
		
		/* override function */
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			var node:MenuNode = notification.getBody() as MenuNode;
			var menuProxy:MenuProxy = facade.retrieveProxy(MenuProxy.NAME) as MenuProxy;
			var currentPressNode:MenuNode = menuProxy.currentPressNode;
			//当前页已经显示
			if (currentPressNode == node) {
				return ;
			}
			
			if (node.isLeaf()) {
				clearBigBtns();
				//移除现有显示
				var loaderProxy:LoaderProxy = facade.retrieveProxy(LoaderProxy.NAME) as LoaderProxy;
				loaderProxy.unLoad();
				
				//视频的处理
				if(loaderProxy.currentLoader is VideoLoader){
					var mediaMediator:MediaContainerMediator=facade.retrieveMediator(MediaContainerMediator.NAME) as MediaContainerMediator;
					mediaMediator.unLoadVideo();
				}
				
				
				var mediaContainer:MovieClip = facade.retrieveMediator(MediaContainerMediator.NAME) .getViewComponent() as MovieClip;
				mediaContainer.removeChildren(0);
				
				//播放flash
				if (ParseUrl.parseUrlExpandedName(node.val.url) == "swf") {
					sendNotification(EventConst.SYS_LOAD_SWF, node);
				}
				//加载视频
				else if(ParseUrl.parseUrlExpandedName(node.val.url) == "flv" ||
					ParseUrl.parseUrlExpandedName(node.val.url) == "mp4" ||
					ParseUrl.parseUrlExpandedName(node.val.url) == "f4v"){
					sendNotification(EventConst.SYS_LOAD_VIDEO, node);
				}
				//加载图片
				else if (ParseUrl.parseUrlExpandedName(node.val.url) == "jpg" ||
					ParseUrl.parseUrlExpandedName(node.val.url) == "png" ||
					ParseUrl.parseUrlExpandedName(node.val.url) == "gif"){
					sendNotification(EventConst.SYS_LOAD_IMAGE, node);
				}else {
					sendNotification(EventConst.SYS_COLOR,node);
				}
				menuProxy.currentPressNode = node;
			}
			//主菜单被点击
			if (menuProxy.isMainMenu(node)) {
				sendNotification(EventConst.OPERATER_SHOWANDHIDE_MENU, node);
			}
		}
		/* private function */
		/**
		 * 删除页面中心的大按钮
		 */
		private function clearBigBtns():void {
			var bigBtns:MovieClip = facade.retrieveMediator(BigBtnsMediator.NAME).getViewComponent() as MovieClip;
			if (bigBtns.parent) {
				bigBtns.parent.removeChild(bigBtns);
			}
		}
	}
	
}