package org.osflash.transitions
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	internal final class TransitionRenderer
	{
		/**
		 * @private
		 */
		private var _first : ITransition;
		
		/**
		 * @private
		 */
		private var _last : ITransition;
		
		/**
		 * @private
		 */
		private var _nativeDispatcher : Shape;
		
		/**
		 * @private
		 */
		private var _nativeEnterFrameSignal : ISignal;

		public function TransitionRenderer()
		{
			_nativeDispatcher = new Shape();
			_nativeEnterFrameSignal = new NativeSignal(_nativeDispatcher, Event.ENTER_FRAME);
		}
		
		/**
		 * Add a transition renderer to the queue.
		 */
		public function add(transition : ITransition) : void
		{
			transition.rendering = true;

			if ( !_first )
			{
				_first = transition;
				_last = transition;
				_nativeEnterFrameSignal.add(update);
			}
			else if ( _last != transition )
			{
				_last.next = transition;
				transition.prev = _last;
				_last = transition;
			}
		}
		
		/**
		 * Remove a transition renderer from the queue
		 */
		public function remove(transition : ITransition) : void
		{
			transition.rendering = false;
			
			var first : ITransition = _first;
			if(transition == first && transition == _last)
			{
				_first = null;
				_last = null;
			}
			else if(transition == first)
				_first = first.next;
			else if(transition == _last)
				_last = _last.prev;
			else
			{
				while(first)
				{
					if(first == transition)
					{
						first.prev.next = first.next;
						first.next.prev = first.prev;
					}
					
					first = first.next;
				}
			}
		}

		/**
		 * @private
		 */
		private function update(event : Event) : void
		{
			var transition : ITransition;
			var first : ITransition = _first;
			var property : Property;
			var timer : int = getTimer();
			var delta : int;
			var duration : int;
			var delay : int;

			while (first)
			{
				delay = first.delay;
				delta = timer - first.startTime + first.elapsed;
				duration = first.duration;
				property = first.property;
				
				if(	first.state == TransitionState.PAUSE ||
					first.state == TransitionState.STOP
					)
				{
					first = first.next;
					continue;
				}
				
				if (delta > duration + delay)
				{
					first.state = TransitionState.COMPLETE;

					while (property)
					{
						property.adapter.finalise();

						property = property.next;
					}
					
					if(first.isCompletedSignalActive)
						first.completedSignal.dispatch(first);

					transition = first;

					if (first == _first)
					{
						_first = first.next;

						if ( _first ) _first.prev = null;
					}
					else if (first == _last)
					{
						_last = _last.prev;

						_last.next = null;
					}
					else
					{
						first.prev.next = first.next;
						first.next.prev = first.prev;
					}

					first = first.next;

					transition.rendering = false;
					transition.next = null;
					transition.prev = null;

					if(transition.runOnce) transition.dispose();
				}
				else if (duration + delay > delta && delta > delay)
				{
					while (property)
					{
						property.adapter.update(delta - delay, duration);

						property = property.next;
					}
					
					if(first.isUpdatedSignalActive)
						first.updatedSignal.dispatch(first);

					first = first.next;
				}
				else first = first.next;
			}

			if ( !_first ) _nativeEnterFrameSignal.remove(update);
		}
	}
}
