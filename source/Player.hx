package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.sensors.Accelerometer;

class Player extends FlxSprite
{
	public var touchingground:Bool;
	public var facingLeft:Bool;
	public var fakeVelocityX:Float = 0;

	var lastPosX:Float;

	public function new(x, y)
	{
		super(x, y);
		loadGraphic("assets/images/Ninjah.png", true, 32, 32);
		animation.add("idle", [0, 1], 2, true);
		animation.add("swingL", [3], 1, true);
		animation.add("swingR", [2], 1, true);
		animation.play("idle");
		setGraphicSize(100, 100);
		updateHitbox();
		width = 30;
		offset.x = 5;
		height = 80;
		offset.y = -35;
		// gravity
		acceleration.y = 400;
		maxVelocity.y = 200;
		drag.x = drag.y = 500;
		// elasticity = 0.05;
	}

	// respawn
	public function respawn()
	{
		x = 100;
		y = 100;
		velocity.x = 0;
		velocity.y = 0;
		touchingground = false;
		animation.play("idle");
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
		{
			x -= elapsed * 100;
			facingLeft = true;
		}
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D)
		{
			x += elapsed * 100;
			facingLeft = false;
		}
		if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
		{
			if (touchingground)
			{
				velocity.y = -600;
			}
			// y -= elapsed * 100;
		}
		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
		{
			y += elapsed * 100;
		}
		if (FlxG.keys.pressed.R || y > FlxG.height)
		{
			respawn();
		}
		fakeVelocityX = x - lastPosX;
		lastPosX = x;
		super.update(elapsed);
	}
}
