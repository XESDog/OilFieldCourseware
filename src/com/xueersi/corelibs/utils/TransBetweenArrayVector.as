package com.xueersi.corelibs.utils
{
	public class TransBetweenArrayVector
	{
		public function TransBetweenArrayVector()
		{
		}
		//从 vector 到   array
		public static function vectorToArray(vector:*):Array
		{
			var array:Array=new Array();
			var callback:Function=function (item:*, index:int, vector:*):Boolean{
				array.push(item);
				return true;
			}
			vector.every(callback);
			return array;
		}
		//从Array转换为vector
		public static function arrayToVector(array:Array,vector:*):void
		{
			vector.push.apply(null,array);
		}
	}
}