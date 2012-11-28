package com.xueersi.corelibs.geometry
{
	import flash.geom.Point;
	import flash.display.DisplayObjectContainer;
    import com.xueersi.corelibs.geometry.BeelineCalculate;
	/*
	计算椭圆轨迹
	*/
	public class OvalCalculate {
		
		public static const POSITIVE_1 :int = 1
		public static const NEGATIVE_1 :int = -1
		
		public function OvalCalculate() {
			// constructor code
		}
		//-----------------------------椭圆标准公式 < x^2/a^2+y^2/b^2=1 >-----------------------------
		/*
		   使用椭圆标准公式创建轨迹数组
		   首先 x赋值最小，从最左端增加到最右端 ，y取正值
		   然后 x再从最右端到最左端，y取负值；
		   本函数主要用于根据数组中的连续坐标绘制椭圆形;
		   xA : x的分母系数a
		   yB : y的分母系数b
		   centerX: 中心点x坐标
		   centerY: 中心点y坐标
		   
		*/
		
		public static function standardFormulaLocus( xA:Number ,yB:Number , centerPoint:Point ):Array
		{
			// 对称轴
			var arr:Array = new Array();
			//椭圆的最左端
			var minX:Number = centerPoint.x - xA;
			//椭圆的最有段
			var maxX:Number = centerPoint.x + xA
			var nX:Number = minX
			var nY:Number;
			var point:Point
			//下半圈 
			while(  nX <= maxX  )
			{
				nY = coordinateByStandardOffset( POSITIVE_1 ,nX ,xA,centerPoint.x ,yB ,centerPoint.y)
				nX += 0.1
				point = new Point( nX,nY )
				arr.push( point )
			}
			//上半圈
			while(  nX >= minX  )
			{
				nY = coordinateByStandardOffset( NEGATIVE_1 , nX , xA ,centerPoint.x , yB ,  centerPoint.y )
				nX -= 0.1
				point = new Point( nX,nY )
				arr.push( point )
			}
			return arr
		}
		/*
		已知一直线 y=kx+b  椭圆 ： (x-x1)^2/a^2 + (y-y1)^2/b^2 = 1
		求该直线与椭圆的交点
		用于鼠标拖拽物体在椭圆上运动时，计算鼠标---圆心的连线与椭圆的交点
		我们首先假设椭圆的圆心点在坐标原点，因此直线方程的截距被消去，椭圆的分子被简化 ，这样计算量大大减少。然后我们根据实际圆心点把计算结果平移，来得到最终结果；
		symbolNum:  +1 或者 -1 中取一个
		radian： 鼠标---圆心连线的倾斜弧度
		container：当前显示层级容器；
		centerPoint:椭圆的圆心点；
		xA:即 x下的分母数字
		yB:即 y下的分母数字
		
		*/
		public static function lineIntersectOval( container:DisplayObjectContainer , centerPoint:Point , xA:Number ,yB:Number  ):Point
		{
			var nX:Number
			var nY:Number
			var mousePoint:Point = new Point( container.mouseX  , container.mouseY)
			var radian:Number = BeelineCalculate.calculateAngle( mousePoint , centerPoint );
			if( container.mouseX >= centerPoint.x )
			{
				nX = Math.sqrt( Math.pow( xA*yB,2)/ ( Math.pow(yB,2)+ Math.pow(xA,2)* Math.pow( Math.tan( radian ),2) ) )
			}
			else
			{
				nX = -Math.sqrt( Math.pow( xA*yB,2)/ ( Math.pow(yB,2)+ Math.pow(xA,2)* Math.pow( Math.tan( radian ),2) ) )
			}
			
			nY = Math.tan(radian) * nX
			
			nX = nX + centerPoint.x
			nY = nY + centerPoint.y
			return new Point( nX ,nY )
		}
		/*
		     已知一轴向坐标 ， 根据椭圆标准公式( 带原点平移,即中心点不在(0,0) )求另一轴向坐标
			 椭圆 ： (x-x1)^2/a^2 + (y-y1)^2/b^2 = 1
			 a = 椭圆长轴(宽)/2 
			 b = 椭圆短轴(高)/2  
			 symbolStr: 取值范围 POSITIVE_1 或 NEGATIVE_1 决定 开根号换算后 取正 还是 负值
			
			 someAxisCoordinate:已知的某轴向坐标
			 someAxisCoefficient: someAxisCoordinate的系数；
			 someAxisCenter：中心点的某轴向坐标；
			 otherAxisCoefficient：要计算的另一个坐标的系数
			 otherAxisCenter：中心点的另一个轴向坐标
			 情况1： 
			     当 someAxisCoordinate = x  someAxisCoefficient = a  someAxisCenter = x
			     otherAxisCoefficient = b  otherAxisCenter = y
			     所求为： 该坐标对应 y 值
			 情况2： 
			     当 someAxisCoordinate = y  someAxisCoefficient = b  someAxisCenter = y
			     otherAxisCoefficient = a  otherAxisCenter = x
			     所求为： 该坐标对应 x 值
		*/ 
		public static function coordinateByStandardOffset( symbolNum:int , someAxisCoordinate:Number ,someAxisCoefficient:Number ,someAxisCenter:Number , otherAxisCoefficient:Number , otherAxisCenter:Number ):Number
		{
			var otherAxisCoordinate:Number
			otherAxisCoordinate = symbolNum * Math.sqrt(  Math.pow( otherAxisCoefficient ,2) - Math.pow( otherAxisCoefficient/someAxisCoefficient ,2) * Math.pow( someAxisCoordinate - someAxisCenter ,2) ) + otherAxisCenter
			return otherAxisCoordinate
		}

	}
	
}
