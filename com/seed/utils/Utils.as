package com.seed.utils
{
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * ...
	 * @author georgelynch
	 */
	public class Utils extends MovieClip
	{
		// ----------------------------------------------------------------------------------------------------------------------------
		// - PRIVATE & PROTECTED VARIABLES
		// ----------------------------------------------------------------------------------------------------------------------------
		protected static const WINDOW_OPEN_FUNCTION : String = "window.open";
		// ----------------------------------------------------------------------------------------------------------------------------
		// - PUBLIC & INTERNAL VARIABLES
		// ----------------------------------------------------------------------------------------------------------------------------
		public static const WINDOW_TARGET_BLANK : String = "_blank";
		public static const WINDOW_TARGET_NEW : String = "_new";
		public static const WINDOW_TARGET_SELF : String = "_self";

		// ----------------------------------------------------------------------------------------------------------------------------
		// - CONSTRUCTOR
		// ----------------------------------------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------------------------------------------
		// - OVERRIDE METHODS
		// ----------------------------------------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------------------------------------------
		// - PRIVATE & PROTECTED METHODS
		// ----------------------------------------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------------------------------------------
		// - PUBLIC & INTERNAL METHODS
		// ----------------------------------------------------------------------------------------------------------------------------
		// ============================================================================================================================
		public static function alert(s : *) : void
		// ============================================================================================================================
		{
			trace(s);
			var str:String = s.toString();
			if (ExternalInterface.available) {
				ExternalInterface.call(Alert.message, str);
			}
			
		}

		/**
		 * Open a new browser window and prevent browser from blocking it.
		 *
		 * @param url        url to be opened
		 * @param window     window target, WINDOW_TARGET_BLANK ,WINDOW_TARGET_SELF
		 * @param features   additional features for window.open function
		 */
		// ============================================================================================================================
		public static function openWindow(url : String, window : String = Utils.WINDOW_TARGET_BLANK, features : String = "") : void
		// ============================================================================================================================
		{
			if (!ExternalInterface.available) {
				trace(url, window);
				navigateToURL(new URLRequest(url), window);
				return;
			}
			
			var browserName : String = getBrowserName();
			
			if (getBrowserName() == "Firefox")
			{
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			// If IE,
			else if (browserName == "IE")
			{
				ExternalInterface.call("function setWMWindow() {window.open('" + url + "','" + window + "');}");
				//ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			// If Safari
			else if (browserName == "Safari")
			{
				navigateToURL(new URLRequest(url), window);
				//navigateToURL(myurl, "_self");
			}
			// If Opera
			else if (browserName == "Opera")
			{
				navigateToURL(new URLRequest(url), window);
			}
			// Otherwise, use Flash's native 'navigateToURL()' function to pop-window.
			// This is necessary because Safari 3 no longer works with the above ExternalInterface work-a-round.
			else
			{
				navigateToURL(new URLRequest(url), window);
			}
		}

		// ----------------------------------------------------------------------------------------------------------------------------
		// - EVENT HANDLERS
		// ----------------------------------------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------------------------------------------
		// - GETTERS & SETTERS
		// ----------------------------------------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------------------------------------------
		// - HELPERS
		// ----------------------------------------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------------------------------------------
		// - END CLASS
		// ----------------------------------------------------------------------------------------------------------------------------
		// - EVENT HANDLERS ---------------------------------------------------------------------------------------------
		// - GETTERS & SETTERS -------------------------------------------------------------------------------------------
		// - HELPERS ---------------------------------------------------------------------------------------------------------
		/**
		 * return current browser name.
		 */
		// ============================================================================================================================
		public static function getBrowserName() : String
		// ============================================================================================================================
		{
			var browser : String;

			// Uses external interface to reach out to browser and grab browser useragent info.
			var browserAgent : String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");

			// Determines brand of browser using a find index. If not found indexOf returns (-1).
			if (browserAgent != null && browserAgent.indexOf("Firefox") >= 0)
			{
				browser = "Firefox";
			}
			else if (browserAgent != null && browserAgent.indexOf("Safari") >= 0)
			{
				if (browserAgent.indexOf("Chrome") >= 0) {
					browser = "Chrome";
				}else {
					browser = "Safari";
				}
			}
			else if (browserAgent != null && browserAgent.indexOf("MSIE") >= 0)
			{
				browser = "IE";
			}
			else if (browserAgent != null && browserAgent.indexOf("Opera") >= 0)
			{
				browser = "Opera";
			}
			else
			{
				browser = "Undefined";
			}
			return (browser);
		}
		// - END CLASS ------------------------------------------------------------------------------------------------------
	}
}
class Alert
{
	public static var message : XML = new XML(<script>
			<![CDATA[			
				function (pMsg) {
					setTimeout("alert('" + pMsg + "')", 0)
					return false;
				}
			]]>
		</script>);
}