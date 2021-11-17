package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Boat extends FlxSprite
{
	public var touchingground:Bool;

	public function new(x, y)
	{
		super(x, y);
		immovable = true;
		loadGraphic("assets/images/Boat.png", true, 32, 32);
		animation.add("idle", [0], 1, false);
		animation.add("run", [1, 2], 3, true);
		animation.play("idle");
		setGraphicSize(250, 250);
		width = 250;
		height = 250;
		offset.x = -40;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
