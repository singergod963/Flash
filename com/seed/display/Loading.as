package com.seed.display 
{
	import com.seed.display.Spinner;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class Loading extends Sprite 
	{
		private var _color:uint = 0XFFFFFF;
		private var _spinner:Spinner;
		private var _txt:TextField;
		public function Loading(color:uint = 0XFFFFFF) 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			
			this._color = color;
			
			_spinner = new Spinner(17, 7, 2, 13, 1, _color, 2, 1, 0.25, false);
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.size = 14;
			format.align = "center";
			format.color = this._color;
			
			_txt = new TextField();
			_txt.width = 40;
			_txt.height = 24;
			_txt.x = -21;
			_txt.y = -11;
			_txt.defaultTextFormat = format;
			
		}
		
		private function removeHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			if (_spinner) _spinner.pause();
		}
		
		private function initHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initHandler);
			
			addChild(_txt);
			addChild(_spinner);
			_spinner.spin();
		}
		
		public function loadingText(loaded:Number, total:Number):void
		{
			_txt.text = (Math.floor(loaded / total * 100)).toString();
		}
		
		public function get text():String
		{
			return _txt.text;
		}
		
		public function set text(s:String):void
		{
			_txt.text = s;
		}
		
		public function get color():uint
		{
			return this._color;
		}
		
		public function set color(n:uint):void
		{
			_txt.textColor = n;
			_spinner.color = n;
		}
	}

}