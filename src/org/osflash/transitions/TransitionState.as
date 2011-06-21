package org.osflash.transitions
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class TransitionState
	{

		public static const RUNNING : TransitionState = new TransitionState(0x01);

		public static const PAUSE : TransitionState = new TransitionState(0x02);

		public static const STOP : TransitionState = new TransitionState(0x03);

		public static const COMPLETE : TransitionState = new TransitionState(0x04);
		
		private var _state : int;

		public function TransitionState(state : int)
		{
			_state = state;
		}
		
		/**
		 * Returns the string representation of the state
		 */
		public static function stateToString(state : int) : String
		{
			switch(state)
			{
				case RUNNING.state:
					return "running";
				case PAUSE.state:
					return "pause";
				case STOP.state:
					return "stop";
				case COMPLETE.state:
					return "complete";
				default:
					throw new ArgumentError("Unknown state");
			}
		}

		public function get state() : int {	return _state; }
	}
}
