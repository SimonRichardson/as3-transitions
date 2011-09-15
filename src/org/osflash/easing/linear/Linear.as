package org.osflash.easing.linear
{
	import org.osflash.easing.IEasingFunction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Linear
	{
		
		public static const EASE_NONE : IEasingFunction = new EasingLinear();
		
		public static const EASE_IN : IEasingFunction = new EasingLinear();
		
		public static const EASE_OUT : IEasingFunction = new EasingLinear();
		
		public static const EASE_IN_OUT : IEasingFunction = new EasingLinear();
	}
}
