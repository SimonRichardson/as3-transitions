package org.osflash.transitions
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.utils.getTimer;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class Transition implements ITransition
	{

		/** 
		 * @private
		 */
		private static const _pool : TransitionPool = new TransitionPool(Transition, 0x10);

		/** 
		 * @private
		 */
		private static const _renderer : TransitionRenderer = new TransitionRenderer();

		/** 
		 * @private
		 */
		private var _next : ITransition;

		/** 
		 * @private
		 */
		private var _prev : ITransition;

		/** 
		 * @private
		 */
		private var _runOnce : Boolean;

		/** 
		 * @private
		 */
		private var _property : Property;

		/** 
		 * @private
		 */
		private var _duration : int;

		/** 
		 * @private
		 */
		private var _delay : int;

		/** 
		 * @private
		 */
		private var _startTime : int;

		/** 
		 * @private
		 */
		private var _elapsed : int;

		/** 
		 * @private
		 */
		private var _state : TransitionState;

		/** 
		 * @private
		 */
		private var _rendering : Boolean;
		
		/** 
		 * @private
		 */
		private var _startSignal : ISignal;
		
		/** 
		 * @private
		 */
		private var _resumeSignal : ISignal;
		
		/** 
		 * @private
		 */
		private var _updatedSignal : ISignal;
		
		/** 
		 * @private
		 */
		private var _completedSignal : ISignal;
		
		/** 
		 * @private
		 */
		private var _stopSignal : ISignal;
		
		/** 
		 * @private
		 */
		private var _pauseSignal : ISignal;

		public function Transition(next : Transition)
		{
			_next = next;
		}


		public static function create(	duration : int, 
										delay : int, 
										runOnce : Boolean, 
										property : Property = null
										) : ITransition
		{
			const transition : ITransition = _pool.acquire();
			transition.duration = duration;
			transition.delay = delay;
			transition.runOnce = runOnce;
			transition.property = property;

			return transition;
		}

		public static function createAndStart(	duration : int, 
												delay : int, 
												runOnce : Boolean, 
												property : Property
												) : ITransition
		{
			const transition : ITransition = _pool.acquire();
			transition.duration = duration;
			transition.delay = delay;
			transition.runOnce = runOnce;
			transition.property = property;
			transition.start();

			return transition;
		}

		/**
		 * @inheritDoc
		 */
		public function start() : void
		{
			if (_state == TransitionState.RUNNING) return;

			_state = TransitionState.RUNNING;

			_startTime = getTimer();

			_elapsed = 0;

			if (!_rendering) _renderer.add(this);

			startSignal.dispatch(this);
		}

		/**
		 * @inheritDoc
		 */
		public function pause() : void
		{
			if (_state == TransitionState.PAUSE) return;

			_state = TransitionState.PAUSE;

			_elapsed += getTimer() - _startTime;

			pauseSignal.dispatch(this);
		}

		/**
		 * @inheritDoc
		 */
		public function stop() : void
		{
			if (_state == TransitionState.STOP) return;

			_state = TransitionState.STOP;

			_startTime = 0;
			_elapsed = 0;
			
			if(!_rendering) _renderer.remove(this);

			stopSignal.dispatch(this);
		}

		/**
		 * @inheritDoc
		 */
		public function resume() : void
		{
			if (_state == TransitionState.RUNNING) return;

			_state = TransitionState.RUNNING;

			_startTime = getTimer();

			if (!_rendering) _renderer.add(this);
			
			resumeSignal.dispatch(this);
		}

		/**
		 * @inheritDoc
		 */
		public function reverse() : void
		{
			var p : Property = _property;
			while ( p )
			{
				p.adapter.reverse();
				p = p.next;
			}

			if ( _state == TransitionState.COMPLETE )
				start();
			else
			{
				const time : Number = getTimer();

				_elapsed = _duration - (_elapsed + time - _startTime );
				_startTime = time;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function dispose() : void
		{
			if (null != _property)
			{
				_property.dispose();
				_property = null;
			}
			
			_pool.release(this);
		}

		public function get startTime() : Number { return _startTime; }

		public function get elapsed() : Number { return _elapsed; }

		public function get duration() : Number { return _duration; }
		public function set duration(value : Number) : void
		{
			if(value < 0) throw new ArgumentError('Duration can not be less than 0');
			_duration = value;
		}

		public function get delay() : int { return _delay; }
		public function set delay(value : int) : void
		{
			if(value < 0) throw new ArgumentError('Delay can not be less than 0');
			_delay = value;
		}

		public function get runOnce() : Boolean { return false; }
		public function set runOnce(value : Boolean) : void { _runOnce = value; }

		public function get property() : Property { return _property; }
		public function set property(value : Property) : void { _property = value; }

		public function get state() : TransitionState { return _state; }
		public function set state(value : TransitionState) : void
		{
			if(null == value) throw new ArgumentError('State can not be null');
			_state = value;
		}

		public function get rendering() : Boolean { return _rendering; }
		public function set rendering(value : Boolean) : void { _rendering = value; }

		public function get next() : ITransition { return _next; }
		public function set next(value : ITransition) : void { _next = value; }

		public function get prev() : ITransition { return _prev; }
		public function set prev(value : ITransition) : void { _prev = value; }
		
		public function get startSignal() : ISignal
		{
			if(null == _startSignal) _startSignal = new Signal(ITransition);
			return _startSignal;
		}

		public function get resumeSignal() : ISignal
		{
			if(null == _resumeSignal) _resumeSignal = new Signal(ITransition);
			return _resumeSignal;
		}

		public function get updatedSignal() : ISignal
		{
			if(null == _updatedSignal) _updatedSignal = new Signal(ITransition);
			return _updatedSignal;
		}

		public function get completedSignal() : ISignal
		{
			if(null == _completedSignal) _completedSignal = new Signal(ITransition);
			return _completedSignal;
		}

		public function get stopSignal() : ISignal
		{
			if(null == _stopSignal) _stopSignal = new Signal(ITransition);
			return _stopSignal;
		}

		public function get pauseSignal() : ISignal
		{
			if(null == _pauseSignal) _pauseSignal = new Signal(ITransition);
			return _pauseSignal;
		}

		public function get isUpdatedSignalActive() : Boolean
		{
			return null != _updatedSignal;
		}

		public function get isCompletedSignalActive() : Boolean
		{
			return null != _completedSignal;
		}
	}
}
