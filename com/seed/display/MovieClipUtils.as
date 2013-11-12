package com.seed.display 
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Simon
	 */
	public class MovieClipUtils 
	{
		/**
		 * 取得影格標籤影格數
		 * @param	mc
		 * @param	frame
		 * @return
		 */
		public static function getLabelFrame(mc:MovieClip,frame:String):int
		{
			var labelArr:Array = mc.currentLabels;
			for (var i:int = 0; i < labelArr.length; i++) {
				var lb:FrameLabel = labelArr[i];
				if (lb.name.indexOf(frame) != -1) {
					return lb.frame;
				}
			}
			
			return 0;
		}
	}

}