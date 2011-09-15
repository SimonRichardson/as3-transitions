package org.osflash.easing.cubic 
{
	import org.osflash.easing.IEasingFunction;

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingCubicIn implements IEasingFunction
	{

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			return c * (t /= d) * t * t + b;
		}
	}
}
