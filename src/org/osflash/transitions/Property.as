package org.osflash.transitions
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class Property
	{
		private static const _propertyPool : PropertyPool = new PropertyPool(Property);
		
		/**
		 * @private
		 */
		private var _next : Property;
		
		/**
		 * @private
		 */
		private var _adapter : ITransitionAdapter;

		public function Property(next : Property)
		{
			this.next = next;
		}

		public static function create(	adapter : ITransitionAdapter, 
										next : Property = null
										) : Property
		{
			const property : Property = _propertyPool.acquire();
			property.adapter = adapter;
			property.next = next;

			return property;
		}

		public function dispose() : void
		{
			if (next) next.dispose();

			adapter.dispose();

			_propertyPool.release(this);
		}

		public function get next() : Property { return _next; }
		public function set next(value : Property) : void { _next = value; }

		public function get adapter() : ITransitionAdapter { return _adapter; }
		public function set adapter(value : ITransitionAdapter) : void { _adapter = value; }
	}
}
