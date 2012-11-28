package  com.xueersi.corelibs.geometry
{
	/*
	本类用于直线相关计算 使用直线方程 y = tg(radian)*x + b 斜截式 b为直线在y轴的截距
	*/
	import flash.geom.Point;
	public class BeelineCalculate {
		
		//相交
		public static const INTERSECT:String = "intersect"
		//垂直相交
		public static const PERPENDICULAR:String = "perpendicular"
		//平行
		public static const PARALLEL:String = "parallel"
		//重叠
		public static const OVERLAPPING:String = "overlapping"

		public function BeelineCalculate() 
		{
			// constructor code
		}
		/*
		计算倾斜角
		*/
		public static function calculateAngle( startPoint:Point ,endPoint:Point):Number
		{
			var radian:Number = Math.atan2( endPoint.y - startPoint.y ,endPoint.x - startPoint.x)
			return radian
		}
		/*
		 计算已知直线上距离 knownPoint 点 distance 远的一点的位置
		 radian:倾角的弧度
		*/
		public static function calculatePointByDistance( radian:Number ,knownPoint:Point ,distance:Number ):Point
		{
			
			var nX:Number = knownPoint.x - Math.cos(radian)*distance
			var nY:Number = knownPoint.y - Math.sin(radian)*distance
			return new Point( nX ,nY );
		}
		/*
		  已知直线上点的x坐标，求直线上点的y坐标 constantB:斜截式 constantB为直线在y轴的截距
		*/
		public static function coordinationY( known_nX:Number ,constantB:Number , radian:Number ):Number
		{
			var nY:Number = Math.tan(radian)* known_nX + constantB
			return nY
		}
		public static function coordinationY2( known_nX:Number ,constantB:Number , slope:Number ):Number
		{
			var nY:Number = slope * known_nX + constantB
			return nY
		}
		/*
		  已知直线上点的y坐标 求直线上点的x坐标  constantB:斜截式 constantB为直线在y轴的截距
		*/
		public static function coordinationX(  known_nY:Number ,constantB:Number , radian:Number ):Number
		{
			 var nX:Number
			if( Math.tan(radian) )
			{
			    nX = (  known_nY - constantB )/Math.tan(radian)
			}
			else
			{
				
			}
			return nX
		}
		public static function coordinationX2(  known_nY:Number ,constantB:Number , slope:Number ):Number
		{
			 var nX:Number
			if( slope )
			{
			    nX = (  known_nY - constantB )/slope
			}
			else
			{
				
			}
			return nX
		}
		/*
		已知斜率 和直线上一点 求直线方程的斜截式在y轴的截距
		*/
        public static function intercept_y( radian:Number ,pointOnLine:Point  ):Number
		{
			var constantB:Number
			if( Math.tan(radian) || Math.tan(radian)==0 )
			{
			    constantB = pointOnLine.y -  Math.tan(radian)* pointOnLine.x ;
			}
			else
			{
				trace( "Math.tan(radian)不存在 ")
			}
			return constantB
		}
		/*
		   已知直线上2点  求直线方程的斜截式在y轴的截距
		*/
        public static function intercept_y2( pointOnLine1:Point , pointOnLine2:Point ):Number
		{
			var radian:Number = calculateAngle( pointOnLine1 ,pointOnLine2 )
			var constantB:Number
			if( Math.tan(radian) || Math.tan(radian)==0 )
			{
			    constantB =  pointOnLine1.y -  Math.tan(radian)* pointOnLine1.x ;
			}
			else
			{
				trace( "intercept_y2 ，Math.tan(radian)不存在 ")
			}
			return constantB
		}
		/*
		已知直线 和直线外一点  求点到直线的垂线与直线的交点
		perpendicular垂线  intersection交点
		knownLine_radian:已知直线的倾角   knownPointOutLine 已知直线外一点
		*/
        public static function perpendicularIntersection( knownLine_radian:Number , knownPointOutLine:Point ):Point
		{ 
			//计算鼠标点到直线BC的直线斜截式
			var someAngle:Number =  knownLine_radian + Math.PI/2 
			//( someAngle+","+ someAngle*180/Math.PI )
			//求斜截式的截距:
			var b:Number = intercept_y( someAngle, knownPointOutLine )
			var nX:Number = b/( Math.tan( knownLine_radian )- Math.tan( someAngle ) )
			var nY:Number = Math.tan( knownLine_radian )* nX
			//在直线上运动
			return new Point( nX , nY )
		}
        /*
		已知一直线斜率，和截距 ，以及另一直线斜率和截距， 求两直线交点 Point(x,y)
		本函数求两已知直线的交点
		knownLineAngle:已知直线的倾角  knownLineIntercept：已知直线的截距
		otherKnownLineAngle:另一已知直线的倾角   oterKnownIntercept：另一已知直线的截距
		*/
		public static function intersectionOfTwoLine( knownLineRadian1:Number , knownLineIntercept1:Number , knownLineRadian2:Number , knownLineIntercept2:Number ,nx1:Number =0 ,nx2:Number=0):Point
		{
			var n:Number = (knownLineRadian1-knownLineRadian2)/Math.PI
			if( Math.abs(knownLineRadian1) == Math.abs(knownLineRadian2) || n is int )
			{
				//倾角相等或差值是PI的整数倍 无交点 平行或重叠
				return null;
			}
			var nX:Number;
			var nY:Number;
			var n1:Number = knownLineRadian1/(Math.PI/2) 
			var n2:Number = knownLineRadian2/(Math.PI/2) 
			if( ( n1 is int) && !( n1/2 is int) )
			{
				//("直线1 弧度 PI/2")
				nX = nx1 
			    nY = Math.tan( knownLineRadian2 )* nX + knownLineIntercept2;
			}
			else if( ( n2 is int) && !( n2/2 is int) )
			{
				//("直线2 弧度 PI/2")
				nX = nx2 
			    nY = Math.tan( knownLineRadian1 )* nX + knownLineIntercept1;
			}
			else
			{
			    nX = (knownLineIntercept2-knownLineIntercept1)/( Math.tan(knownLineRadian1)-Math.tan(knownLineRadian2) );
			    nY = Math.tan( knownLineRadian1 )* nX + knownLineIntercept1;
			}
			return new Point(nX,nY);
		}
		public static function intersectionOfTwoLine2( slope1:Number , knownLineIntercept1:Number , slope2:Number , knownLineIntercept2:Number ):Point
		{
			if( slope1 == slope2 )
			{
				//倾角相等 无交点 平行或重叠
				return null;
			}
			//(b2-b1)/tan(radian1)-tan(radian2)
			var nX:Number = ( knownLineIntercept2-knownLineIntercept1 )/( slope1-slope2 );
			var nY:Number =slope1* nX + knownLineIntercept1
			return new Point(nX,nY)
		}
		//------------------------------验证 点和直线 或者 直线和直线 的关系--------------------------------------------------------------------------
		/*
		  检测某点是否在直线上
		  point:待检测的点
		  knownPoint1:已知点1
		  knownPoint2:已知点2
		*/
		public static function ifPointOnLine( point:Point , knownPoint1:Point , knownPoint2:Point ):Boolean
		{
			var radians:Number = calculateAngle( knownPoint1 ,knownPoint2 );
			var intercept:Number = intercept_y( radians ,knownPoint1 );
			var ny:Number = coordinationY( point.x ,intercept ,radians );
			if( ny == point.y )
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		/*
		   检测两条直线关系 结果分别为：1平行 2重叠  3相交 4垂直相交  
		*/
		public static function detectRelationship( knownLineRadian1:Number , knownLineIntercept1:Number , knownLineRadian2:Number , knownLineIntercept2:Number ):String
		{
			//倾角相等 无交点 
			if( knownLineRadian1 == knownLineRadian2 || Math.abs(knownLineRadian1 - knownLineRadian2)==Math.PI )
			{
				//判断截距 
				if( knownLineIntercept1 != knownLineIntercept2 )
				{
					//平行
					return PARALLEL;
				}
				else
				{
					//重叠
					return OVERLAPPING;
				}
				
			}
			else
			{
			    var radians:Number =  knownLineRadian1-knownLineRadian2
				//倾角不等 相交 或者垂直相交
			    if( Math.abs(radians )== Math.PI/2 ||  Math.abs( radians )== Math.PI* 3 /2 )
			    {
				    //垂直
				    return PERPENDICULAR;
			    }
				else
				{
					//相交
				    return INTERSECT;
				}
			}
		}
		/*
		  验证两条直线是否平行 平行 true  不平行 false
		*/
		public static function ifParallel( knownLineRadian1:Number , knownLineIntercept1:Number , knownLineRadian2:Number , knownLineIntercept2:Number ):Boolean
		{
			//倾角相等 无交点 
			if( Math.tan(knownLineRadian1) == Math.tan(knownLineRadian2) )
			{
				//判断截距 
				if( knownLineIntercept1 != knownLineIntercept2 )
				{
					//平行
					return true;
				}
				else
				{
					//重叠
					return false;
				}
				
			}
			return false;
		}
		/*
		  验证两条直线是否垂直 垂直 true  垂直 false
		*/
		public static function ifVertical( knownLineRadian1:Number , knownLineIntercept1:Number , knownLineRadian2:Number , knownLineIntercept2:Number ):Boolean
		{
			var radians:Number =  knownLineRadian1-knownLineRadian2
			if( Math.abs(radians )== Math.PI/2 ||  Math.abs( radians )== Math.PI* 3 /2 )
			{
				//垂直
				return true;
			}
			else
			{
				return false;
			}
		}
		
		
	}
	
}
