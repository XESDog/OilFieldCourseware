package com.xueersi.corelibs.geometry
{

     import flash.geom.Point;
	/*
	    二次函数的轨道计算 本类用于使用圆锥曲线公式（通用公式），通过参数的不同，来演化的各种曲线计算
		 a * Math.pow(Px,2) + b * Math.pow(Py,2) + c* Px* Py + d * Px + e* Py + f = 0
		 
		 ax^2 + by^2 + cxy + dx + ey + f = 0
	*/
	public class ConicCalculation
	{
		private var Na:Number;
		private var Nb:Number;
		private var Nc:Number;
		private var Nd:Number;
		private var Ne:Number;
		private var Nf:Number;
		
		private var Ns:Number;
		private var Nt:Number
		
		private var minNumX:Number 
		private var maxNumX:Number
		private var minNumY:Number
		private var maxNumY:Number
		//单位比例换算
		private var unitNum:Number;
		
		protected var _symmetryAxis:String;
		protected var _symmetryNum:Number;
		public var symmetryNumX:Number
		public var symmetryNumY:Number
		public static const X_AXIS:String = "x_axis";
		public static const Y_AXIS:String = "y_axis";
		public static const POSITIVE :String = "positive"
		public static const NEGATIVE :String = "negative"

        public function get symmetryNum():Number
		{
			return _symmetryNum
			
		}
		//构造函数
		public function ConicCalculation( minX:Number ,maxX:Number ,  minY:Number ,maxY:Number  ,unit:Number )
		{
			// constructor
			minNumX = minX/unit
			maxNumX = maxX/unit
			minNumY = minY/unit
			maxNumY = maxY/unit
			unitNum = unit
		}
		//根据通用公式创建轨迹数组
		public  function generalFormulaLocusCalculated( a:Number = 0 ,b:Number  = 0, c:Number = 0 , d:Number = 0,e:Number = 0,f:Number = 0):Array
		{
			Na = a
			Nb = b
			Nc = c
			Nd = d
			Ne = e
			Nf = f
			
			
			//以通用表达式为基础，根据参数情况，转换为各曲线函数形式,并计算曲线轨迹
			//设变量  ax^2+by^2+cxy+dx+ey+f=0
			var Px:Number = 0
			var Py:Number = 0;
			var arr:Array = new Array();
			
			if( a !=0 && b!=0 )
			{
			    //设变量 
			    Ns = d / 2 * a;
			    //设变量 
			    Nt = e / 2 * b;
				if( a == b)
				{
					//Math.pow(Nx-p ,2) + Math.pow(Ny-q ,2) = M
					//if(M<0){  //图形不存在  }
					//else if(M==0){  //点(p,q)  }
					//else if(M>0){  //圆心在(p,q)圆   }
					trace("圆或点");
				}
				else if (a != b && ( (a>0 && b>0) ||  (a<0 && b<0) )  )
				{
					//椭圆 Math.pow(Nx-p ,2)/Math.pow(Ns ,2) + Math.pow(Ny-q ,2)/Math.pow(Nt ,2) == 1
					//x^2/a^2 + y^2/b^2 == 1(简化写法) 焦点 c = 根号下 (a^2 +b^2 )
					trace("椭圆");
				}
				else if ( a != b && ( (a>0 && b<0) ||  (a<0 && b>0) ) )
				{
					//双曲线 Math.pow(Nx-p ,2)/Math.pow(Ns ,2) - Math.pow(Ny-q ,2)/Math.pow(Nt ,2) == 1
					//(x-p)^2/Ns^2 - (y-q)^2/Nt^2 == 1(简化写法) 焦点 c = 根号下 (a^2 +b^2 )
					trace("双曲线");

				}
			}
			else if( a == 0 && b ==0 )
			{
				trace("直线");
			}
			else if( a == 0 && b!= 0)
			{
				//("抛物线1");
			    Nt = e / 2 * b;
			}
			else if( b == 0 && a != 0)
			{
				//("抛物线2 关于y轴对称的抛物线");
				//a * Math.pow(Px,2) + c* Px* Py + d * Px + e* Py + f = 0
			    Ns = d / 2 * a;
				if( e != 0)
				{
					//对缩小后的数值进行 放大
					createOrbital( parabolicTrajectory2  , arr )
				}
			}
			//计算对称轴
			calculateSymmetryAxis()
			//-----------------------------------------------------------------------------------------
			return  arr
		}
		//-----------------------------演化圆---------------------------------------
		//圆半径、圆心、圆心角、正弦余弦、创建轨迹数组
		public function circleLocusCalculatedRadius( r:Number ,center:Point):Array
        {
			var arr:Array = new Array();
			var angle:Number = 0
			var nX:Number
			var nY:Number
			while( angle < Math.PI * 2 )
			{
				nX = center.x + r * Math.cos(angle)
				nY = center.y + r * Math.sin(angle)
				arr.push( new Point( nX ,nY ) )
				angle += 0.1
			}
			return arr
		}
		//圆 已知圆上一点某轴向坐标，求另一轴向坐标
		public function calculateCoordinationByCircleFormula( n:Number  ):Number
		{
			return 0
		}
		//----------------------------演化双曲线------------------------------------
        //双曲线标准公式创建轨迹数组
		public function hyperbolaStandardFormulaLocusCalculated(  ):Array
		{
			//需要判断轴向
			return []
		}
        private function createOrbital( someFun:Function ,arr:Array ):void
		{
			var pr:Number = 1/unitNum
			var i:Number = minNumX;
			while ( i<= maxNumX  )
			{
				i +=  pr;
				var Px:Number = i * unitNum;
				var Py:Number = someFun( Px,Na,Nb,Nc,Nd,Ne,Nf )
				arr.push( new Point( Px , Py ) );
			}
		}
		//计算对称轴
		private function calculateSymmetryAxis():void
		{
			if( Na == 0)
			{
				_symmetryAxis = X_AXIS
			}
			if( Nb == 0 )
			{
				_symmetryAxis = Y_AXIS
			}
			//对称方式 轴对称
			if( _symmetryAxis == X_AXIS )
			{
				//x轴对称
				if( Na!= 0)
				{
					_symmetryNum = - Ns;
				}
				else
				{
					
				}
			}
			if( _symmetryAxis == Y_AXIS )
			{
				//y轴对称
				if( Nb!= 0)
				{
					_symmetryNum = -Nt;
				}
				else
				{
					_symmetryNum = Na * Math.pow( Ns ,2  )- Nf
				}
				
			}
		}
		//----------------------------演化抛物线-----------------------------
		//关于x轴对称的抛物线  ax^2 + by^2 + cxy + dx + ey + f = 0
        public function parabolicTrajectory1(Px:Number , ...arg ):void
		{
			
		}
		//关于y轴对称的抛物线轨迹  ax^2 + by^2 + cxy + dx + ey + f = 0
        public function parabolicTrajectory2(Px:Number , ...arg ):Number
		{
			Px = Px/unitNum
			var n:Number = (-1)*  unitNum *( -arg[5] - arg[0]* Math.pow(Px,2) - arg[3]* Px )/arg[4]
			return n;
		}
	}

}