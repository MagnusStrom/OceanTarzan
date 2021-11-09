import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import hxmath.math.Vector2;

class Rope extends FlxTypedGroup<FlxBasic>
{
	var pointsGroup:FlxTypedGroup<Point>;
	var sticksGroup:FlxTypedGroup<Stick>;
	var stickCount:Int;

	public function new(x, y, points)
	{
		super(points + 2);
		stickCount = points - 1;
		// here comes hell
		pointsGroup = new FlxTypedGroup<Point>();
		sticksGroup = new FlxTypedGroup<Stick>();
		var i:Int = 0;
		var pointX = 0;
		var lastPointX:Float = 0;
		var lastPointY:Float = 0;
		// generate rope. might make function later
		while (i < points)
		{
			var p:Point = new Point(x + pointX, y);
			pointsGroup.add(p);
			pointX += 25;
			// Make Stick
			if (i > 0)
			{
				/*	trace("x1 " + p.x);
					trace("x1 " + p.y);
					trace("xla " + lastPointX);
					trace("xla " + lastPointX); */
				var s:Stick = new Stick(lastPointX, lastPointY, p.x, p.y);
				sticksGroup.add(s);
				// copilot made this idk how this works but it does so
				s.length = Math.sqrt(Math.pow(p.x - lastPointX, 2) + Math.pow(p.y - lastPointY, 2));
				FlxSpriteUtil.drawLine(s, p.x, p.y, lastPointX, lastPointY);
			}
			else
			{
				p.locked = true;
			}
			lastPointX = p.x;
			lastPointY = p.y;
			i++;
		}

		add(pointsGroup);
		add(sticksGroup);
	}

	public function updateFirstPoint(x, y)
	{
		pointsGroup.members[0].x = x;
		pointsGroup.members[0].y = y;
	}

	override public function update(elapsed:Float):Void
	{
		// simulatye
		var pn = 0;
		pointsGroup.forEach(function(p:Point)
		{
			if (!p.locked)
			{
				// trace('damn y now at ' + p.position.y);
				var positionBeforeUpdate:Vector2 = new Vector2(p.position.x, p.position.y);

				p.position += p.position - p.prevPosition;
				// IDK WHAT THIS IS BUT I MADE IT UPO SO IT MUST BE GOOD
				var lengthBetweenPoints = Math.sqrt(Math.pow(p.position.x - p.prevPosition.x, 2) + Math.pow(p.position.y - p.prevPosition.y, 2));
				if (lengthBetweenPoints > sticksGroup.members[pn].length)
				{
					// this is cancer
					p.position = p.prevPosition.addWith(p.position.subtractWith(p.prevPosition).normalize().multiplyWith(p.maxLength);
				}
				else
				{
					p.position.y += 10;
					p.prevPosition = positionBeforeUpdate;
				}
				pn++;
			}
		});
		var i = 0;
		while (i < stickCount)
		{
			i++;
			var j = 0;
			sticksGroup.forEach(function(s:Stick)
			{
				// fuck "physics" ima do it myself
				s.x = pointsGroup.members[j].x;
				s.y = pointsGroup.members[j].y;
				s.x2 = pointsGroup.members[j].prevPosition.x;
				s.y2 = pointsGroup.members[j].prevPosition.y;

				FlxSpriteUtil.drawLine(s, s.x, s.y, s.x2, s.y2);
				j++;
			});
		}
		super.update(elapsed);
	}
}
/*// i don't like this
	var stickCentere:FlxPoint = s.pointA.addPoint(s.pointB).divideBy(2);
	var stickDir:FlxPoint = s.pointA.subtractPoint(s.pointB);
	// TODO: make this better
	//	if (!s.pointA.locked)
	//	{
	s.pointA = stickCentere.addPoint(stickDir).multiplyBy(Std.int(s.length)).divideBy(2);
	//	}
	//	if (!s.pointB.locked)
	//	{
	s.pointB = stickCentere.subtractPoint(stickDir).multiplyBy(Std.int(s.length)).divideBy(2);
	//	}
	// convert??
	s.x = s.pointA.x;
	s.y = s.pointA.y;
	s.x2 = s.pointB.x;
	s.y2 = s.pointB.y; */
// FlxSpriteUtil.fill(s, FlxColor.TRANSPARENT);
