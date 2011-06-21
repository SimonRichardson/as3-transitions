package org.osflash.transitions
{
	import flash.errors.IllegalOperationError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class PropertyPool
	{
		
		/**
		 * @private
		 */
		private var _type : Class;
		
		/**
		 * @private
		 */
		private var _first : Property;

		/**
		 * @private
		 */
		private var _growthRate : int;

		public function PropertyPool(type : Class, growthRate : int = 0x10)
		{
			if(null == type) throw new ArgumentError('Given type can not be null');
			if(isNaN(growthRate)) throw new ArgumentError('Given value should be a int');
			
			_type = type;
			_growthRate = growthRate;
		}
		
		public function acquire() : Property
		{
			if (!_first)
			{
				var index : int = _growthRate;
				while ( --index )
				{
					_first = new _type(_first);
					if(!(_first is Property)) 
						throw new IllegalOperationError('Given type must be a Property');
				}
			}

			const property : Property = _first;
			_first = property.next;
			property.next = null;
			return property;
		}

		public function release(property : Property) : void
		{
			property.next = _first;
			_first = property;
		}
	}
}
