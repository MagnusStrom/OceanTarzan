package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import openfl.sensors.Accelerometer;

class Player extends FlxSprite
{
	public var touchingground:Bool;
	public var facingLeft:Bool;
	public var fakeVelocityX:Float = 0;

	var lastPosX:Float;

	public var spawnx:Float;
	public var spawny:Float;

	public function new(x, y)
	{
		super(x, y);
		loadGraphic("assets/images/Ninjah2.png", true, 14, 22);
		animation.add("idle", [0, 1], 2, true);
		animation.add("swing", [2], 1, true);
		animation.add("fall", [3], 1, true);
		animation.add("hapi", [4], 1, true);
		animation.add("jump", [5], 1, true);
		animation.play("idle");
		setGraphicSize(70, 110);
		updateHitbox();
		width = 60;
		offset.x = -25;
		height = 100;
		offset.y = -35;
		// gravity
		acceleration.y = 400;
		drag.x = drag.y = 500;
		clipRect = new FlxRect(0, 0, 60, 95);
	}

	// respawn
	public function respawn()
	{
		x = spawnx;
		y = spawny;
		velocity.x = 0;
		velocity.y = 0;
		touchingground = false;
		animation.play("idle");
		// PlayState.ropesLeft = 3;
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
				FlxG.sound.play("assets/sounds/Jump.wav");
				// animation.play("jump");
				velocity.y = -200;
			}
			// y -= elapsed * 100;
		}
		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
		{
			if (!touchingground)
				y += elapsed * 300;
		}
		if (FlxG.keys.justPressed.R || y > FlxG.height && !FlxG.mouse.pressedRight && visible)
		{
			//	if ( < 0)
			//	{
			// Player is dead
			//	}
			respawn();
		}
		fakeVelocityX = x - lastPosX;
		lastPosX = x;
		super.update(elapsed);
	}
}
