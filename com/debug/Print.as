package com.debug 
{
	public class Print 
	{
		/**
		 * An equivalent of PHP's recursive print function print_r, which displays objects and arrays in a way that's readable by humans
		 * @param obj    Object to be printed
		 * @param level  (Optional) Current recursivity level, used for recursive calls
		 * @param output (Optional) The output, used for recursive calls
		 */
		public static function r(obj:*, level:int = 0, output:String = ''):* 
		{
			if(level == 0) output = '('+ Print.typeOf(obj) +') {\n';
			else if(level == 10) return output;
			
			var tabs:String = '\t';
			for(var i:int = 0; i < level; i++, tabs += '\t') { }
			for(var child:* in obj) {
				output += tabs +'['+ child +'] => ('+  Print.typeOf(obj[child]) +') ';
				
				if(Print.count(obj[child]) == 0) output += obj[child];
				
				var childOutput:String = '';
				if(typeof obj[child] != 'xml') {
					childOutput = Print.r(obj[child], level + 1);
				}
				if(childOutput != '') {
					output += '{\n'+ childOutput + tabs +'}';
				}
				output += '\n';
			}
			
			if(level == 0) trace(output +'}\n');
			else return output;
		}
		
		/**
		 * An extended version of the 'typeof' function
		 * @param 	variable
		 * @return	Returns the type of the variable
		 */
		public static function typeOf(variable:*):String 
		{
			if(variable is Array) return 'array';
			else if(variable is Date) return 'date';
			else return typeof variable;
		}
		
		/**
		 * Returns the size of an object
		 * @param obj Object to be counted
		 */
		public static function count(obj:Object):uint 
		{
			if(Print.typeOf(obj) == 'array') return obj.length;
			else {
				var len:uint = 0;
				for(var item:* in obj) 
				{
					if(item != 'mx_internal_uid') len++;
				}
				return len;
			}
		}
	}
}