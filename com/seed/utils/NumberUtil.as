package com.seed.utils 
{
	/**
	 * ...
	 * @author Simon
	 */
	public class NumberUtil 
	{
		public static function getLotteryNumber(fromNum:int, toNum:int, countNum:int):Array
		{
			var arr1:Array = [];
			var arr2:Array = [];
			
			for (var i:int = fromNum; i <= toNum; i++) {
				arr1.push(i);
			}
			
			for (var j:int = 0; j < countNum; j++) {
				var ram:int = Math.random() * arr1.length;
				arr2.push(arr1.splice(ram, 1)[0]);
			}
			
			trace(arr2);
			return arr2;
		}
	}

}