package org.osflash.easing.quad 
{
	import org.osflash.easing.IEasingFunction;

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingQuadIn implements IEasingFunction
	{

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			return c * (t /= d) * t + b;
		}
	}
}
