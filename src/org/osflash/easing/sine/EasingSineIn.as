package org.osflash.easing.sine 
{
	import org.osflash.easing.IEasingFunction;

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingSineIn implements IEasingFunction
	{

		private static const DIVIDE_PI_2 : Number = Math.PI / 2;

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			return -c * Math.cos(t / d * DIVIDE_PI_2) + c + b;
		}
	}
}
