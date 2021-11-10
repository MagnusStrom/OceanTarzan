package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 *
 * Simple Ground Class. Probably won't be used after beta.
 */
class Ground extends FlxSprite
{
	public function new(x, y, w, h)
	{
		super(x, y);
		makeGraphic(w, h);
		immovable = true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
