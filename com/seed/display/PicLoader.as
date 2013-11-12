package com.seed.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	/**
	 * @author Simon
	 * @version 1.1
	 */
	public class PicLoader extends Loader 
	{
		private var _imgSrc				:String = "";
		private var _callback			:Function;
		private var _container			:DisplayObjectContainer;
		public var smoothing			:Boolean = false;;
		
		/**
		 * constructor
		 * 建構式
		 * 
		 * @param	imgSrc 
		 * 圖的路徑假如沒傳就不load圖
		 * 
		 * @param	container
		 * 要加入的parent
		 * 
		 * @param   x
		 * x座標
		 * 
		 * @param   y
		 * y座標
		 * 
		 * @param   smoothing
		 * smoothing
		 * 
		 * @param	callback function
		 * load圖完成的回傳function
		 * 
		 */
		public function PicLoader(imgSrc:String = "", container:DisplayObjectContainer = null,posX:Number=0,posY:Number=0, smoothing:Boolean=false, callback:Function = null)
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			if (imgSrc != "") loadPic(imgSrc, container, posX, posY, smoothing, callback);
		}
		
		private function removeHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
			
		}
		
		private function initHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initHandler);
			
		}
		
		/**
		 * load pic
		 * @param	imgSrc 
		 * 圖的路徑
		 * 
		 * @param	container
		 * 要加入的parent
		 * 
		 * @param   x
		 * x座標
		 * 
		 * @param   y
		 * y座標
		 * 
		 * @param   smoothing
		 * smoothing
		 * 
		 * @param	callback function
		 * load圖完成的回傳function
		 * 
		 * 
		 */
		public function loadPic(imgSrc:String = "", container:DisplayObjectContainer = null,posX:Number=0,posY:Number=0, smoothing:Boolean=false, callback:Function = null):void
		{
			_imgSrc = imgSrc;
			_callback = callback;
			_container = container;
			x = posX;
			y = posY;
			this.smoothing = smoothing;
			
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicloadComplete);
			this.load(new URLRequest(imgSrc), new LoaderContext(true));
		}
		
		private function onPicloadComplete(e:Event):void 
		{
			this.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPicloadComplete);
			if (this.smoothing) {
				var bmp:Bitmap = this.content as Bitmap;
				bmp.smoothing = this.smoothing;
			}
			if (_container != null) _container.addChild(this);
			if (_callback != null) _callback();
			atPicloadComplete();
		}
		
		protected function atPicloadComplete():void
		{
			
		}
		
		public function get bitmapData():BitmapData
		{
			var bmp:Bitmap = this.content as Bitmap;
			return bmp.bitmapData;
		}
		
		public function loadPicData(bytes:ByteArray, container:DisplayObjectContainer = null,posX:Number=0,posY:Number=0, smoothing:Boolean=false, callback:Function = null):void
		{
			_callback = callback;
			_container = container;
			x = posX;
			y = posY;
			this.smoothing = smoothing;
			
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, onPicloadComplete);
			this.loadBytes(bytes);
		}
	}
	
}