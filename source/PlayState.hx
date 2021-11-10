package;

import echo.util.verlet.Composite;
import echo.util.verlet.Constraints;
import echo.util.verlet.Dot;
import echo.util.verlet.Verlet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
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
	var ground:FlxTypedGroup<Ground>;
	var mouseused:Bool;
	var debug:FlxText;

	override public function create()
	{
		super.create();
		FlxG.fixedTimestep = false;
		player = new Player(100, 100);
		add(player);
		verlet = new Verlet({
			x: 0,
			y: 0,
			width: FlxG.width,
			height: FlxG.height,
			gravity_y: 20
		});
		lineSprite = new FlxSprite(0, 0);
		add(lineSprite);
		lineSprite.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT);
		ground = new FlxTypedGroup<Ground>();
		add(ground);
		// test level
		//	ground.add(new Ground(0, FlxG.height - 50, 200, 50));
		ground.add(new Ground(500, FlxG.height - 50, 200, 50));
		debug = new FlxText(100, 100, FlxG.width, "Rope to load debug stats.");
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
			var rope = Verlet.rope([new Vector2(FlxG.mouse.x, FlxG.mouse.y), new Vector2(player.x, player.y)], 0.7, [0]); // verlet.add(rope);
			verlet.composites.push(rope);
			trace("Rope added");
		}
		if (FlxG.mouse.justReleased)
		{
			mouseused = false;
			// apply last point velocity to player
			player.velocity.x = ropepoints[ropepoints.length - 1].dx - (player.drag.x / 4);
			player.velocity.y = ropepoints[ropepoints.length - 1].dy - (player.drag.y / 2);
			// clear rope
			FlxSpriteUtil.fill(lineSprite, FlxColor.TRANSPARENT);
			verlet.composites.pop(); // hopefully this works
			trace("Rope removed");
		}

		if (mouseused)
		{
			verlet.step(elapsed);
			ropepoints = verlet.composites[0].dots; // set again after step
			FlxSpriteUtil.fill(lineSprite, FlxColor.TRANSPARENT);
			FlxSpriteUtil.drawLine(lineSprite, ropepoints[0].x, ropepoints[0].y, ropepoints[1].x, ropepoints[1].y);
			player.setPosition(ropepoints[1].x, ropepoints[1].y);

			// debug
			debug.text = "DEBUG:\nRope Point 0: "
				+ ropepoints[0].x + ", " + ropepoints[0].y + "\nRope Point 1: " + ropepoints[1].x + ", " + ropepoints[1].y
					+ "\nPlayer: "
					+ player.x
					+ ", "
					+ player.y
					+ "\nMouse: "
					+ FlxG.mouse.x
					+ ", "
					+ FlxG.mouse.y;
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
