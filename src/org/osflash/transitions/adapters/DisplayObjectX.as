package org.osflash.transitions.adapters
{
	import org.osflash.easing.IEasingFunction;
	import org.osflash.transitions.ITransitionAdapter;

	import flash.display.DisplayObject;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class DisplayObjectX extends DisplayObjectAdapter
	{

		public function DisplayObjectX(	target : DisplayObject, 
										from : Number, 
										to : Number, 
										easing : IEasingFunction = null
										)
		{
			super(target, from, to, easing);
		}

		public static function to(	target : DisplayObject, 
									to : Number, 
									easing : IEasingFunction = null
									) : ITransitionAdapter
		{
			return new DisplayObjectX(target, target.x, to, easing);
		}

		public static function from(	target : DisplayObject, 
										from : Number, 
										easing : IEasingFunction = null
										) : ITransitionAdapter
		{
			return new DisplayObjectX(target, from, target.x, easing);
		}

		override public function update(t : int, d : int) : void
		{
			target.x = easing.calculate(t, start, change, d);
		}

		override public function finalise() : void
		{
			target.x = end;
		}
	}
}
