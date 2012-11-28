package com.xueersi.corelibs.utils
{
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	//import org.manager.GlobalManager;

	/**
	 * 类转换操作工具
	 * @author aishi
	 * 
	 */    
	public class ClassUtil 
	{
		/**
		 * 克隆对象属性 
		 * @param oldObj 旧对象
		 * @param newObj 新对象
		 * @param condition 匹配正则表达式
		 * @return 
		 * 
		 */		
		public static function cloneProperty(oldObj:*,newObj:*,condition:RegExp=null):*{
			var arr_property:Array = [];
			var reg_test:RegExp = condition;
			
			var xml_target:XML = describeType(oldObj);
			var xmlList_variable:XMLList = xml_target.variable;
			for each(var xml_variable:XML in xmlList_variable)
			{
				var str_pro:String = String(xml_variable.@name);
				if(reg_test!=null){
					if (reg_test.test(str_pro))
					{
						newObj[str_pro]=oldObj[str_pro]
					}
				}else{
					newObj[str_pro]=oldObj[str_pro]
				}
			}
			return newObj
		}
		/**
		 * 根据linkage获取类对象 
		 * @param linkage 资源链接名
		 * @param appDomain 程序域
		 * @return 
		 * 
		 */		
		public static function getInstanceByLinkage(linkage:String, appDomain:ApplicationDomain = null):MovieClip
		{
			var obj:Class = getClassByLinkage(linkage,appDomain);
			return new obj() as MovieClip;
		}
		
		/**
		 * 根据linkage获取类对象 
		 * 
		 * @param linkage 资源链接名
		 * @param appDomain 程序域
		 * @return 
		 * 
		 */		
		public static function getClassByLinkage(linkage:String, appDomain:ApplicationDomain = null):Class
		{
			var obj:Class;
			if(!appDomain){
				//obj=GlobalManager.instance.defaultDomain.getDefinition(linkage) as Class;
			}else{
				obj=appDomain.getDefinition(linkage) as Class;
			}
			return obj;
		}
		/**
		 * 获取类名称 
		 * @param obj 对象
		 * @return 
		 * 
		 */		
		public static function getClassName(obj:Object):String{
			return getQualifiedClassName(obj).replace(/.*::?/s,"")
		}
		/**
		 * 获取类资源连接，扩展加"_MC"后缀 
		 * @param obj 对象
		 * @return 
		 * 
		 */		
		public static function getLinkage(obj:Object):String{
			return getClassName(obj);
		}
		/**
		 * 获取类对象构造函数Class
		 * @param obj 对象
		 * @return 
		 * 
		 */		
		public static function getClass(obj:Object):Class{
			return getDefinitionByName(getClassPackage(obj)) as Class;
		}
		/**
		 * 获取类包路径
		 * @param obj 对象
		 * @return 
		 * 
		 */		
		public static function getClassPackage(obj:Object):String{
			return getQualifiedClassName(obj).replace("::", ".");
		}
		/**
		 * 获取类对象构造函数Class
		 * @param classPackage 包路径
		 * @return 
		 * 
		 */		
		public static function getClassByPackage(classPackage:String):Class{
			return getDefinitionByName(classPackage) as Class;
		}
	}
}
