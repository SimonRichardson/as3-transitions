package org.osflash.easing
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class EasingLinear implements IEasingFunction 
	{
		
		/**
		 * @inheritDoc
		 */
		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			return t * c / d + b;
		}
	}
}
