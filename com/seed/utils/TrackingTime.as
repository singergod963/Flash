package com.seed.utils
{
	/**
	 * ...
	 * @author Simon
	 */
	public class TrackingTime 
	{
		public static var startTime:int = 0;
		public static var endTime:int = 0;
		
		public static function startTracking():void
		{
			startTime = getMs();
		}
		
		public static function endTracking():int
		{
			var spendTime:int;
			endTime = getMs();
			if (endTime > startTime) {
				spendTime = endTime - startTime;
			}else {
				
			}
			
			startTime = endTime = 0;
			return spendTime;
		}
		
		private static function getMs():int
		{
			var da:Date = new Date();
			var ms:int = (da.minutes * 60 + da.seconds) * 1000 + da.milliseconds;
			return ms;
		}
	}

}