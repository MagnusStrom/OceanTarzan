package;

import echo.util.AABB;
import echo.util.verlet.Composite;
import echo.util.verlet.Constraints;
import echo.util.verlet.Dot;
import echo.util.verlet.Verlet;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
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
	var bad:FlxTypedGroup<Bad>;
	var mouseused:Bool;
	var debug:FlxText;
	var level:Int = 0;
	var levelText:FlxText;
	var tutorialText:FlxTypeText;
	var connected:Bool = false;
	var launch:Bool = false;
	var ropeStartingPointX:Float = 0;
	var vel:Vector2;
	var launchMultiplier:Float = 70;
	var trashRequired:Int = 0;
	var trashCollected:Int = 0;

	public var ropesLeft:Int = 0;

	var mapRopes:Int = 3;
	var ropeBar:FlxBar;
	var ending:Boat;

	var trashCount:FlxText;
	var tutorialBoxShit:FlxSprite;
	var vroom:FlxSound;
	var errorTXT:FlxTypeText;

	var dialouge:Array<String> = [
		"Welcome to Atlantis, Ninja!", "I'm glad the PolySeas foundation sent you to give us a hand.",
		"We need your help! There's trash everywhere and we need to get it out of our city!",
		"We tried to do it ourselves, but when we tried, the trash got stuck on our fins, and made it so we can't swim!",
		"We've set up a transit boat at the bottom for you, but we need you to retrive the trash above it!",
		"Ocean exploration is a little different than normal, and due to the high water pressure, you can't swim! So I'll teach you how to move.",
		"Use A, D, Or left and right to move.", "Use W or up arrow to jump.", "Great job! You're a pro!",
		"Now we just need you to get the trash and get to the boat!", "Jump off the platform and click and hold anywhere to swing!",
		"Swing into the trash to pick it up!", "Great job! Now we just need you to get to the boat!", "Congratulations Ninja! You've completed the tutorial!",
		"Hey Ninja! Hold E while letting go of your rope to fly upwards!\nThis is called a launch.",
		"Congratulations! Now head down to the boat, there's oceans to clean!",
		"Uh oh! Looks like we've got some out of town visitors, ninja!\nTry to avoid the fish!"
	];
	var dialougeIndex:Int = 0;

	var endingStarted:Bool = false;
	var mouseBlocked:Bool = false;

	var deaths:Int = 0;

	override public function create()
	{
		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
		add(bg);
		vroom = new FlxSound().loadEmbedded("assets/sounds/Vroom.mp3");

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
		bad = new FlxTypedGroup<Bad>();
		add(ground);
		add(trash); // how did i forget this bruh
		add(bad);
		// test level
		//	ground.add(new Ground(0, FlxG.height - 50, 200, 50));
		debug = new FlxText(100, 100, FlxG.width, "Rope to load debug stats.");
		debug.color = FlxColor.WHITE;
		// add(debug);
		levelText = new FlxText(0, 0, FlxG.width, "Level " + level);
		add(levelText);
		trashCount = new FlxText(FlxG.width - 500, 10, FlxG.width, "Trash: " + trashCollected + "/" + trashRequired, 17);
		add(trashCount);
		ending = new Boat(650, FlxG.height - 40);
		add(ending);
		// TODO: add trash image

		// hardcoding so i can force myself to suffer later
		loadLevel(0);
		var gamerbox = new FlxSprite(1670, FlxG.height - 40).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(gamerbox);
		gamerbox.screenCenter();
		gamerbox.acceleration.x = -700;

		super.create();
	}

	// Load New Level
	inline function loadLevel(level:Int)
	{
		levelText.text = "Level " + level;
		ground.clear();
		trash.clear();
		bad.clear();
		trashCollected = 0;
		remove(tutorialText);
		remove(tutorialBoxShit);
		remove(errorTXT);
		player.visible = true;
		remove(ending);
		switch (level)
		{
			case 0:
				// Level 1
				player.spawnx = 100;
				player.spawny = 100;
				ground.add(new Ground(100, 300, 100, 10));
				// dialougeIndex = 0;
				if (dialougeIndex == 0)
					tutorialText = new FlxTypeText(FlxG.width - 650, 70, 400, dialouge[dialougeIndex] + "\nPress Z to continue", 15);
				else
				{
					// theres no other possible idnex that should set in this case
					if (dialougeIndex > 9)
						dialougeIndex = 10;
					tutorialText = new FlxTypeText(FlxG.width - 650, 70, 400, dialouge[dialougeIndex], 15);
				}
				// tutorialText.sounds = [new FlxSound().loadEmbedded("assets/sounds/DIALOUGE.wav")];
				add(tutorialText);
				tutorialText.start(0.02, true, false);
				trash.add(new Trash(400, 400));
				mapRopes = 1;
				trashRequired = 1;
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
			case 1:
				// HARDCODE THIS
				// Level 2
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
				player.spawnx = 100;
				player.spawny = 0;
				ground.add(new Ground(100, 100, 100, 10));
				ground.add(new Ground(576, 333, 100, 10));
				ground.add(new Ground(99, 464, 100, 10));
				trash.add(new Trash(654, 220));
				trash.add(new Trash(130, 410));
				mapRopes = 5;
				trashRequired = 2;
			case 2:
				// Level 3
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
				player.spawnx = 100;
				player.spawny = FlxG.height - 500;
				ground.add(new Ground(100, FlxG.height - 300, 100, 10));
				ground.add(new Ground(529, 150, 100, 10));
				trash.add(new Trash(500, 100));
				mapRopes = 5;
				trashRequired = 1;
				dialougeIndex = 14;
				tutorialText = new FlxTypeText(FlxG.width - 650, 70, 400, dialouge[dialougeIndex], 15);
				add(tutorialText);
				//	tutorialText.sounds = [new FlxSound().loadEmbedded("assets/sounds/DIALOUGE.wav")];
				tutorialText.start(0.02, true, false);
			case 3:
				// Level 4
				trashRequired = 3;
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
				player.spawnx = 100;
				player.spawny = 0;
				ground.add(new Ground(100, 100, 100, 10));
				trash.add(new Trash(114, 220));
				trash.add(new Trash(428, 290));
				trash.add(new Trash(614, 408));
			case 4:
				trashRequired = 2;
				mapRopes = 4;
				ground.add(new Ground(100, 170, 100, 10));
				trash.add(new Trash(486, 47));
				trash.add(new Trash(112, 415));
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
			case 5:
				trashRequired = 4;
				mapRopes = 3;
				ground.add(new Ground(100, 100, 100, 10));
				trash.add(new Trash(520, 207));
				trash.add(new Trash(520, 307));
				trash.add(new Trash(520, 407));
				trash.add(new Trash(520, 507));
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
			case 6:
				trashRequired = 1;
				mapRopes = 3;
				ground.add(new Ground(100, FlxG.height - 40, 100, 10));
				trash.add(new Trash(289, 47));
				ending = new Boat(650, FlxG.height - 40);
				player.spawny = FlxG.height - 250;
				add(ending);
			case 7:
				dialougeIndex++;
				player.spawnx = 100;
				player.spawny = 100;
				ground.add(new Ground(100, 250, 100, 10));
				bad.add(new Bad(485, 390));
				trash.add(new Trash(588, 404));
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
			//	tutorialText = new FlxTypeText(FlxG.width - 650, 70, 400, dialouge[dialougeIndex], 15);
			//	add(tutorialText);
			//	tutorialText.sounds = [new FlxSound().loadEmbedded("assets/sounds/DIALOUGE.wav")];
			//	tutorialText.start(0.02, true, false);
			case 8:
				ground.add(new Ground(100, 250, 100, 10));
				ending = new Boat(650, FlxG.height - 40);
				bad.add(new Bad(405, 174));
				bad.add(new Bad(405, 274));
				trash.add(new Trash(560, 274));
				bad.add(new Bad(405, 374));
				bad.add(new Bad(405, 474));
				add(ending);
			case 9:
				ground.add(new Ground(100, 250, 100, 10));
				ending = new Boat(650, FlxG.height - 40);
				bad.add(new Bad(605, 174));
				bad.add(new Bad(605, 274));
				trash.add(new Trash(560, 274));
				bad.add(new Bad(605, 374));
				bad.add(new Bad(605, 474));
				add(ending);
			case 10:
				ground.add(new Ground(100, 250, 100, 10));
				ending = new Boat(650, FlxG.height - 40);
				add(ending);
				bad.add(new Bad(346, 151));
				bad.add(new Bad(533, 67));
				bad.add(new Bad(464, 375));
				bad.add(new Bad(199, 68));
				trash.add(new Trash(392, 23));
				trash.add(new Trash(6, 412));
				trash.add(new Trash(387, 309));
				trash.add(new Trash(630, 41));
				mapRopes = 10;
				trashRequired = 4;
			case 11:
				FlxG.switchState(new EndState(deaths));
		}
		ropesLeft = mapRopes;
		remove(ropeBar);
		ropeBar = new FlxBar(10, 10, FlxBarFillDirection.LEFT_TO_RIGHT, 150, 50, this, "ropesLeft", 0, mapRopes, true);
		add(ropeBar);
		ropeBar.createFilledBar(FlxColor.BLACK, FlxColor.GREEN, true, FlxColor.BLUE);
		trashCount.text = "Trash: " + trashCollected + "/" + trashRequired;
		player.x = player.spawnx;
		player.y = player.spawny;
		player.velocity.x = 0;
		player.velocity.y = 0;
	}

	function collectTrash(player:FlxObject, trash:FlxObject)
	{
		trash.kill();
		trashCollected++;
		trashCount.text = "Trash: " + trashCollected + "/" + trashRequired;
		if (level == 0)
		{ // no need to check dialouge because we checked it last time and theres no other place it could be
			dialougeIndex++;
			tutorialText.resetText(dialouge[dialougeIndex]);
			tutorialText.start(0.02, true, false);
		}
		else if (level == 2)
		{
			if (trashCollected == trashRequired)
			{
				dialougeIndex++;
				tutorialText.resetText(dialouge[dialougeIndex]);
				tutorialText.start(0.02, true, false);
			}
		}
		FlxG.sound.play("assets/sounds/TrashCollect.wav");
	}

	function endLevel(player:FlxObject, ending:Boat)
	{
		if (trashCollected == trashRequired && !endingStarted)
		{
			endingStarted = true;
			// animation shit
			player.visible = false;
			ending.acceleration.x = 70;
			ending.animation.play("run");
			if (level == 0)
			{
				dialougeIndex++;
				tutorialText.resetText(dialouge[dialougeIndex]);
				tutorialText.start(0.02, true, false);
			}
			FlxG.sound.play("assets/sounds/Ending.wav");
			vroom.play();
			new FlxTimer().start(3, function(timer:FlxTimer)
			{
				endingStarted = false;
				trace("DONE");
				loadLevel(level + 1);
				level++;
				vroom.stop();
			});
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ONE)
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

		FlxG.overlap(player, ending, endLevel);
		// stolen from other game that flopped cuz no good physics :(

		if (FlxG.keys.anyPressed([E, M, Q]))
		{
			launch = true;
		}
		else
		{
			launch = false;
		}

		if (FlxG.keys.justPressed.ONE)
		{
			level++;
			loadLevel(level);
		}

		if (FlxG.mouse.justPressed)
		{
			mouseBlocked = false;
			if (ropesLeft > 0)
			{ // hopefully this works
				if (player.y < FlxG.mouse.y)
				{
					// cannot grapple
					errorTXT = new FlxTypeText(FlxG.width - 650, FlxG.height - 50, 400, "You can't swing when you're above the rope!", 15);
					// tutorialText.sounds = [new FlxSound().loadEmbedded("assets/sounds/DIALOUGE.wav")];
					add(errorTXT);
					errorTXT.start(0.02, true, false, [], function():Void
					{
						new FlxTimer().start(1, function(timer:FlxTimer)
						{
							remove(errorTXT);
						});
					});
				}
				else
				{
					if (level == 0)
					{
						if (dialougeIndex == 10)
						{
							dialougeIndex = 11;
							tutorialText.resetText(dialouge[dialougeIndex]);
							tutorialText.start(0.02, true, false);
							FlxG.sound.play("assets/sounds/Grapple.wav");
							connected = true;
							player.animation.play("swing");
							mouseused = true;
							var rope = Verlet.rope([new Vector2(FlxG.mouse.x, FlxG.mouse.y), new Vector2(player.x, player.y)], 0.7, [0]); // verlet.add(rope);
							verlet.composites.push(rope);
							// track starting point of rope
							ropeStartingPointX = player.x;
							ropesLeft -= 1;
							ropeBar.createFilledBar(FlxColor.BLACK, FlxColor.GREEN, true, FlxColor.BLUE);
							trace("Rope added");
						}
					}
					else
					{
						FlxG.sound.play("assets/sounds/Grapple.wav");
						connected = true;
						player.animation.play("swing");
						mouseused = true;
						var rope = Verlet.rope([new Vector2(FlxG.mouse.x, FlxG.mouse.y), new Vector2(player.x, player.y)], 0.7, [0]); // verlet.add(rope);
						verlet.composites.push(rope);
						// track starting point of rope
						ropeStartingPointX = player.x;
						ropesLeft -= 1;
						ropeBar.createFilledBar(FlxColor.BLACK, FlxColor.GREEN, true, FlxColor.BLUE);
						trace("Rope added");
					}
				}
			}
			// tutorial shit
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
			var pos = ropepoints[1].get_position();
			vel = (pos - ropepoints[1].get_last_position()) * verlet.drag;
			debug.text = "DEBUG:\nROPE VELOCITY X: " + vel.x + "\nROPE VELOCITY Y: " + vel.y;
		}

		if (FlxG.mouse.justReleased && mouseused)
		{
			disableRope();
		}

		// Second player management class because I'm lazy
		if (FlxG.keys.justPressed.R
			|| player.y > FlxG.height
			&& !FlxG.mouse.pressedRight
			&& player.visible
			|| FlxG.overlap(bad, player))
		{
			loadLevel(level);
			ropesLeft = mapRopes;
			trashCollected = 0;
			mouseused = false;
			connected = false;
			disableRope();
			player.respawn();
			deaths++;
			FlxG.sound.play("assets/sounds/Dead.wav");
		}

		// TUTORIAL
		if (level == 0)
		{
			if (FlxG.keys.justPressed.Z && dialougeIndex < 10)
			{
				dialougeIndex++;
				tutorialText.resetText(dialouge[dialougeIndex]);
				tutorialText.start(0.02, true, false);
			}
		}

		// debug
		if (FlxG.keys.pressed.L)
		{
			trace(FlxG.mouse.x + " " + FlxG.mouse.y);
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

	function disableRope()
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

			player.velocity.x = vel.x * launchMultiplier;
			// player.velocity.y = ropepoints[ropepoints.length - 1].dy - (player.drag.y / 2);
			// player.velocity.x = (ropeStartingPointX - player.x) * -1;
			player.velocity.y = !launch ? (vel.y * launchMultiplier) : (vel.y * launchMultiplier) - 400;

			if (launch)
				FlxG.sound.play("assets/sounds/Jump.wav");
		}
		// clear rope
		FlxSpriteUtil.fill(lineSprite, FlxColor.TRANSPARENT);
		trace("Rope removed");
	}
}
