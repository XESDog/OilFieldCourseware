package com.xueersi.corelibs.utils
{
	public class RandomUtil
	{
		/**
		 * 取两值间随机数 
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */		
		public static function randomNum(min:Number,max:Number):Number{
			var num:Number=Math.random();
			num=Math.round((max-min)*num)+min;
			return num;
		}
	}
}