package;

import flixel.FlxG;
import flixel.FlxSprite;

class Trash extends FlxSprite
{
	public var touchingground:Bool;

	public function new(x, y)
	{
		super(x, y);
		loadGraphic("assets/images/Trash.png", true, 32, 32);
		animation.randomFrame(); // nice
		trace(animation.frameIndex);
		setGraphicSize(100, 100);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
