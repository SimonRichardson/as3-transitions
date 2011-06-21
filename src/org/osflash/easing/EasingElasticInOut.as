package org.osflash.easing 
{

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingElasticInOut implements IEasingFunction
	{

		private static const MULTIPLY_PI_2 : Number = 2 * Math.PI;

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			if (t == 0) return b;
			if ((t /= d / 2) == 2) return b + c;
			  
			const p : Number = d * (.3 * 1.5);
			const s : Number = p / 4; 
			
			if (t < 1) return -.5 * (c * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * MULTIPLY_PI_2 / p)) + b;
			return c * Math.pow(2, -10 * (t -= 1)) * Math.sin((t * d - s) * MULTIPLY_PI_2 / p) * .5 + c + b;
		}
	}
}
