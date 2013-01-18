package com.xueersi.corelibs.utils
{
	public class ParseUrl
	{
		/**
		 * 获取url的扩展名
		 * @param	url
		 * @return
		 */
		public static function parseUrlExpandedName(url:String):String {
			var expendName:String = "";
			var index:int = url.lastIndexOf(".");
			expendName = url.slice(index + 1);
			return expendName;
		}
	}
}