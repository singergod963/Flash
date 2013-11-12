package com.seed.facebook 
{
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author Simon
	 */
	public class FB 
	{
		private static var _instance:FB;
		
		public static const GetSelfInfoFql:String = "SELECT uid, name, pic_square FROM user WHERE uid = me()";
		public static const GetFriendListFql:String = "SELECT uid, name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())";
		public function FB(sSingleton:Singleton)
		{
			if(sSingleton==null)throw new Error("請使用類別方法getInstance");
		}
		
		public static function getInstance():FB
		{
			if (_instance == null) _instance = new FB(new Singleton());
			
			return _instance;
		}
		
		public static function get accessToken():String
		{
			if (ExternalInterface.available) {
				return ExternalInterface.call("FB.getAccessToken");
			}else {
				return "";
			}
		}
		
		public static function get signedRequest():String
		{
			if (ExternalInterface.available) {
				return ExternalInterface.call("FB.getAuthResponse").signedRequest;
			}else {
				return "";
			}
		}
		
		public static function get useID():String
		{
			if (ExternalInterface.available) {
				return ExternalInterface.call("FB.getAuthResponse").userID;
			}else {
				return "";
			}
		}
		
	}
}

class Singleton{}