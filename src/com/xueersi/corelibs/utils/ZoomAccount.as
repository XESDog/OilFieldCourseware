package com.xueersi.corelibs.utils {
	import com.xueersi.corelibs.utils.Align;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/*
	本类用于缩放时。
	*/
	public class ZoomAccount {

		public static const CENTER:String = "center";
		public static const LEFT_TOP:String = "left_top"
		public function ZoomAccount() {
			// constructor code
		}
		/*
		 已知最小尺寸和最大尺寸，计算中间的缩放过程值
		zoomInSize：最小尺寸
		zoomOutSize:最大尺寸
		
		scaleProportion:缩放比例
		新尺寸= 最小值+ （最大值-最小值）*缩放比例
		在两个给定的界限之间  以百分比控制缩放程序        适用于输入缩放百分比的计算
		percentage:百分比
		*/
		public static function zoomByPercentage(  zoomInSize:Number,zoomOutSize:Number , scaleProportion:Number  ):Number
		{
			var newSize:Number;
			newSize  = zoomInSize + ( zoomOutSize - zoomInSize )* scaleProportion;
			return newSize
		}
		/*  
		 * 已知一固定点  根据该固定点 和对角线上一动点 的距离进行缩放的计算
		 * 该固定点和动点如果形成一个矩形，则这里分别从不同轴向计算新矩形的长 宽 高      最后内容的大小就取决于这个矩形的面积
		 * 我们这里默认移动点在右下角   
		 * fixeDacmeCoordiate :固定点的坐标值 可能是x轴向，或y，但它必定是线段的一个端点，或者矩形的一个顶点，且在动点所在的对角线上。
		 * movingDacmeCoordiate:移动的点的坐标值  与 fixedCoordiate 的轴向对应
		 * align          :如果该值是 "center" 则  fixedCoordiate 是中点的值   如果是"left_top"，则fixedCoordiate是左上角的值
		*/
		public static function zoomByTowPoint( fixeDacmeCoordiate:Number , movingDacmeCoordiate:Number ,align:String ):Number
		{
			var newSize:Number;
			newSize = Math.abs( movingDacmeCoordiate - fixeDacmeCoordiate );
			return newSize
		}
		/*
		 * 自适应缩放计算  该方法用于布局
		 * 在等比缩放，并保证显示全部的情况下，
		 * 当显示对象放入与自己长宽比不同的容器中时，进行自适应缩放
		 * 其默认物体与容器的最小边距minMargins为0
		 * minMargins: 如果物体与容器比例相同 ，则minMargins为长宽共同的边距。如果比例不同，则是指差距悬殊的尺寸方向
		*/
		public static function adaptive(containerRect:Rectangle , displayObject:DisplayObject , minMargins:Number=0 ):void
		{
			var myW:Number = displayObject.width;
			var myH:Number = displayObject.height;
			//物体自身的长宽比
			var myRatio:Number = myW / myH;
			var containerW:Number = containerRect.width;
			var containerH:Number = containerRect.height;
			//物体宽与容器宽，高与容器高的 比例
			var wRatio:Number = containerW / myW;
			var hRatio:Number = containerH / myH;
            var scaleResultX:Number 
			var scaleResultY:Number;
			var rationalScale:Number
			if (wRatio>hRatio)
			{
				//按照hRatio计算
				rationalScale =  hRatio;
				myH = containerH-minMargins*2;
				myW = containerH * myRatio;
				
			}
			else
			{
				//按照wRatio计算
				rationalScale = wRatio;
				myW = containerW-minMargins*2;
				myH = containerW / myRatio
			}
			displayObject.width = myW;
			displayObject.height = myH;
			displayObject.x = Align.center( 0 ,containerW , myW );
			displayObject.y =  Align.center( 0 ,containerH , myH );
		}
	}
	
}
