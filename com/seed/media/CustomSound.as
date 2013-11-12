package com.seed.media 
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin; 
	import com.greensock.plugins.SoundTransformPlugin;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @version 1.0.1
	 * @author Simon
	 */
	public class CustomSound extends Sound 
	{
		private var _isSoundOn:Boolean = false;
		private var _tempVolume:Number;
		
		private var _soundChannel:SoundChannel;
		private var _maxVolume:Number = 1.0;
		private var _isPlay:Boolean = false;
		public function CustomSound(stream:String = null, isPlay:Boolean = false, maxVolume:Number = 1.0, context:SoundLoaderContext = null)
		{
			var request:URLRequest;
			_maxVolume = maxVolume;
			if (stream != null) request = new URLRequest(stream);
			super(new URLRequest(stream), context);
			if (isPlay) soundInit();
			_isPlay = isPlay;
		}
		
		private function soundInit():void
		{
			_isSoundOn = true;
			_soundChannel = this.play(0, int.MAX_VALUE);
			TweenPlugin.activate([SoundTransformPlugin]);
			TweenLite.to(_soundChannel, 0, { soundTransform: { volume:_maxVolume }} );
		}
		
		/**
		 * turn on and off
		 * @param	time
		 * @param	onFadeIn
		 * @param	onFadeOut
		 * @param	onFadeInComplete
		 * @param	onFadeOutComplete
		 */
		public function turnOnOff(time:Number = 1.0, onFadeIn:Function = null, onFadeOut:Function = null, onFadeInComplete:Function = null, onFadeOutComplete:Function = null):void
		{
			if (!_isPlay) {
				_isPlay = true;
				soundInit();
				onFadeIn();
				return;
			}
			_isSoundOn = !_isSoundOn;
			_tempVolume = (_isSoundOn)?_maxVolume:0;
			var onStartFunction:Function = (_isSoundOn)?onFadeIn:onFadeOut;
			var onCompleteFunction:Function = (_isSoundOn)?onFadeInComplete:onFadeOutComplete;
			TweenLite.to(_soundChannel, time, { soundTransform: { volume:_tempVolume}, onStart:onStartFunction, onComplete:onCompleteFunction } );
		}
		
		public function playMusic():void
		{
			_isSoundOn = true;
			_soundChannel = this.play(0, int.MAX_VALUE);
		}
		
		public function stop():void
		{
			_isSoundOn = false;
			if (_soundChannel) _soundChannel.stop();
		}
		
//=====================================================Get isSoundOn================================================
		/**
		 * isSoundOn read only
		 */
		public function get isSoundOn():Boolean
		{
			return _isSoundOn;
		}

//====================================================Get&Set Volume====================================================
		/**
		 * 
		 */
		public function get volume():Number
		{
			return _tempVolume;
		}
		
		public function set volume(vol:Number):void
		{
			if (!_isPlay) {
				_isPlay = true;
				soundInit();
			}
			TweenLite.to(_soundChannel, 0, { soundTransform: { volume:vol }} );
			_tempVolume = vol;
			_isSoundOn = (vol == 0)?false:true;
		}
	}

}