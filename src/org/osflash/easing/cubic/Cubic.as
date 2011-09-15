package org.osflash.easing.cubic
{
	import org.osflash.easing.IEasingFunction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Cubic
	{
		public static const EASE_IN : IEasingFunction = new EasingCubicIn();

		public static const EASE_OUT : IEasingFunction = new EasingCubicOut();

		public static const EASE_IN_OUT : IEasingFunction = new EasingCubicInOut();
	}
}
