package;

import echo.util.verlet.Composite;
import echo.util.verlet.Constraints;
import echo.util.verlet.Dot;
import echo.util.verlet.Verlet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import hxmath.math.Vector2;

using echo.FlxEcho;
using hxmath.math.Vector2;

class PlayState extends FlxState
{
	var verlet:Verlet;
	var player:Player;
	var ropepoints:Array<Dot>;
	var lineSprite:FlxSprite;
	var ground:FlxSprite;
	var mouseused:Bool;
	var debug:FlxText;

	override public function create()
	{
		super.create();

		player = new Player(100, 100);
		add(player);
		verlet = new Verlet({
			width: FlxG.width,
			height: FlxG.height,
			gravity_y: 100
		});
		var rope = Verlet.rope([for (i in 0...2) new Vector2(80 + i * 10, 70)], 0.5, [0]); // verlet.add(rope);
		verlet.composites.push(rope);
		lineSprite = new FlxSprite(0, 0);
		add(lineSprite);
		lineSprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
		ground = new FlxSprite(0, FlxG.height - 100).makeGraphic(500, 50);
		add(ground);
		ground.immovable = true;
		debug = new FlxText(100, 100, FlxG.width,
			"DEBUG:\nRope Point 0: " + rope.dots[0].x + ", " + rope.dots[0].y + "\nRope Point 1: " + rope.dots[1].x + ", " + rope.dots[1].y);
		debug.color = FlxColor.WHITE;
		add(debug);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// GRAVITY CUYZ IUT WANTS IT HERE AN A+M LAZY
		if (FlxG.collide(player, ground))
		{
			player.touchingground = true;
		}
		else
		{
			player.touchingground = false;
		}

		// stolen from other game that flopped cuz no good physics :(

		if (FlxG.mouse.justPressed)
		{
			mouseused = true;
			ropepoints = verlet.composites[0].dots;
			trace("Updated point");
			ropepoints[1].set_position(new Vector2(player.x, player.y));
		}
		if (FlxG.mouse.justReleased)
		{
			mouseused = false;
		}

		if (mouseused)
		{
			verlet.step(elapsed);
			FlxSpriteUtil.fill(lineSprite, FlxColor.TRANSPARENT);
			ropepoints = verlet.composites[0].dots;
			ropepoints[0].set_position(new Vector2(FlxG.mouse.x, FlxG.mouse.y)); // fuck vectors <3
			FlxSpriteUtil.drawLine(lineSprite, ropepoints[0].x, ropepoints[0].y, ropepoints[1].x, ropepoints[1].y);
			player.setPosition(ropepoints[1].x, ropepoints[1].y);

			// debug
			debug.text = "DEBUG:\nRope Point 0: " + ropepoints[0].x + ", " + ropepoints[0].y + "\nRope Point 1: " + ropepoints[1].x + ", " + ropepoints[1].y;
		}

		// unused untill latrer ig

		// Turn rope points into FlxPoints
		/*ropepoints = [];
			for (i in 0...verlet.composites[0].dots.length)
			{
				ropepoints[i] = new flixel.math.FlxPoint(verlet.composites[0].dots[i].x, verlet.composites[0].dots[i].y);
			}
			FlxSpriteUtil.drawPolygon(lineSprite, ropepoints, FlxColor.WHITE); */
	}
}
