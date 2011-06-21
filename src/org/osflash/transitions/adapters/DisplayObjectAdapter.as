package org.osflash.transitions.adapters
{
	import org.osflash.easing.IEasingFunction;
	import org.osflash.transitions.TransitionAdapter;

	import flash.display.DisplayObject;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class DisplayObjectAdapter extends TransitionAdapter
	{

		/**
		 * @private
		 */
		protected var target : DisplayObject;

		public function DisplayObjectAdapter(	target : DisplayObject, 
												from : Number, 
												to : Number, 
												easing : IEasingFunction = null
												)
		{
			super(from, to, easing);

			this.target = target;
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose() : void
		{
			target = null;
			
			super.dispose();
		}
	}
}
