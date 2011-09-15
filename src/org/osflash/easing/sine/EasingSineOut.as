package org.osflash.easing.sine 
{
	import org.osflash.easing.IEasingFunction;

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingSineOut implements IEasingFunction
	{

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			return -c * (t /= d) * (t - 2) + b;
		}
	}
}
