package com.xueersi.corelibs.geometry {
	import flash.geom.Point;

	/*
	本类用于抛物线轨迹计算
	计算中注意y轴的翻转问题 造成结果y的正负相反
	*/
	public class ParabolicCalculation {
		
		//需计算的轴向；如，需计算x的值，则x轴向为需要计算的轴向
		public static const CALCULATE_X_AXIS:String = "calculate_x_axis"
		public static const CALCULATE_Y_AXIS:String = "calculate_y_axis"
		
		public function ParabolicCalculation() {
			// constructor code
		}
		//----------------------------标准式计算-------------------------
		/*
		抛物线标准方程： y^2=2px        x^2 = 2py
		*/
		public static function aaaa():void
		{
			
		}
		//----------------------------顶点式计算---------------------------
		/*
		已知抛物线上顶点和抛物线上任意点 求 顶点式的系数(coefficient): a
		顶点式：y = a(x-h)^2+k
		anyPoint:抛物线上任意一点
		vertex:抛物线顶点
		nA:顶点式的系数
		*/
		public static function coefficientOfVertexFormula( anyPoint:Point , vertex:Point ):Number
		{
			var nA:Number = (anyPoint.y-vertex.y)/Math.pow(anyPoint.x -vertex.x ,2)
			return nA;
		}
		/*
		该函数求 抛物线方程中 一次项的 那一轴向 的坐标。有两种情况：
		
		1、已知抛物线方程 y = a(x-h)^2+k ，及抛物线上某点x坐标，求y坐标
		   如果a >0 开口向上 ; 如果a <0 开口向下
		或
		2、已知抛物线方程 x = a(y-h)^2+k ，及抛物线上某点y坐标，求x坐标
		   如果a >0 开口向右 ; 如果a <0 开口向左
		   
		oneDegreeTerm_ByVertexFormula :求 一次项 ，通过顶点式；
		quadraticCoefficient:二次项系数  以y = a(x-h)^2+k 为例，即系数a
		quadraticTerm:二次项数值         以y = a(x-h)^2+k 为例，即x
		quadraticVertex:二次项顶点       以y = a(x-h)^2+k 为例，h    
		oneDegreeTermVertex:一次项顶点   以y = a(x-h)^2+k 为例，k  
		
		注意：该函数没有处理 flash显示y轴轴向与数学y轴相反的问题；需自行处理；
		*/
		public static function oneDegreeTerm_ByVertexFormula( quadraticCoefficient:Number , quadraticTerm :Number ,quadraticVertex:Number ,oneDegreeTermVertex:Number ):Number
		{
			var oneDegreeTerm:Number = quadraticCoefficient * Math.pow( quadraticTerm - quadraticVertex ,2 ) + oneDegreeTermVertex
			return oneDegreeTerm;
		}
		/*
		该函数求 抛物线方程中 2次项的 那一轴向 的坐标。有两种情况：
		1、已知抛物线方程y = a(x-h)^2+k ，及抛物线上某点y坐标，求x坐标
		2、已知抛物线方程x = a(y-h)^2+k ，及抛物线上某点x坐标，求y坐标
		在数学坐标轴上：
		如果a >0 开口向上
		如果a <0 开口向下
		注意： 但flash坐标的y轴与数学坐标轴相反。。。。。。。
		x = + - 根号下()
		symbolNum: 正1 或者-1
		*/
		public static function quadraticTerm_ByVertexFormula( symbolNum:int , quadraticCoefficient:Number , oneDegreeTerm:Number ,quadraticVertex:Number ,oneDegreeTermVertex:Number ):Number
		{
			var nX:Number = symbolNum * Math.sqrt( ( oneDegreeTerm - oneDegreeTermVertex )/ quadraticCoefficient ) + quadraticVertex;
			return nX;
		}
		/*  已知直线 y=kx+b  与 上下开口 抛物线 y = a(x-b)^2+c相交 ，该抛物线以y轴或y轴平行线(x=??)对称
		 *  求交点
		 *  symbolNum:用于开方是的 + - 号 判定
		 *  radians  :直线倾角弧度;
		 *  intercept:直线截距;
		 *  quadraticCoefficient:2次项系数
		 *  intersectWithLine:和直线相交
		 *  SymetryY: Y-axis is the axis of symmetry 
		 *  Vertex:  Vertex formula  顶点式
		*/
		public static function intersectWithLine_SymetryY_Vertex( symbolNum:int , radians:Number ,intercept:Number , quadraticCoefficient:Number , oneDegreeTermCoeff:Number , constantTerm:Number ):Point
		{
			intercept = -intercept;
			var nk:Number = Math.tan(radians)
			var temp1:Number = (intercept-constantTerm )/quadraticCoefficient
			var temp2:Number = oneDegreeTermCoeff + nk/(2* quadraticCoefficient)
			//被开方数
			var extractionOfRoot:Number =  temp1 -Math.pow(oneDegreeTermCoeff,2)+ Math.pow( temp2,2);
			var nx:Number = symbolNum*Math.sqrt( extractionOfRoot )+ temp2
			var ny:Number = (-1)*( nk*nx+intercept)
			return new Point( nx ,ny );
		}
		/*  已知抛物线顶点式：y = a(x-b)^2+c 方程 
		 *  求顶点坐标
		 *  oneDegreeTermCoeff:指 系数b
		*/
		public static function vertexCoordinate_VertexFormula( quadraticCoefficient:Number , oneDegreeTermCoeff:Number , constantTerm:Number ):Point
		{
			var nx:Number = oneDegreeTermCoeff;
			var ny:Number = -constantTerm;
			return new Point( nx ,ny )
		}
		
		
		//-----------------------------抛物线一般式计算------------------------------
		/*
		  计算轨迹数组
		  通过一般式： y = ax^2+bx+c 计算 上下开口, y轴对称的抛物线轨迹 返回数组
		  quadraticCoefficient：二次项系数 即上面方程中的 a
		  oneDegreeTermCoeff:一次项系数 即上面方程中的 b
		  constantTerm:常数项 即上面方程中的 c
		*/
		public static function yAxisSymmetryLocus_ByGeneral( minX:Number ,minY:Number ,maxX:Number , quadraticCoefficient:Number ,oneDegreeTermCoeff:Number ,constantTerm:Number , scale:Number  ):Array
		{
			var arr:Array = new Array();
			var tempx:Number = minX
			var tempy:Number = quadraticCoefficient * Math.pow(tempx ,2 )+ oneDegreeTermCoeff * tempx + constantTerm 
			arr.push( new Point( tempx * scale , (-1)*tempy * scale ) );
			while( tempx+0.2 <= maxX )
			{
				tempx += 0.2;
				tempy = quadraticCoefficient * Math.pow(tempx ,2 )+ oneDegreeTermCoeff * tempx + constantTerm 
				arr.push( new Point( tempx * scale , (-1)*tempy * scale ) );
			}
			if( tempx != maxX )
			{
				tempx = maxX;
				tempy = quadraticCoefficient * Math.pow(tempx ,2 )+ oneDegreeTermCoeff * tempx + constantTerm 
				arr.push( new Point( tempx * scale , (-1)*tempy * scale ) );
			}
			return arr
		}
		/*
		 通过一般式：  x = ay^2+by+c  计算 左右开口, x轴对称的抛物线轨迹 返回轨迹数组
		*/
		public static function xAxisSymmetryLocus_ByGeneral( minX:Number ,minY:Number ,maxX:Number ,maxY:Number ,salce:Number ,quadraticCoefficient:Number , oneDegreeTermCoeff:Number ,  constantTerm:Number ):Array
		{
			var arr:Array = new Array();
			var tempy:Number = minY
			var tempx:Number = quadraticCoefficient * Math.pow( tempy ,2 )+ oneDegreeTermCoeff * tempy + constantTerm 
			arr.push( new Point( tempx * salce , (-1)* tempy * salce ) );
			while( tempy+0.2 <= maxY )
			{
				tempy += 0.2;
				tempx = quadraticCoefficient * Math.pow( tempy ,2 )+ oneDegreeTermCoeff * tempy + constantTerm 
				arr.push( new Point( tempx * salce , (-1)* tempy * salce ) );
			}
			if( tempy != maxY )
			{
				tempy = maxY;
				tempx = quadraticCoefficient * Math.pow( tempy ,2 )+ oneDegreeTermCoeff * tempy + constantTerm 
				arr.push( new Point( tempx * salce ,(-1)* tempy * salce ) );
			}
			return arr
		}
		/*
		该函数计算抛物线方程中 仅有一次项的 那个轴向 的数值，它可以是以下两种情况：
		1、已知抛物线的方程 y = ax^2+bx+c  求与 x 取值对应的仅一次项 y 坐标
		   该方程是关于y轴或y轴平行线对称的抛物线，图象开口向 上 或 下
		
		或者
		
		2、已知抛物线的方程 x = ay^2+by+c  求与 y 取值对应的一次项 x 坐标
		   该方程是关于x轴或x轴平行线对称的抛物线，图象开口向 左 或 右
		   
		unKnownValue: 所求的 x 或者 y 数值
		oneDegreeTerm:可以译为 一次项 ，这个译法并不确定；
		quadraticTerm:已知的二次项数值 
		quadraticCoefficient：二次项系数 即上面方程中的 a
		oneDegreeTermCoeff:一次项系数 即上面方程中的 b
		constantTerm:常数项 即上面方程中的 c
		*/
		public static function oneDegreeTerm_ByGeneralFormula ( calculateAxis:String , quadraticTerm:Number , quadraticCoefficient:Number ,oneDegreeTermCoeff:Number ,constantTerm:Number ):Number
		{
			var unKnownValue:Number  = quadraticCoefficient * Math.pow( quadraticTerm ,2 ) + oneDegreeTermCoeff * quadraticTerm + constantTerm
			if( calculateAxis == CALCULATE_Y_AXIS )
			{
				return (-1)* unKnownValue
			}
			else
			{
				return  unKnownValue
			}
			
		}
		/*
		  求仅一次项的 轴向 的顶点坐标
		  例如： y = ax^2+bx+c  一次项的轴向即y轴 求y轴向的顶点坐标
		  calculateAxis:计算的数值的轴向  取值范围 CALCULATE_X_AXIS   CALCULATE_Y_AXIS 
		*/
		public static function oneDegreeTermVertex_ByGeneralFormula( calculateAxis:String , quadraticCoefficient:Number ,oneDegreeTermCoeff:Number ,constantTerm:Number ):Number
		{
			var vertex:Number = constantTerm - Math.pow( oneDegreeTermCoeff ,2 )/4 * quadraticCoefficient 
			if( calculateAxis == CALCULATE_Y_AXIS )
			{
				return (-1)* vertex
			}
			else
			{
				return  vertex
			}
			
		}
		
		/*
		  求二次项 轴向 的坐标值
		  例如： y = ax^2+bx+c  二次项的轴向即x轴 求x轴向的坐标
		  symbolNum:开方之后的 + - 取值:1 -1
		  oneDegreeTerm:仅一次的项的值； 例如： y = ax^2+bx+c 中y是仅一次的项
		*/
		public static function quadraticTerm_ByGeneralFormula( symbolNum:int ,calculateAxis:String , oneDegreeTerm:Number , quadraticCoefficient:Number , oneDegreeTermCoeff:Number ,constantTerm:Number ):Number
		{
			var temp:Number = oneDegreeTermCoeff/2* quadraticCoefficient;
			var temp2:Number; 
			var quadraticTerm:Number
			if( calculateAxis == CALCULATE_Y_AXIS )
			{
			    temp2 = ( oneDegreeTerm + constantTerm )/quadraticCoefficient 
			    quadraticTerm = symbolNum * Math.sqrt( Math.pow(temp ,2 ) - temp2 ) - temp
			}
			else
			{
			    temp2 = ( oneDegreeTerm - constantTerm )/quadraticCoefficient 
			    quadraticTerm = symbolNum * Math.sqrt( Math.pow(temp ,2 ) + temp2 ) - temp
			}
			return quadraticTerm;
		}
		/*
		  求二次项 轴向 的顶点坐标
		  例如： y = ax^2+bx+c  二次项的轴向即x轴 求x轴向的顶点坐标
		*/
		public static function quadraticTermVertex_ByGeneralFormula( calculateAxis:String , quadraticCoefficient:Number ,oneDegreeTermCoeff:Number ,constantTerm:Number ):Number
		{
			var vertex:Number = - oneDegreeTermCoeff / 2 * quadraticCoefficient
			if( calculateAxis == CALCULATE_Y_AXIS )
			{
				return (-1)* vertex
			}
			else
			{
				return  vertex
			}
		}
		
		/*
		本函数 求抛物线 顶点 到 焦点 的距离 即：焦距
		*/
		public static function focalLength_ByGeneralFormula ( calculateAxis:String , quadraticCoefficient:Number  ):Number
		{
			var vertexTotheFocus:Number  = 1/2 * quadraticCoefficient
			if( calculateAxis == CALCULATE_Y_AXIS )
			{
				return (-1)* vertexTotheFocus
			}
			else
			{
				return  vertexTotheFocus
			}
		}
		/*
		直线 y=kx+b  与 上下开口 抛物线 y = ax^2+bx+c相交 ，该抛物线以y轴或y轴平行线(x=??)对称
		求交点
		计算注意： 在直线方程代入抛物线方程的时候加个负号： -y = ax^2+bx+c
		symbolNum:用于开方是的 + - 号 判定
		radians:倾角弧度;
		intercept:截距;
		intersect With Line:和直线相交
		SymetryY: Y-axis is the axis of symmetry
		General: General formula 一般式
		
		*/
		public static function intersectWithLine_SymetryY_General( symbolNum:int , radians:Number ,intercept:Number , quadraticCoefficient:Number , oneDegreeTermCoeff:Number , constantTerm:Number  ):Point
		{
			intercept = -intercept;
			var k:Number = Math.tan(radians)
			var temp:Number = ( oneDegreeTermCoeff - k )/(2* quadraticCoefficient); 
			var temp2:Number = ( intercept-constantTerm ) / quadraticCoefficient;
			//trace( "根号内必须为正="+（ Math.pow( temp ,2 )+ temp2） )
			var nX:Number = symbolNum * Math.sqrt( Math.pow( temp ,2 )+ temp2 ) - temp;
			var nY:Number = -( k* nX + intercept)  
			return new Point( nX , nY );
		}
		/*
		直线 y=kx+b  与 左右开口 抛物线 x = ay^2+by+c 相交  该抛物线以x轴或x轴平行线(y=??)对称
		求交点
		symbolNum:用于开方是的 + - 号 判定
		intersect With Line:和直线相交
		SymetryX: X-axis is the axis of symmetry
		General: General formula 一般式
		*/
		public static function intersectWithLine_SymetryX_General( symbolNum:int , radians:Number ,intercept:Number , quadraticCoefficient:Number , oneDegreeTermCoeff:Number , constantTerm:Number ):Point
		{
			intercept = -intercept;
			var k:Number = Math.tan(radians)
			//第一种算法 没有做任何变化
			var temp1:Number = ( oneDegreeTermCoeff * k - 1 )/(2* quadraticCoefficient * k)
			var temp2:Number = ( constantTerm + intercept)/quadraticCoefficient
			var nY:Number =  symbolNum * Math.sqrt( Math.pow( temp1 ,2 )- temp2 ) - temp1
			var nX:Number = ( nY - intercept )/k;
			/*
			//第二种算法  如果上面的计算不正确，请再测试这一种  
			//该方法将 x = ay^2+by+c 中的y都替换为(-y) 然后将直线方程代入
			var temp1:Number = ( oneDegreeTermCoeff * k + 1 )/2* quadraticCoefficient * k
			var temp2:Number = ( constantTerm + intercept)/quadraticCoefficient
			var nY:Number =  symbolNum * Math.sqrt( Math.pow( temp1 ,2 )- temp2 ) + temp1
			var nX:Number = ( nY - intercept )/k;
			*/
			return new Point( nX , nY );
		}
		/*  已知抛物线一般式：y = ax^2+bx+c 方程 
		 *  求顶点坐标
		 *  quadraticCoefficient: 指 系数a
		 *  oneDegreeTermCoeff  : 指 系数b
		*/
		public static function vertexCoordinate_GeneralFormula( quadraticCoefficient:Number , oneDegreeTermCoeff:Number , constantTerm:Number ):Point
		{
			var nx:Number = -oneDegreeTermCoeff/(2*quadraticCoefficient);
			var ny:Number = -( constantTerm-Math.pow(oneDegreeTermCoeff,2)/(4*quadraticCoefficient) );
			return new Point( nx ,ny )
		}
	}
	
}
