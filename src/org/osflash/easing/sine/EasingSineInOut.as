package org.osflash.easing.sine 
{
	import org.osflash.easing.IEasingFunction;

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingSineInOut implements IEasingFunction
	{

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			if ((t /= d / 2) < 1) return c / 2 * t * t + b;
			return -c / 2 * ((--t) * (t - 2) - 1) + b;
		}
	}
}
