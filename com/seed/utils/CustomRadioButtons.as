package com.seed.utils 
{
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	/**
	 * @author georgelynch
	 * new CustomRadioButtons( [ {value:"空氣柔束", button:radioA_btn} , {value:"絲絲直順", button:radioB_btn},{value:"蓬鬆波浪", button:radioC_btn} ] );
	 */
	public class CustomRadioButtons extends MovieClip 
	{
		//- PRIVATE & PROTECTED VARIABLES --------------------------------------------------------------------------
		private var _onClickHandler : Function;
		private var _buttons : Object;
		private var _value : String = "";

		//- PUBLIC & INTERNAL VARIABLES ------------------------------------------------------------------------------
		//- CONSTRUCTOR ------------------------------------------------------------------------------------------------
		public function CustomRadioButtons(PButtons : Array)
		{
			_buttons = PButtons;
			setbuttons( );
			_onClickHandler = function():void
			{
			};
		}

		//- OVERRIDE METHODS ------------------------------------------------------------------------------------------
		//- PRIVATE & PROTECTED METHODS ---------------------------------------------------------------------------
		private function setbuttons() : void 
		{
			for (var i : int = 0; i < _buttons.length; i ++) 
			{
				$( _buttons[i].button ).autoOverOut( true );
				_buttons[i].button.addEventListener( MouseEvent.CLICK , onClickHandler );
			}
		}

		private function allButtonsBack() : void 
		{
			for (var i : int = 0; i < _buttons.length; i ++) 
			{
				_buttons[i].button.gotoAndStop( 1 );
				$( _buttons[i].button ).autoOverOut( true );
				if(! _buttons[i].button.hasEventListener( MouseEvent.CLICK ))_buttons[i].button.addEventListener( MouseEvent.CLICK , onClickHandler );
			}
		}

		//- PUBLIC & INTERNAL METHODS -------------------------------------------------------------------------------
		//- EVENT HANDLERS ---------------------------------------------------------------------------------------------
		private function onClickHandler(event : MouseEvent) : void 
		{
			allButtonsBack( );
			for (var i : int = 0; i < _buttons.length; i ++) 
			{
				
				if(event.currentTarget == _buttons[i].button)
				{
					_buttons[i].button.gotoAndStop( 2 );
					$( _buttons[i].button ).autoOverOut( false );
					_buttons[i].button.removeEventListener( MouseEvent.CLICK , onClickHandler );
					_value = _buttons[i].value;
					_onClickHandler( );
					trace( _value );
				}
			}
		}

		public function get value() : String
		{
			return _value;
		}

		public function setOnClickHandler(onClickHandler : Function) : void
		{
			_onClickHandler = onClickHandler;
		}

		public function setDefaultValue(pValue : String) : void
		{
			for (var i : int = 0; i < _buttons.length; i ++) 
			{
				trace( '_buttons[i].value: ' + (_buttons[i].value) );
				if(_buttons[i].value == pValue)
				{
					
					_buttons[i].button.gotoAndStop( 2 );
					$( _buttons[i].button ).autoOverOut( false );
					_buttons[i].button.removeEventListener( MouseEvent.CLICK , onClickHandler );
					_value = _buttons[i].value;
					_onClickHandler( );
				}
			}
		}

		
		//- GETTERS & SETTERS -------------------------------------------------------------------------------------------
		//- HELPERS ---------------------------------------------------------------------------------------------------------
		//- END CLASS ------------------------------------------------------------------------------------------------------
	}
}
