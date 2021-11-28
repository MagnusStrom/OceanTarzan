package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 *
 * I have like 24 hours to fucking make this whole god damn game
 */
class Bad extends FlxSprite
{
	public function new(x, y, w, h)
	{
		super(x, y);
		loadGraphic("assets/images/FISH.png", false, 13, 7);
		setGraphicSize(100);
		updateHitbox();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
