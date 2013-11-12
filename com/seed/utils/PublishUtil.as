package com.seed.utils
{
	import flash.external.ExternalInterface;
	import flash.net.*;
	public class PublishUtil
	{
		public static const FAVORITES : String = "Favorites";
		public static const FACEBOOK : String = "FaceBook";
		public static const GOOGLE : String = "Google";
		public static const PLURK : String = "Plurk";
		public static const TWITTER : String = "Twitter";
		public static const MSN : String = "MSN";

		/**
		@param sendTo:意要發佈的社群，屬性有 Favorites、FaceBook、Google、Plurk、Twitter、MSN.
		@param title: 標題.
		@param locationHerf: 網址.
		@example
		<code>
		new PublishUtil("FaceBook","這是標題","http://www.yahoo.com.tw");
		</code>
		 */
		public static function Share(sendTo : String, title : String, locationHerf : String = null)
		{
			var shareUrl:String;
			switch(sendTo) {
				case PublishUtil.FACEBOOK:
					shareUrl = "http://www.facebook.com/sharer.php?u=" + encodeURIComponent(locationHerf);
					break;
			}
			
			if (ExternalInterface.available) {
				/*if (Utils.getBrowserName() == "Safari") {
					var jscommand:String = "window.open('" + shareUrl + "','','toolbar=0,status=1,width=626,height=326,resizable=1');";
					var myurl:URLRequest = new URLRequest("javascript:" + jscommand + " void(0);");
					navigateToURL(myurl, "_self");
				}else {
					
				}*/
				Utils.openWindow(shareUrl, '', 'toolbar=0,status=1,width=626,height=326,resizable=1');
				//ExternalInterface.call('window.open',shareUrl,'','toolbar=0,status=1,width=626,height=326,resizable=1');
			}
			
			
		}
	}
}