package org.osflash.transitions
{
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface ITransition
	{
		
		function start() : void;

		function stop() : void;

		function pause() : void;

		function resume() : void;

		function reverse() : void;
		
		function dispose() : void;
		
		function get startTime() : Number;
		
		function get elapsed() : Number;
		
		function get duration() : Number;
		function set duration(value : Number) : void;
		
		function get delay() : int;
		function set delay(value : int) : void;
		
		function get runOnce() : Boolean;
		function set runOnce(value : Boolean) : void;

		function get property() : Property;
		function set property(value : Property) : void;
		
		function get state() : TransitionState;
		function set state(value : TransitionState) : void;
		
		function get rendering() : Boolean;
		function set rendering(value : Boolean) : void;
		
		function get next() : ITransition;
		function set next(value : ITransition) : void;
		
		function get prev() : ITransition;
		function set prev(value : ITransition) : void;
		
		function get startSignal() : ISignal;
		
		function get stopSignal() : ISignal;
		
		function get pauseSignal() : ISignal;
		
		function get resumeSignal() : ISignal;
		
		function get updatedSignal() : ISignal;
		
		function get completedSignal() : ISignal;
		
		function get isUpdatedSignalActive() : Boolean;
		function get isCompletedSignalActive() : Boolean;
	}
}
