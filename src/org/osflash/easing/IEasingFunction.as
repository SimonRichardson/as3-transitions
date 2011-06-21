package org.osflash.easing
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IEasingFunction
	{
		
		function calculate(t : Number, b : Number, c : Number, d : Number) : Number;
	}
}
