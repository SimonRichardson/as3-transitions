package org.osflash.easing.sine
{
	import org.osflash.easing.IEasingFunction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Sine
	{
		public static const EASE_IN : IEasingFunction = new EasingSineIn();

		public static const EASE_OUT : IEasingFunction = new EasingSineOut();

		public static const EASE_IN_OUT : IEasingFunction = new EasingSineInOut();
	}
}
