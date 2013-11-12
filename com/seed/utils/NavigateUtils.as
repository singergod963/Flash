package com.seed.utils 
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author Simon
	 */
	public class NavigateUtils 
	{
		public static const WINDOW_SELF:String   = '_self';
		public static const WINDOW_BLANK:String  = '_blank';
		public static const WINDOW_PARENT:String = '_parent';
		public static const WINDOW_TOP:String    = '_top';
		
		public static function getUrlParam(urlStr:String,param:String):String
		{
			if (urlStr.indexOf("?") == -1) {
				return "";
			}
			var arr:Array = urlStr.split("?")[1].split("&");
			var str:String = "";
			var strValue:String = "";
			
			for each(var i:String in arr) {
				str = i.split("=")[0];
				if (str == param) {
					strValue = i.split("=")[1];
				}
			}
			
			return strValue;
		}
		
		/**
			A Flash wrapper for JavaScript’s <code>window.open</code>.
			
			@param url: Specifies the URL you wish to open/navigate to.
			@param window: The browser window or HTML frame in which to display the URL indicated by the <code>url</code> parameter.
			@param features: Defines the various window features to be included.
			@return Returns <code>true</code> if the window was successfully created; otherwise <code>false</code>.
			@see <a href="http://google.com/search?q=JavaScript+window.open+documentation">JavaScript documentation for window.open</a>.
		*/
		public static function openWindow(url:String, window:String = NavigateUtils.WINDOW_BLANK, features:String = ""):Boolean {
			return (ExternalInterface.available)?ExternalInterface.call("function casaOpenWindow(url, windowOrName, features) { return window.open(url, windowOrName, features) != null; }", url, (window == NavigateUtils.WINDOW_BLANK) ? 'casaWindow' + int(1000 * Math.random()) : window, features):trace(url,window);
		}
	}

}