package com.xueersi.corelibs.geometry
{
	/*
	本类用于三角函数计算 本类测试文件:根据滑块变化的正弦曲线fla
	*/
	import flash.geom.Point;
	public class Trigonometric
	{
		public function Trigonometric()
		{
			// constructor code
		}
		//---------------------------------------------------用于数学的正弦计算---------------------------------------------------------------------------
		/*
		标准正弦公式轨迹。 
		startCoordinate:起始坐标 ,velocity:传播速度 ,amplitude:振幅  cycle:周期 ， offset平移 ， scaleX_Unit 每刻度格的实际像素，或叫单位长度
		startCoordinate 、 velocity  用于x轴传播
		amplitude:振幅  cycle:周期 ， offset平移 用于正弦公式计算
		scaleX_Unit 用于题面数值和绘图数值换算
		本函数的正弦线是一段不断延伸(出发点x固定 ,结束x逐渐增大,绘制范围增大)的曲线段
		*/
		public static function sineLocusSpreadFrom( startCoordinate:Number , velocity:Number ,amplitude:Number , cycle:Number , offset:Number , scaleX_Unit:Number = 1 ,scaleY_Unit:Number = 1 ):Array
		{
			var arr:Array = new Array();
			var nX:Number = startCoordinate;
			var nY:Number;
			var actualPixel_x:Number;
			if (cycle == 0)
			{
				return null;
			}
			else if ( cycle < 0 )
			{
				//向左传播
				while ( nX >= 2 * Math.PI / cycle - offset/cycle )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle * nX + offset);
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					nX -=  velocity;
				}
			}
			else
			{
				//向右传播
				while ( nX <= 2 * Math.PI / cycle - offset/cycle )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle * nX + offset);
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					nX +=  velocity;
				}
			}

			return arr;
		}
		/*
		标准正弦公式轨迹。 amplitude:振幅  cycle:周期 ， offset平移 ， scaleX_Unit 每刻度格的实际像素，或叫单位长度
		由于计算方式导致的 不同效果 
		本函数的正弦线是一段灵活跳越,蜿蜒前进的曲线段( 整个绘制范围不变，但不断向左、右前进)
		*/
		public static function sineLocusPassThrough( amplitude:Number , cycle:Number , offset:Number , scaleX_Unit:Number = 1 ,scaleY_Unit:Number = 1 ):Array
		{
			var arr:Array = new Array();
			var nX:Number = offset;
			var nY:Number;
			var actualPixel_x:Number;
			if (cycle == 0)
			{
				return null;
			}
			else if ( cycle < 0 )
			{
				while ( nX >= 2 * Math.PI / cycle - offset/cycle )
				//while ( nX >= 2 * Math.PI / cycle + offset )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle * nX + offset);
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					//( "nX=" + nX + ", nY="+ nY )
					nX -=  0.01;
				}
			}
			else
			{
				while ( nX <= 2 * Math.PI / cycle - offset/cycle )
				//while ( nX <= 2 * Math.PI / cycle + offset )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle * nX + offset);
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					//( "nX=" + nX + ", scaleX_Unit="+ scaleX_Unit )
					nX +=  0.01;
				}
			}

			return arr;
		}
		/*
		标准正弦公式轨迹。y=A*Math.sin( cycle *x+ offset)
		本函数中，绘制长度总是为一周期；
		注意：平移量随周期系数变化的正负情况。
		amplitude:振幅  cycle:周期 ， offset平移 ， scaleX_Unit 每刻度格的实际像素，或叫单位长度
		*/
		public static function sineLocus( amplitude:Number = 1 , cycle:Number = 1 , offset:Number = 0 , scaleX_Unit:Number = 1 ,scaleY_Unit:Number = 1 ):Array
		{
			var arr:Array = new Array();
			offset = offset* Math.PI
			var nX:Number = -offset/cycle;
			var nY:Number;
			var actualPixel_x:Number;
			if (cycle == 0)
			{
				return null;
			}
			else if ( cycle < 0 )
			{
				
				while ( nX >= 2 * Math.PI / cycle - offset/cycle )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle * nX + offset );
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					nX -=  0.01;
				}
			}
			else
			{
				while ( nX <= 2 * Math.PI / cycle - offset/cycle )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle *  nX + offset );
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					nX +=  0.01;
				}
			}

			return arr;
		}
		/*
		标准正弦公式轨迹。y=A*Math.sin( cycle *x+ offset)
		amplitude:振幅  cycle:周期 ， offset平移 ， scaleX_Unit 每刻度格的实际像素，或叫单位长度
		本函数无论周期为几，平移为几，绘制的起始值x和结束x是固定的
		*/
		public static function fixedDrawRangeSine( startCoordinate:Number , endCoordinate:Number ,velocity:Number , amplitude:Number = 1 , cycle:Number = 1 , offset:Number = 0 , scaleX_Unit:Number = 1 ,scaleY_Unit:Number = 1 ):Array
		{
			var arr:Array = new Array();
			offset = offset* Math.PI
			var nX:Number;
			var nY:Number;
			var actualPixel_x:Number;
			if (velocity == 0)
			{
				return null;
			}
			//else if ( cycle < 0 )
			else if ( velocity < 0 )
			{
				nX = startCoordinate;
				while ( nX >= endCoordinate )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle * nX + offset );
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					nX +=  velocity;
				}
			}
			else
			{
				nX = startCoordinate
				while ( nX <= endCoordinate  )
				{
					actualPixel_x = pixelToPI( nX ,scaleX_Unit )
					nY = -amplitude * Math.sin(cycle *  nX + offset );
					arr.push( new Point( actualPixel_x , nY * scaleY_Unit ) );
					nX +=  velocity;
				}
			}

			return arr;
		}
		//------------------------------------------------------用于物理的正弦波------------------------------------------------------------------------------------
		/*
		  本公式用于求物理的波的某点的振幅 即 y的值 
		  actrualX         :    该点nX 与原点 0的距离，即x坐标，实际像素值;
		  ( nX - startPointNum):该点nX 与左侧端点的距离  这个距离总是取正值? 
		  startAmplitudeDirection:起振的时候振幅的方向 +1 -1
		  time             :    计时
		  wavelength       :    波长
		  amplitude        :    振幅;
		  cycle            :    周期
		  返回实际绘制像素
		*/
		public static function physicalAmplitude1( actrualX:Number ,startPointNum:Number , startAmplitudeDirection:int , time:Number , wavelength:Number , amplitude:Number , cycle:Number  , scaleX_Unit:Number = 1 ,scaleY_Unit:Number = 1):Number
		{
			var nX :Number = actrualX /scaleX_Unit
			var nY:Number = startAmplitudeDirection * (-1)*( amplitude * Math.sin( 2*Math.PI/cycle * time - 2*Math.PI/wavelength* Math.abs( nX - startPointNum) ));
			return nY * scaleY_Unit
		}
		/*
		  本公式用于求物理的波的某点的振幅 即 y的值 
		  actrualX  :    该点nX 与原点 0的距离，即x坐标，实际像素值;
		  startPointNum : 开始的端点 ，波从右侧边界开始，右侧边界的题面值 
		  ( startPointNum-nX ) : 计算该点nX和右侧端点之间的距离  这个距离总是取正值? 
		  velocity    :速度，根据与x轴方向确定正负;
		  startAmplitudeDirection:起振的时候振幅的方向 +1 -1
		  wavelength  :波长
		  amplitude   :振幅;
		  返回实际绘制像素
		*/
		public static function physicalAmplitude2( actrualX:Number , time:Number , velocity:Number , frequency:Number , startAmplitudeDirection:int=1 ,  amplitude:Number=1 ,  scaleX_Unit:Number = 1 ,scaleY_Unit:Number = 1):Number
		{
			//转化为题面数值
			var nX :Number = actrualX /scaleX_Unit
			var nY:Number = startAmplitudeDirection * (-1)*( amplitude * Math.sin( 2*Math.PI * frequency * ( time-nX/velocity )) );
			return nY * scaleY_Unit
		}
		/*
		此函数作用：将舞台上刻度格的实际像素 与 Math.PI  进行比例转化
		nX 计算数值，非舞台上的实际像素 
		unit:实际像素/计算数值 比例
		*/
		private static function pixelToPI( nX:Number , unit:Number ):Number
		{
			var n:Number = nX* unit /( Math.PI/2 )
			return n;
		}

	}

}