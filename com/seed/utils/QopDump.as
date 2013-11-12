﻿/**
 * author: shinder lin
 * email: shinder.lin@gmail.com
 */
package com.seed.utils
{
	import flash.utils.describeType;

	public class QopDump
	{
		private static var n : int = 0;
		private static var str : String;

		// trace
		public static function echo(o : Object) : void
		{
			trace(go(o));
		}

		// return the result string
		public static function go(o : Object) : String
		{
			str = "";
			dump(o);
			// remove the lastest \n
			str = str.slice(0, str.length - 1);
			return str;
		}

		private static function dump(o : Object) : void
		{
			var type : String = describeType(o).@name;
			if (type == 'Array')
			{
				dumpArray(o);
			}
			else if (type == 'Object')
			{
				dumpObject(o);
			}
			else
			{
				appendStr(o);
			}
		}

		private static function appendStr(s : Object) : void
		{
			str += s + '\n';
		}

		private static function dumpArray(a : Object) : void
		{
			n++;
			var type : String;
			for (var i:String in a)
			{
				type = describeType(a[i]).@name;
				if (type == 'Array' || type == 'Object')
				{
					appendStr(getSpaces() + "[" + i + "]:");
					dump(a[i]);
				}
				else
				{
					appendStr(getSpaces() + "[" + i + "]:" + a[i]);
				}
			}
			n--;
		}

		private static function dumpObject(o : Object) : void
		{
			n++;
			var type : String;
			for (var i:String in o)
			{
				type = describeType(o[i]).@name;
				if (type == 'Array' || type == 'Object')
				{
					appendStr(getSpaces() + i + ":");
					dump(o[i]);
				}
				else
				{
					appendStr(getSpaces() + i + ":" + o[i]);
				}
			}
			n--;
		}

		private static function getSpaces() : String
		{
			var s : String = "";
			for (var i : int = 1; i < n; i++)
			{
				s += "  ";
			}
			return s;
		}
	}
}