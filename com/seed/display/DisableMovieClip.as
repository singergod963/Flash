package  com.seed.display
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class DisableMovieClip extends MovieClip 
	{
		
		public function DisableMovieClip() 
		{
			super();
			mouseChildren = false;
			mouseEnabled = false;
		}
		
	}

}