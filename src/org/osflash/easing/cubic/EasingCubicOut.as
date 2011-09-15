package org.osflash.easing.cubic 
{
	import org.osflash.easing.IEasingFunction;

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingCubicOut implements IEasingFunction
	{

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			return c * ((t = t / d - 1) * t * t + 1) + b;
		}
	}
}
