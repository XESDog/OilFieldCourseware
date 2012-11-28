package com.xueersi.corelibs.utils
{
	import com.xueersi.corelibs.utils.Align;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	

	/**
	 *  Horizontal   Equidistant  LayOut 
	 *   水平的                                          等距                            布局
	 * 将大小不一定相等的物体   按照从左到右（或者右到左的）的顺序  等距排列
	 * 他们的左右间隙是相等的 , 上下      中心对齐center   或者  上对齐up  下对齐  down 
	 * @author siyao zhao
	 * 
	 */	
	public class HorizontalEquidistantLayOut
	{
		/**
		 * 中间对齐
		 */		
		public static const CENTER:String = "center";
		/**
		 * 上对齐
		 */
		
		public static const UPPER:String = "upper";
		/**
		 * 下对齐
		 */
		public static const LOWER:String = "lower";
		
		public function HorizontalEquidistantLayOut()
		{
			
		}
		/**
		 * 对某一容器内的所有物体  进行从左到右的等距排列  其上下关系按照  中心   上   下   对齐 方式
		 * 
		 * @param container 容器
		 * @param gap 容器内物体的间隙
		 * @param containerH  容器的高  用于竖直方向   各物体的对齐标准
		 * @param  align: 竖直方向的对齐方式
		 */		
		public static function LeftToRight_inContainer(container:DisplayObjectContainer , gap:Number ,containerH:Number ,align:String ):void
		{
			var margins:Number = 5;
			var n:int = container.numChildren;	
			for(var i:int=0;i<n;i++)
			{
				var obj:DisplayObject = container.getChildAt(i);
				if(i-1>=0)
				{
					var objprev:DisplayObject = container.getChildAt(i-1);
					obj.x = objprev.x + objprev.width + gap;
				}
				else
				{
					obj.x = 0;
				}
				if(align==CENTER)
				{
					obj.y = Align.center( 0 ,containerH ,obj.height);
				}
				else if(align==UPPER)
				{
					obj.y = Align.left_Or_Top( 0 , margins) ;
				}
				else
				{
					obj.y = Align.right_Or_Bottom(0 ,containerH ,margins ,obj.height );
				}
			}
		}
		
	}
}