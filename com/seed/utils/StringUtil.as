package com.seed.utils 
{
	/**
	 * ...
	 * @author Simon
	 */
	public class StringUtil 
	{
		public static function isChinese(str:String):Boolean
		{
			return true;
		}
		
		public static function countChineseWord(str:String):int
		{
			var pattern:RegExp = /[\u4e00-\u9fa5]/g;
			return str.replace(pattern, "aa").length;
		}
		
		public static function fillWith(string:String, front:String, total:int):String 
		{
			var newStr:String = string;
			while (newStr.length < total) {
				newStr = front + newStr;
			}
			return newStr;
		}
		
		/**
		 * 半形轉成全形
		 * @param	small
		 * @return
		 */
		public static function changeToMaxiChar(small:String):String
		{
			var asciiTable:String = "!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
			var big5Table:String = "%uFF01%u201D%uFF03%uFF04%uFF05%uFF06%u2019%uFF08%uFF09%uFF0A%uFF0B%uFF0C%uFF0D%uFF0E%uFF0F%uFF10%uFF11%uFF12%uFF13%uFF14%uFF15%uFF16%uFF17%uFF18%uFF19%uFF1A%uFF1B%uFF1C%uFF1D%uFF1E%uFF1F%uFF20%uFF21%uFF22%uFF23%uFF24%uFF25%uFF26%uFF27%uFF28%uFF29%uFF2A%uFF2B%uFF2C%uFF2D%uFF2E%uFF2F%uFF30%uFF31%uFF32%uFF33%uFF34%uFF35%uFF36%uFF37%uFF38%uFF39%uFF3A%uFF3B%uFF3C%uFF3D%uFF3E%uFF3F%u2018%uFF41%uFF42%uFF43%uFF44%uFF45%uFF46%uFF47%uFF48%uFF49%uFF4A%uFF4B%uFF4C%uFF4D%uFF4E%uFF4F%uFF50%uFF51%uFF52%uFF53%uFF54%uFF55%uFF56%uFF57%uFF58%uFF59%uFF5A%uFF5B%uFF5C%uFF5D%uFF5E";
			
			var result:String = "";
			for ( var i:int = 0 ; i < small.length ; i ++ ) {
				var val:String = small.charAt(i);     
				var j:int = asciiTable.indexOf(val) * 6 ;        
				result += ( j > -1 ? unescape(big5Table.substring( j , j + 6 ) ) : val );    
			}
			  
			return result;
		}
		
		public static function clearDelimeters(formattedString:String):String
		{
			return formattedString.replace(/[\u000d\u000a\u0008\u0020]+/g,""); 
		}
	}

}