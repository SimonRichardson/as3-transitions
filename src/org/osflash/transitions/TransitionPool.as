package org.osflash.transitions
{
	import flash.errors.IllegalOperationError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	internal final class TransitionPool
	{
		
		/**
		 * @private
		 */
		private var _type : Class;
		
		/**
		 * @private
		 */	
		private var _first : ITransition;

		/**
		 * @private
		 */	
		private var _growthRate : int;

		public function TransitionPool(type : Class, growthRate : int = 0x10)
		{
			if(null == type) throw new ArgumentError('Given type can not be null');
			if(isNaN(growthRate)) throw new ArgumentError('Given value should be a int');
			
			_type = type;
			_growthRate = growthRate;
		}

		public function acquire() : ITransition
		{
			if ( !_first )
			{
				var index : int = _growthRate;
				while ( --index )
				{
					_first = new _type(_first);
					if(!(_first is ITransition)) 
						throw new IllegalOperationError('Given type must be a ITransition');
				}
			}

			const transition : ITransition = _first;
			_first = transition.next;
			transition.next = null;
			transition.prev = null;
			return transition;
		}

		public function release(transition : ITransition) : void
		{
			transition.prev = null;
			transition.next = _first;

			_first = transition;
		}
	}
}
