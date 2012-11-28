package com.xueersi.corelibs.geometry
{
	/*
	  如果 
	
	*/
	import flash.geom.Point;

	public class CircleCalculate
	{

		public static const CLOCKWISE:String = "clockwise";
		public static const COUNTERCLOCKWISE:String = "counterclockwise";
		public function CircleCalculate()
		{
			// constructor code
		}
		/*
		已知 圆心和一过圆心直线的倾角 求直线与圆周交点
		此函数用于 鼠标拖动圆上的一点运动
		*/
		public static function locusPoint( centerX:Number ,centerY:Number ,radius:Number ,radians:Number ):Point
		{
			return new Point( centerX+ radius * Math.cos(radians), centerY + radius * Math.sin(radians) );
		}
		/*
		已知 圆心 半径 求圆在约定弧度范围内的轨迹
		此函数用于 获取圆的轨迹数组
		centerPoint:圆心
		startRadian:开始弧度
		endRadian:结束弧度   这两个弧度的顺序不可颠倒
		*/
		public static function locus( centerPoint:Point ,radius:Number ,startRadian:Number , endRadian:Number, directionStr:String="clockwise" ,deltaRadians:Number=0.05 ):Array
		{
			var arr:Array = new Array();
			var nx:Number;
			var ny:Number;
			var difference:Number;
			var radian:Number = startRadian;
			var directionNum:int;
			if (directionStr == CLOCKWISE)
			{
				//顺时针
				directionNum = 1;
			}
			else
			{
				//逆时针
				directionNum = -1;
			}
			while ( Math.abs(radian-endRadian)>=deltaRadians )
			{
				nx = centerPoint.x + radius * Math.cos(radian);
				ny = centerPoint.y + radius * Math.sin(radian);
			    arr.push( new Point( nx,ny ));
				radian +=  directionNum * deltaRadians;
				radian = reasonableRadian(radian)
			}
			if( radian != endRadian )
			{
				radian = endRadian
				nx = centerPoint.x + radius * Math.cos(endRadian);
				ny = centerPoint.y + radius * Math.sin(endRadian);
			    arr.push( new Point( nx,ny ));
			}
			return arr;
		}
		public static function reasonableRadian(radian:Number):Number
		{
			if (radian > Math.PI)
			{
				radian = radian - 2 * Math.PI;
			}
			else if (radian<-Math.PI)
			{
				radian = 2 * Math.PI + radian;
			}
			return radian;
		}

	}
}