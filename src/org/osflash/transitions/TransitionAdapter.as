package org.osflash.transitions
{
	import org.osflash.easing.IEasingFunction;
	import org.osflash.easing.linear.Linear;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class TransitionAdapter implements ITransitionAdapter
	{
		
		/**
		 * @private
		 */
		protected var start : Number;

		/**
		 * @private
		 */
		protected var end : Number;

		/**
		 * @private
		 */
		protected var change : Number;

		/**
		 * @private
		 */
		protected var easing : IEasingFunction;

		public function TransitionAdapter(	from : Number, 
											to : Number, 
											easing : IEasingFunction = null
											)
		{
			this.start = from;
			this.end = to;
			this.change = to - from;
			this.easing = easing ? easing : Linear.EASE_NONE;
		}

		/**
		 * @inheritDoc
		 */
		public function reverse() : void
		{
			const value : Number = start;
			start = end;
			end = value;
			change = end - start;
		}

		/**
		 * @inheritDoc
		 */
		public function update(time : int, duration : int) : void
		{
			throw new Error('Abstract method');
		}

		/**
		 * @inheritDoc
		 */
		public function finalise() : void
		{
			throw new Error('Abstract method');
		}

		/**
		 * @inheritDoc
		 */
		public function dispose() : void
		{
			easing = null;
		}
	}
}
