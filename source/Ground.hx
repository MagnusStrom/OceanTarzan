package;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 *
 * Simple Ground Class. Probably won't be used after beta.
 * Update: Now used as platforms.
 */
class Ground extends FlxSprite
{
	public function new(x, y, w, h)
	{
		super(x, y);
		loadGraphic("assets/images/Platform.png", true, 32, 32);
		setGraphicSize(100, 100);
		updateHitbox();
		height = 10;
		offset.y = 6;
		animation.add("idle", [0, 1, 2, 3, 4, 5], 15, true);
		animation.play("idle");
		immovable = true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
