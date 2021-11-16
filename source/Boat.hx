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
		animation.add("run", [1, 2], 3, true);
		animation.play("run");
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
