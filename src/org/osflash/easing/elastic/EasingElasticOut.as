package org.osflash.easing.elastic 
{
	import org.osflash.easing.IEasingFunction;

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingElasticOut implements IEasingFunction
	{

		private static const MULTIPLY_PI_2 : Number = 2 * Math.PI;

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			if (t == 0) return b;
			if ((t /= d) == 1) return b + c;
			  
			const p : Number = d * .3;
			const s : Number = p / 4;
			
			return (c * Math.pow(2, -10 * t) * Math.sin((t * d - s) * MULTIPLY_PI_2 / p) + c + b);
		}
	}
}
