package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Trash extends FlxSprite
{
	public var touchingground:Bool;

	public function new(x, y)
	{
		super(x, y);
		loadGraphic("assets/images/Trash.png", true, 32, 32);
		animation.frameIndex = FlxG.random.int(0, 4);
		setGraphicSize(100, 100);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
