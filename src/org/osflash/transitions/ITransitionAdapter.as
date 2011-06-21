package org.osflash.transitions
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface ITransitionAdapter
	{
		
		function reverse() : void;

		function update(time : int, duration : int) : void;

		function finalise() : void;
		
		function dispose() : void;
	}
}
