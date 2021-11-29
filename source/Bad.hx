package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 *
 * I have like 24 hours to fucking make this whole god damn game
 */
class Bad extends FlxSprite
{
	public function new(x, y)
	{
		super(x, y);
		loadGraphic("assets/images/FISH.png", false, 13, 7);
		setGraphicSize(50);
		updateHitbox();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
