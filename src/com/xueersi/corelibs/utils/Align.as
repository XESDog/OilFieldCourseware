package com.xueersi.corelibs.utils{
	
	/*
	  默认左上点为(0,0)的显示对象  对齐返回坐标
	*/
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class Align {

		public function Align() {
			// constructor code
		}
		public static function left_Or_Top(  targetStartCoordinate:Number , margins:Number ):Number
		{
			var N:Number = targetStartCoordinate + margins;
			return N
		}
		/**
		 * 
		 * @param targetStartCoordinate  对齐目标物的起始坐标
		 * @param targetSize            对齐目标物的尺寸
		 * @param margins                对齐时 ，距离边界的距离 
		 * @param selfSize               对齐时 ，自己尺寸 
		 * @return 对齐后的坐标
		 * 
		 */		
		public static function right_Or_Bottom( targetStartCoordinate:Number , targetSize:Number , margins:Number ,selfSize:Number):Number
		{
			var N:Number = targetStartCoordinate + targetSize - margins - selfSize;
			return N
		}
		public static function center(  targetStartCoordinate:Number ,targetSize:Number, selfSize:Number):Number
		{
			var N:Number = targetStartCoordinate + ( targetSize - selfSize )/2;
			return N
		}
		//-----------------------------缩放或旋转时点的映射并对齐--------------------------------------------------------------------------------//

		/*
		 * 本函数用于 两层嵌套的显示对象 ， 外包容器用于拖拽，内部容器用于缩放或者旋转。
		 * 在不改变内部容器和外部相对位置的情况下，仅外部容器相对于指定的全局某点的校正对齐    
		 * 返回：container所在层级的对齐的点。
		 * container           : 外部容器
		 * currentObject       : container内部的子对象，用于缩放、旋转，它的原点和它的父级容器container原点重合   
		 * specifiedGlobalPoint: 指定用于对齐的全局坐标点
		 * pointInnerCurrentObject: currentObject内部的坐标点  
		 * alignNow            : 是否马上对齐？ true, 在本函数就执行对齐操作，flase 在本函数不执行对齐操作。 
		 * 具体操作：
		 *       内部坐标点映射到全局globalPoint，将 globalPoint和 specifiedGlobalPoint比较，算出位移 deltaNumber
		 *       如果currentObject的各个父级容器中没有任何缩放，则，该 deltaNumber 就是 currentObject移动的距离，
		 *       通过移动container来实现currentObject中某点映射到全局坐标系中的位置不变。
		*/
		public static function doubleLayerNested_innerZoomOrRotate( container:DisplayObjectContainer , currentObject:DisplayObject ,specifiedGlobalPoint:Point , pointInnerCurrentObject:Point ,alignNow:Boolean=false):Point
		{
			var globalPoint:Point = currentObject.localToGlobal(pointInnerCurrentObject)
			//计算差距
			var deltaX:Number = globalPoint.x - specifiedGlobalPoint.x;
			var deltaY:Number = globalPoint.y - specifiedGlobalPoint.y;
			//实例中  使用的是 currentObject的父级容器  container.x ,container.y 由于 currentObject的原点和它父级容器重叠，因此
			var nx:Number = container.x-deltaX/2;
			var ny:Number = container.y-deltaY/2;
			var p:Point = new Point(nx,ny);
			if(alignNow)
			{
				container.x = nx;
				container.y = ny;
			}
			return p;
		}
	}
	
}
