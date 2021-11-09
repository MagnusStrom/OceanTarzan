package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.sensors.Accelerometer;

class Player extends FlxSprite
{
	public var touchingground:Bool;

	public function new(x, y)
	{
		super(x, y);
		makeGraphic(20, 20, 0xFFFFFFFF);
		// gravity
		acceleration.y = 400;
		maxVelocity.y = 600;
		// elasticity = 0.05;
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
		{
			x -= elapsed * 100;
		}
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D)
		{
			x += elapsed * 100;
		}
		if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
		{
			if (touchingground)
			{
				velocity.y = -200;
			}
			// y -= elapsed * 100;
		}
		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
		{
			y += elapsed * 100;
		}
		super.update(elapsed);
	}
}
