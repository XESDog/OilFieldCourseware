package com.xesDog.oilField.model 
{
	
	import com.greensock.loading.core.LoaderItem;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * @describe  	...
	 * @author  	zihua.zheng
	 * @website 	http://blog.sina.com.cn/zihua2007
	 * @time		2012-11-4 21:52
	 */
	public class LoaderProxy extends Proxy
	{
		public var currentLoader:LoaderItem;
		public static const NAME:String = "loader_proxy";
		public function LoaderProxy(proxyName:String=null, data:Object=null) 
		{
			super(proxyName, data);
		}
		/* public function */
		public function unLoad():void {
			if(currentLoader)currentLoader.unload();
		}
		/* override function */
		
		/* private function */
	}
	
}