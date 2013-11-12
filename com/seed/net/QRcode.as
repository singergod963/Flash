package com.seed.net
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class QRcode extends Sprite
	{
		private var _loader:Loader;
		public function QRcode(qrUrl:String, qrSize:int)
		{
			_loader = new Loader();
			var _loadStr:String = "http://chart.apis.google.com/chart?cht=qr&chl=" + qrUrl + "&chs=" + qrSize + "x" + qrSize;
			_loader.load(new URLRequest(_loadStr));
			addChild(_loader);
		}
		
		public static function getQRcode(qrUrl:String, qrSize:int):Loader {
			var _loader:Loader = new Loader();
			var _loadStr:String = "http://chart.apis.google.com/chart?cht=qr&chl=" + qrUrl + "&chs=" + qrSize + "x" + qrSize;
			_loader.load(new URLRequest(_loadStr));
			return _loader;
		}
	}
	
}