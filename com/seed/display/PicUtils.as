package com.seed.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	/**
	 * @author Simon
	 * @version 1.1			2012.11.16
	 */
	public class PicUtils
	{
		public static const STYLE_NONE:String = "NONE";
		public static const STYLE_FITALL:String = "FITALL";
		public static const STYLE_FITIN:String = "FITIN";
		public static const STYLE_FITOUT:String = "FITOUT";
		
		public static const ALIGN_TOP:String = "T";
		public static const ALIGN_TOP_LEFT:String = "TL";
		public static const ALIGN_TOP_RIGHT:String = "TR";
		public static const ALIGN_CENTER:String = "C";
		public static const ALIGN_LEFT:String = "L";
		public static const ALIGN_RIGHT:String = "R";
		public static const ALIGN_BOTTOM:String = "B";
		public static const ALIGN_BOTTOM_LEFT:String = "BL";
		public static const ALIGN_BOTTOM_RIGHT:String = "BR";
		
		/**
		 * 從可視物件new一個Bitmap
		 * @param	img 可視物件
		 * @param	smoothing 平滑化
		 * @return
		 */
		public static function getBitmap(img:DisplayObject, w:Number, h:Number, smoothing:Boolean = false, imgTransparent:Boolean = false, bgColor:uint = 0XFFFFFF):Bitmap
		{
			var bmp:Bitmap = new Bitmap(PicUtils.getBitmapData(img,w,h,imgTransparent,bgColor), "auto", smoothing);
			return bmp;
		}
		
		/**
		 * 取可是物件的非透明區域
		 * @param	img
		 * @return  Rectangle
		 */
		public static function getOpaqueBoundsRect(img:DisplayObject):Rectangle
		{
			var bmpData:BitmapData = PicUtils.getBitmapData(img, img.width, img.height, true, 0X00000000);
			var rec:Rectangle = bmpData.getColorBoundsRect(0xFF000000, 0X00000000, false);
			bmpData.dispose();
			return rec;
		}
		
		/**
		 * 從可視物件取得bitmapdata
		 * @param	img 可視物件
		 * @param	imgTransparent 透明bitmapdata
		 * @param	bgColor 繪製背景顏色
		 * @return
		 */
		public static function getBitmapData(img:DisplayObject, w:Number, h:Number, imgTransparent:Boolean = false, bgColor:uint = 0XFFFFFF):BitmapData
		{
			var bmpData:BitmapData;
			(imgTransparent)?bmpData = new BitmapData(w, h, imgTransparent, 0):bmpData = new BitmapData(w, h, imgTransparent, bgColor);
			bmpData.draw(img);
			return bmpData;
		}
		
		/**
		 * 圖去縮放尺寸符合container
		 * @param	img
		 * @param	width container's width
		 * @param	height container's height
		 * @param	fitStyle 縮放樣式
		 * @param	align 對齊方式
		 */
		public static function fitContainer(img:DisplayObject, width:Number, height:Number, fitStyle:String = PicUtils.STYLE_NONE, align:String = PicUtils.ALIGN_TOP_LEFT):void
		{
			var imgScale:Number = img.width / img.height;
			var containerScale:Number = width / height;
			
			switch(fitStyle) {
				case PicUtils.STYLE_NONE:
					break;
				case PicUtils.STYLE_FITALL:
					img.width = width;
					img.height = height;
					break;
				case PicUtils.STYLE_FITIN:
					if (imgScale > containerScale) {
						img.scaleX = img.scaleY = width / img.width;
					}else {
						img.scaleX = img.scaleY = height / img.height;
					}
					break;
				case PicUtils.STYLE_FITOUT:
					if (imgScale > containerScale) {
						img.scaleX = img.scaleY = height / img.height;
					}else {
						img.scaleX = img.scaleY = width / img.width;
					}
					break;
			}
			
			var imgW:Number = img.width;
			var imgH:Number = img.height;
			var conW:Number = width;
			var conH:Number = height;
			
			switch(align) {
				case PicUtils.ALIGN_BOTTOM:
					img.x = (conW - imgW) / 2;
					img.y = conH - imgH;
					break;
				case PicUtils.ALIGN_BOTTOM_LEFT:
					img.x = 0;
					img.y = conH - imgH;
					break;
				case PicUtils.ALIGN_BOTTOM_RIGHT:
					img.x = conW - imgW;
					img.y = conH - imgH;
					break;
				case PicUtils.ALIGN_CENTER:
					img.x = (conW - imgW) / 2;
					img.y = (conH - imgH) / 2;
					break;
				case PicUtils.ALIGN_LEFT:
					img.x = 0;
					img.y = (conH - imgH) / 2;
					break;
				case PicUtils.ALIGN_RIGHT:
					img.x = conW - imgW;
					img.y = (conH - imgH) / 2;
					break;
				case PicUtils.ALIGN_TOP:
					img.x = (conW - imgW) / 2;
					img.y = 0;
					break;
				case PicUtils.ALIGN_TOP_LEFT:
					img.x = 0;
					img.y = 0;
					break;
				case PicUtils.ALIGN_TOP_RIGHT:
					img.x = conW - imgW;
					img.y = 0;
					break;
			}
		}
		
		/**
		 * 移除所有child
		 * @param	container
		 */
		public static function removeAll(container:DisplayObjectContainer):void
		{
			while (container.numChildren) {
				container.removeChildAt(0);
			}
		}
	}
	
}