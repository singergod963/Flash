package com.seed.net 
{
	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.common.BitMatrix;
	import com.google.zxing.qrcode.QRCodeWriter;
	import com.google.zxing.Reader;
	import com.google.zxing.Result;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Simon
	 */
	public class QrcodeGenerator
	{
		public static function generate(code:String, length:Number = 100, fgColor:uint = 0XFF000000, bgColor:uint = 0xFFFFFFFF):Bitmap
		{
			var imgWidth:int = length;
			var imgHeight:int = length;
			var writer:QRCodeWriter = new QRCodeWriter();
			
			try {
				var result:BitMatrix = writer.encode(code, BarcodeFormat.QR_CODE, imgWidth, imgHeight) as BitMatrix;
			}catch (e:*) {
				trace(e.message);
			}
			
			var resultBits:Array = new Array(result.getWidth());
			for (var i:int=0;i<result.getWidth();i++)
            {
            	resultBits[i] = result._get(i,0);
            }
			
			var bmpd:BitmapData = new BitmapData(imgWidth, imgHeight, true, 0XFF000000);
            var bmp:Bitmap = new Bitmap(bmpd);            	
			var whitepixel:Boolean;
			
			for (var h:int=0;h<bmpd.height;h++)
            {
           		for (var w:int=0;w<imgWidth;w++)
           		{
	           		whitepixel = (result._get(w, h) == 0);
	           			
					if (whitepixel)
	           		{
	           			// white pixel
	           			bmpd.setPixel32(w, h, bgColor);
	           		}else{
	           			// black pixel
	           			bmpd.setPixel32(w, h, fgColor);
           			}		
           		}
           	}
			
			return bmp;
		}
	}

}