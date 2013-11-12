package com.seed.text 
{
	import flash.events.FocusEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Simon
	 */
	public class TextUtil 
	{
		private static var _textList:Array;
		
		/**
		 * setDefaultText
		 * @param	txt 				TextField
		 * @param	defaultSetting		default settings { text:"default word", textColor:0X000000}
		 * @param	changeSetting		default settings { text:"", textColor:0X000000}
		 */
		public static function setDefaultText(txt:TextField, defaultSetting:Object=null,changeSetting:Object=null):void
		{
			if (defaultSetting) {
				if (defaultSetting.text) txt.text = defaultSetting.text;
				if (defaultSetting.textColor) txt.textColor = defaultSetting.textColor;
			}
			
			if (!_textList) _textList = new Array();
			var changeFunction:Function = function(e:FocusEvent):void {
				txt.removeEventListener(FocusEvent.FOCUS_IN, changeFunction);
				if (changeSetting) {
					if (changeSetting.textColor!=null)txt.textColor = changeSetting.textColor;
					(changeSetting.text)?txt.text = changeSetting.text:txt.text = "";
				}else {
					txt.text = "";
				}
			};
			txt.addEventListener(FocusEvent.FOCUS_IN, changeFunction);
			_textList.push( { txt:txt, defaultSetting:defaultSetting, changeSetting:changeSetting, func:changeFunction } );
		}
		
		/**
		 * disposeDefault
		 * @param	txt TextField
		 */
		public static function disposeDefault(txt:TextField):void
		{
			var len:int = _textList.length;
			for (var i:int = 0; i < len; i++) {
				if (_textList[i].txt == txt) {
					_textList[i].txt.removeEventListener(FocusEvent.FOCUS_IN, _textList[i].func);
					_textList.splice(i, 1);
				}
			}
		}
		
		/**
		 * disposeDefaultAll
		 */
		public static function disposeDefaultAll():void
		{
			var len:int = _textList.length;
			for (var i:int = 0; i < len; i++) {
				_textList[i].txt.removeEventListener(FocusEvent.FOCUS_IN, _textList[i].func);
			}
			_textList = null;
		}
	}

}