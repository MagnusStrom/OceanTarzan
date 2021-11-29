package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class TitleState extends FlxState
{
	var bg:FlxSprite;
	var cum:FlxSound;
	var vroom:FlxSound;

	override public function create():Void
	{
		super.create();
		cum = new FlxSound().loadEmbedded("assets/sounds/MainMenu.wav");
		cum.looped = true;
		cum.play();
		vroom = new FlxSound().loadEmbedded("assets/sounds/Vroom.mp3");
		bg = new FlxSprite(0, 0).loadGraphic("assets/images/StartingBG.png", true, 32, 32);
		bg.animation.add('idle', [0, 1], 0.6, true);
		bg.setGraphicSize(FlxG.width, FlxG.width);
		bg.screenCenter();
		add(bg);
		bg.animation.play('idle');
		var myText = new FlxText(0, 0, 500); // x, y, width
		myText.text = "SEA NINJA";
		myText.setFormat("assets/data/Baby_Elephant.ttf", 50, FlxColor.WHITE, CENTER);
		myText.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		myText.screenCenter();
		myText.y -= 100;
		add(myText);

		var myText2 = new FlxText(0, 0, 500); // x, y, width
		myText2.text = "Press ENTER to play";
		myText2.setFormat("assets/data/Baby_Elephant.ttf", 30, FlxColor.WHITE, CENTER);
		myText2.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		myText2.screenCenter();
		add(myText2);

		var img:FlxSprite = new FlxSprite(0, 0).loadGraphic("assets/images/SEAJAM.png");
		img.screenCenter();
		img.y += 100;
		add(img);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER)
		{
			// gamer transition + reusing assets lesgooo
			var gamerbox = new FlxSprite(1570, FlxG.height - 40).makeGraphic(FlxG.width * 4, FlxG.width, FlxColor.BLACK);
			add(gamerbox);
			gamerbox.screenCenter(Y);
			gamerbox.acceleration.x = -500;
			var gamerboat = new FlxSprite(1450, FlxG.height - 40).loadGraphic("assets/images/Boat.png", true, 32, 32, true);
			add(gamerboat);
			gamerboat.screenCenter(Y);
			gamerboat.setGraphicSize(FlxG.width * 4, FlxG.width * 6);
			gamerboat.acceleration.x = -500;
			gamerboat.animation.add("idle", [1, 2], 1, true);
			gamerboat.animation.play("idle");
			gamerboat.flipX = true;
			cum.stop();
			vroom.play();
			new FlxTimer().start(3.5, function(timer:FlxTimer)
			{
				vroom.stop();
				FlxG.switchState(new PlayState());
			});
		}
	}
}
