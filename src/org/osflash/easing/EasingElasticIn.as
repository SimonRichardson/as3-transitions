package org.osflash.easing 
{

	/**
	 * @author Simon Richardson me@simonrichardson.info
	 */
	public final class EasingElasticIn implements IEasingFunction
	{

		public function calculate(t : Number, b : Number, c : Number, d : Number) : Number
		{
			if (t == 0) return b;
			if ((t /= d) == 1) return b + c;
			
			const p : Number = d * .3;
			const s : Number = p / 4;
			
			return -(c * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
		}
	}
}
