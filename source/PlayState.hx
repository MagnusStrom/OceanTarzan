package;

import echo.util.verlet.Composite;
import echo.util.verlet.Constraints;
import echo.util.verlet.Dot;
import echo.util.verlet.Verlet;
import flixel.FlxG;
import flixel.FlxObject;
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
	var trash:FlxTypedGroup<Trash>;
	var mouseused:Bool;
	var debug:FlxText;
	var level:Int = 0;
	var savedlevel:Int = -1;
	var levelText:FlxText;
	var tutorialText:FlxText;
	var connected:Bool = false;
	var launch:Bool = false;
	var ropeStartingPointX:Float = 0;

	override public function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
		add(bg);
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
		trash = new FlxTypedGroup<Trash>();
		add(ground);
		add(trash); // how did i forget this bruh
		// test level
		//	ground.add(new Ground(0, FlxG.height - 50, 200, 50));
		debug = new FlxText(100, 100, FlxG.width, "Rope to load debug stats.");
		debug.color = FlxColor.WHITE;
		add(debug);
	}

	// Load New Level
	inline function loadLevel(level:Int)
	{
		savedlevel = level;
		levelText = new FlxText(0, 0, FlxG.width, "Level " + level);
		add(levelText);
		switch (level)
		{
			case 0:
				// Level 1
				player.x = 100;
				player.y = 100;
				ground.add(new Ground(100, 200, 100, 10));
				ground.add(new Ground(500, FlxG.height - 50, 200, 50));
				tutorialText = new FlxText(300, 100, FlxG.width,
					"Jump off the platform and \nClick and hold to swing.\nCollect the trash and get to the green!", 10);
				add(tutorialText);
				trash.add(new Trash(400, 200));
				trash.add(new Trash(200, FlxG.height - 200));
		}
	}

	function collectTrash(player:FlxObject, trash:FlxObject)
	{
		trash.kill();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		// load level if not loaded
		if (level > savedlevel)
		{
			loadLevel(level);
		}
		// GRAVITY CUYZ IUT WANTS IT HERE AN A+M LAZY
		if (FlxG.collide(player, ground))
		{
			player.touchingground = true;
		}
		else
		{
			player.touchingground = false;
		}

		FlxG.overlap(player, trash, collectTrash);

		// stolen from other game that flopped cuz no good physics :(

		if (FlxG.keys.anyPressed([E, M, Q]))
		{
			launch = true;
		}
		else
		{
			launch = false;
		}

		if (FlxG.mouse.justPressed)
		{ // hopefully this works
			connected = true;
			player.animation.play("swingL");
			mouseused = true;
			var rope = Verlet.rope([new Vector2(FlxG.mouse.x, FlxG.mouse.y), new Vector2(player.x, player.y)], 0.7, [0]); // verlet.add(rope);
			verlet.composites.push(rope);
			// track starting point of rope
			ropeStartingPointX = player.x;
			trace("Rope added");
		}

		if (mouseused)
		{
			verlet.step(elapsed);
			ropepoints = verlet.composites[0].dots; // set again after step
			FlxSpriteUtil.fill(lineSprite, FlxColor.TRANSPARENT);
			FlxSpriteUtil.drawLine(lineSprite, ropepoints[0].x, ropepoints[0].y, ropepoints[1].x, ropepoints[1].y + 40 /*Adjusted to fit hand*/);
			if (player.touchingground == false && connected == true)
			{
				player.setPosition(ropepoints[1].x, ropepoints[1].y);
			}
			else
			{
				// Player cannot connect to rope anymore. TODO: Play a sound here.
				connected = false;
			}

			// debug
			debug.text = "DEBUG:\nSTARTING ROPE POINT:"
				+ ropeStartingPointX
				+ "\nROPE POINT 1:"
				+ ropepoints[0].x + "\nROPE POINT 2:" + ropepoints[1].x
					+ "\nPLAYER X:"
					+ player.x
					+ "\nPLAYER Y:"
					+ player.y;
		}

		if (FlxG.mouse.justReleased)
		{
			verlet.composites.pop();
			player.animation.play("idle");
			mouseused = false;
			// apply last point velocity to player
			if (connected == true)
			{
				/*	if (ropepoints[ropepoints.length - 1].dx > 0)
					{
						player.velocity.x = (ropepoints[ropepoints.length - 1].dx - (!launch ? (player.drag.x / 4) : 0)) * (player.facingLeft ? -1 : 1);
					}
					else
					{
						player.velocity.x = (ropepoints[ropepoints.length - 1].dx - (!launch ? (player.drag.x / 4) : 0)) * (!player.facingLeft ? -1 : 1);
				}*/

				if (ropeStartingPointX > player.x)
				{
					trace("Player is swinging left.");
					player.velocity.x = (ropepoints[ropepoints.length - 1].dx - (player.drag.x / 4)) * -1;
				}
				else
				{
					trace("Player is swinging right.");
					player.velocity.x = ropepoints[ropepoints.length - 1].dx - (player.drag.x / 4);
				}
				// player.velocity.y = ropepoints[ropepoints.length - 1].dy - (player.drag.y / 2);
				// player.velocity.x = (ropeStartingPointX - player.x) * -1;
				player.velocity.y = !launch ? 0 : -400;
			}
			// clear rope
			FlxSpriteUtil.fill(lineSprite, FlxColor.TRANSPARENT);
			trace("Rope removed");
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
