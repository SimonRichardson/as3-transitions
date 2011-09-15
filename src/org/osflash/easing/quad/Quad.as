package org.osflash.easing.quad
{
	import org.osflash.easing.IEasingFunction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Quad
	{
		public static const EASE_IN : IEasingFunction = new EasingQuadIn();

		public static const EASE_OUT : IEasingFunction = new EasingQuadOut();

		public static const EASE_IN_OUT : IEasingFunction = new EasingQuadInOut();
	}
}
