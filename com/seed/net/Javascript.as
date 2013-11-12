package com.seed.net 
{
	import flash.external.ExternalInterface;
	/**
	 * @author Simon
	 */
	public class Javascript 
	{

		public static function callAndBack(functionName:String, callback:Function, ... param):void {
			callAndBackReturn(functionName, callback, null, param);
		}

		public static function callAndBackReturn(functionName:String, callback:Function, fakeCallback:*, ... param):void {
			addCallback(functionName, callback);
			param.unshift(functionName);
			call(functionName, param);
			if (!ExternalInterface.available) {
				callback(fakeCallback);
			}
		}
		
		public static function call(functionName:String, ... param):*
		{
			return callReturn(functionName, null, param);
		}

		public static function callReturn(functionName:String, fakeReturn:*, ... rest):* {
			if (functionName == null) { trace('javascript call functionName null'); return; }
			trace('js function call:', functionName, rest);
			if (ExternalInterface.available) {
				return ExternalInterface.call.call(null, functionName, rest);
			}
			return fakeReturn;
		}

		public static function addCallback (functionName:String, closure:Function) : void
		{
			if (functionName == null) { trace('javascript addCallback functionName null'); return; }
			if (ExternalInterface.available) {
				ExternalInterface.addCallback(functionName, closure);
			} else {
				trace('js callback added: ', functionName);
			}
		}

		public static function alert (str:String) : void {
			call("setTimeout(alert('" + str + "'),0)");
		}
	}
}