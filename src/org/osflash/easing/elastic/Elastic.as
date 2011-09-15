package org.osflash.easing.elastic
{
	import org.osflash.easing.IEasingFunction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Elastic
	{
		public static const EASE_IN : IEasingFunction = new EasingElasticIn();

		public static const EASE_OUT : IEasingFunction = new EasingElasticOut();

		public static const EASE_IN_OUT : IEasingFunction = new EasingElasticInOut();
	}
}
