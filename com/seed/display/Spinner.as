package com.seed.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.utils.getTimer;
	/**
	 * A spinning activity indicator
	 */
	public class Spinner extends Sprite
	{
		/**
		 * Rounds per second
		 */
		public var speed:Number;
		/**
		 * Afterglow (0..1)
		 */
		public var trail:Number;
		/**
		 * Opacity of the lines (0..1)
		 */
		public var opacity:Number;
		private static var dropShadowFilter:DropShadowFilter = new DropShadowFilter(2, 90, 0x000000, 1, 2, 2, 1, 2, false, false, false);
		private var _lineCount:int;
		private var _length:Number;
		private var _thickness:Number;
		private var _radius:Number;
		private var _roundness:Number;
		private var _color:uint;
		private var _shadow:Boolean;
		private var lines:Array;
		private var prevTime:int;
		private var lightPosition:Number;
		/**
		 * Create a Spinner instance
		 * @param lineCount The number of lines to draw
		 * @param length The length of each line
		 * @param thickness The line thickness
		 * @param radius The radius of the inner circle
		 * @param roundness Roundness (0..1)
		 * @param color The color of the line (0xRRGGBB)
		 * @param speed Rounds per second
		 * @param trail Afterglow (0..1)
		 * @param opacity Opacity of the lines (0..1)
		 * @param shadow Drop the shadow
		 */
		public function Spinner(lineCount:uint = 12, length:Number = 7, thickness:Number = 5, radius:Number = 10, roundness:Number = 1, color:uint = 0x000000, speed:Number = 1, trail:Number = 1, opacity:Number = 0.25, shadow:Boolean = false)
		{
			this._length = length;
			this._thickness = thickness;
			this._radius = radius;
			this._roundness = roundness;
			this._color = color;
			this._shadow = shadow;
			this.lineCount = lineCount;
			this.speed = speed;
			this.trail = trail;
			this.opacity = opacity;
			this.lightPosition = 0;
			animate(null);
		}
		/**
		 * The number of lines to draw
		 */
		public function set lineCount(value:int):void
		{
			this._lineCount = value;
			//removeChildren();
			PicUtils.removeAll(this);
			lines = [];
			for(var i:int=0; i<value; ++i)
			{
				lines.push(addChild(new Line));
				Line(lines[i]).rotation = 360/value*i;
			}
			update();
		}
		public function get lineCount():int
		{
			return this._lineCount;
		}
		/**
		 * The length of each line
		 */
		public function set length(value:Number):void
		{
			this._length = value;
			update();
		}
		public function get length():Number
		{
			return this._length;
		}
		/**
		 * The line thickness
		 */
		public function set thickness(value:Number):void
		{
			this._thickness = value;
			update();
		}
		public function get thickness():Number
		{
			return this._thickness;
		}
		/**
		 * The radius of the inner circle
		 */
		public function set radius(value:Number):void
		{
			this._radius = value;
			update();
		}
		public function get radius():Number
		{
			return this._radius;
		}
		/**
		 * Roundness (0..1)
		 */
		public function set roundness(value:Number):void
		{
			this._roundness = value;
			update();
		}
		public function get roundness():Number
		{
			return this._roundness;
		}
		/**
		 * The color of the line (0xRRGGBB)
		 */
		public function set color(value:uint):void
		{
			this._color = value;
			update();
		}
		public function get color():uint
		{
			return this._color;
		}
		/**
		 * Drop the shadow
		 */
		public function set shadow(value:Boolean):void
		{
			this._shadow = value;
			update();
		}
		public function get shadow():Boolean
		{
			return this._shadow;
		}
		/**
		 * Start spin
		 */
		public function spin():void
		{
			prevTime = getTimer();
			addEventListener(Event.ENTER_FRAME, animate);
		}
		/**
		 * Pause spin
		 */
		public function pause():void
		{
			removeEventListener(Event.ENTER_FRAME, animate);
		}
		private function animate(e:Event):void
		{
			var currentTime:int = getTimer();
			for(var i:int=1; i<_lineCount; ++i)
				Line(lines[int(i+lightPosition*_lineCount)%_lineCount]).alpha = trail==0?opacity:Math.max(i/_lineCount-1+trail, 0)/trail*(1-opacity)+opacity;
			Line(lines[int(lightPosition*_lineCount)%_lineCount]).alpha = 1;
			lightPosition = (lightPosition+(currentTime-prevTime)*speed*0.001)%1;
			prevTime = currentTime;
			update();
		}
		private function update():void
		{
			var line:Line;
			var lineCount:int = this.lines.length;
			for(var i:int=0; i<lineCount; ++i)
			{
				line = lines[i];
				line.length = _length;
				line.thickness = _thickness;
				line.radius = _radius;
				line.roundness = _roundness;
				line.color = _color;
				line.filters = _shadow?[dropShadowFilter]:null;
				line.update();
			}
		}
	}
}
import flash.display.Shape;
internal class Line extends Shape
{
	public var length:Number;
	public var thickness:Number;
	public var radius:Number;
	public var roundness:Number;
	public var color:uint;
	public function Line()
	{
	}
	public function update():void
	{
		var ellipseRadius:Number = roundness*thickness;
		graphics.clear();
		graphics.beginFill(color);
		graphics.drawRoundRect(radius, -thickness*0.5, length+thickness, Math.max(ellipseRadius, thickness), ellipseRadius, ellipseRadius);
	}
}