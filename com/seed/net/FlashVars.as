package com.seed.net
{
	import com.adobe.serialization.json.JSON;
	import f.events.LoadEvent;
	import f.net.Load;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author Simon
	 */
	public dynamic class FlashVars
	{
		public static var _FlashVars:FlashVars = null;
		
		// 是否在 FlashIDE 環境
		public var IsStandalone:Boolean = false;
		
		public function FlashVars(stage:DisplayObject)
		{
			var vars:Object = stage.loaderInfo.parameters;	
			for (var i:String in vars) {
				this[i] = ensureType(vars[i]);
			}
			var me:FlashVars = this;
			if (!IsInHtml) {
				me.IsStandalone = true;
				Load.json(
					"FlashVars.config",
					function(e:LoadEvent):void { 
						if ( e.type == LoadEvent.SUCCESS) {
							for (var i:String in e.data) {
								me[i] = ensureType(e.data[i]);
							}
							trace("FlashVars.config loaded.");
						}
						me.IsStandalone = true;
					},
					{method:"get"}
				);
			}
		}
		
		/**
		 * Initialize the FlashVars
		 * @param	stage
		 */
		public static function init(stage:DisplayObject):FlashVars
		{
			return Get(stage);
		}

		/**
		 * Get FlashVars Instance
		 * @param	stage	can be null after initialize
		 */
		public static function Get(stage:DisplayObject=null):FlashVars {
			if (_FlashVars == null) {
				if (stage == null) {
					throw Error("need to init or stage is null.");
				}
				_FlashVars = new FlashVars(stage);
			}
			return _FlashVars;
		}

		/**
		 * flash instance is embed in html or not
		 */
		public static function get IsInHtml():Boolean {
			try{
				var o:* = ExternalInterface.call("String", "test");
				return ("" + o == "test");
			} catch (e:Object){
				return false;
			}
			return false;
		}
		
		
		/**
		 * Set class level settings
		 * @param	mc	the class level settings you want to get about the MovieClip
		 */
		public function Set(mc:MovieClip, hasOwnPropertyOnly:Boolean = true):* {
			var o:Object = Get(mc);
			for (var i:String in o) {
				if (mc.hasOwnProperty(i)) {
					try {
						mc[i] = o[i];
					} catch (e:Error) { 
						trace("FlashVar Set error", getClassSettingName(mc), e.message);
					}
				}
			}
		}

		/**
		 * Get class level settings
		 * @param	mc	the class level settings you want to get about the MovieClip
		 */
		public function Get(mc:MovieClip):* {
			var o:* = this[getClassSettingName(mc)];
			return (o === undefined) ? { } : o;
		}

		private static function getClassSettingName(obj:Object):String {
			var cls:Class = Class(getDefinitionByName(getQualifiedClassName(obj)))
			var clsName:String = String(cls).replace(/^\[class _*|\d*\]$/ig, '');
			return clsName;
		}

		private static function ensureType(s:String):* {
			//轉換成相對型別
			var i:int = int(s);
			var d:Number = Number(s);

			if (/^\[.*\]$/g.test(s) || /^\{.*\}$/g.test(s)) {
				try {
					var o:Object = com.adobe.serialization.json.JSON.decode(s);
					return o;
				} catch (e:Error) {
					trace("FlashVars property parse error:", e.message, s);
				}
			}
			else if (/^(true|false)$/i.test(s)) {
				return "false" != s;
			}
			return (i.toString() === s) 
					? i 
					: (d.toString() === s)
						? d
						: s;
		}
		
	}

}