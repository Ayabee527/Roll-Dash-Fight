package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Player extends FlxSprite
{
	public var rollin:Bool;
	public var maxHealth:Float = 200;
	public var power:Float;
	public var maxPower:Float = 100;
	public var dashing:Bool;
	public var dead:Bool;

	public static var defense:Int;
	public static var attack:Int;
	public static var powGain:Int;
	public static var powLoss:Int;

	override public function new(x:Float = 100, y:Float = 100)
	{
		super(x, y);

		loadGraphic("assets/images/player.png", true, 32, 32);
		animation.add('idle', [0, 1, 2], 10, false);
		animation.add('walkL', [0, 3, 4], 10, true, true);
		animation.add('walkR', [0, 3, 4], 10, true, false);
		animation.add('attackL', [5, 6, 0], 10, false, true);
		animation.add('attackR', [5, 6, 0], 10, false, false);

		rollin = false;
		drag.x = 300;

		health = maxHealth;
	}

	function move()
	{
		if (!rollin)
		{
			if (!dashing)
			{
				if (FlxG.keys.anyPressed([A, LEFT]))
					velocity.x = -200;
				else if (FlxG.keys.anyPressed([D, RIGHT]))
					velocity.x = 200;
				else
					velocity.x = 0;
			}
		}
		else
		{
			if (FlxG.keys.anyPressed([A, LEFT]))
				acceleration.x = -200;
			else if (FlxG.keys.anyPressed([D, RIGHT]))
				acceleration.x = 200;
			else
				acceleration.x = 0;
		}

		if (FlxG.keys.anyPressed([SPACE, UP]) && (touching == FLOOR || y >= FlxG.height - height))
			velocity.y = -300;
	}

	function dash()
	{
		if (!dashing)
		{
			if (power >= maxPower / 5)
			{
				dashing = true;
				velocity.y = 0;
				if (FlxG.keys.anyPressed([A, LEFT]))
				{
					velocity.x = -600;
				}
				else if (FlxG.keys.anyPressed([D, RIGHT]))
				{
					velocity.x = 600;
				}
				new FlxTimer().start(0.25, function(timer:FlxTimer):Void dashing = false);
				power -= maxPower / 5;
			}
			else
			{
				FlxG.camera.shake(0.01, 0.1);
			}
		}
	}

	override function update(elapsed:Float)
	{
		move();
		if (FlxG.keys.justPressed.X && !rollin)
			dash();

		if (!rollin)
		{
			power += 0.1 * ((1) + (0.25 * powGain));
		}
		else if (rollin)
		{
			power -= Math.abs(angularVelocity) / (1000 * ((1) + (0.25 * powLoss)));
		}

		if (power <= 0 && rollin)
		{
			FlxG.camera.flash(FlxColor.BLACK);
			rollin = false;
			loadGraphic("assets/images/player.png", true, 32, 32);
			animation.add('idle', [0, 1, 2], 10, false);
			animation.add('walkL', [0, 3, 4], 10, true, true);
			animation.add('walkR', [0, 3, 4], 10, true, false);
			animation.add('attackL', [5, 6, 0], 10, false, true);
			animation.add('attackR', [5, 6, 0], 10, false, false);
		}

		if (FlxG.keys.anyJustPressed([S, DOWN]))
		{
			if (rollin)
			{
				FlxG.camera.flash(FlxColor.BLACK);
				rollin = false;
				loadGraphic("assets/images/player.png", true, 32, 32);
				animation.add('idle', [0, 1, 2], 10, false);
				animation.add('walkL', [0, 3, 4], 10, true, true);
				animation.add('walkR', [0, 3, 4], 10, true, false);
				animation.add('attackL', [5, 6, 0], 10, false, true);
				animation.add('attackR', [5, 6, 0], 10, false, false);
			}
			else if (!rollin)
			{
				if (power >= maxPower)
				{
					FlxG.camera.flash(FlxColor.BLACK);
					rollin = true;
					loadGraphic("assets/images/alt-player.png", true, 16, 16);
				}
				else
					FlxG.camera.shake(0.01, 0.1);
			}
		}

		if (rollin)
		{
			angularAcceleration = acceleration.x;
			angularDrag = drag.x;
		}
		else
		{
			angularAcceleration = 0;
			angularVelocity = 0;
			angle = 0;
		}

		if (!rollin)
		{
			if (velocity.x == 0)
			{
				animation.play('idle');
			}
			else if (velocity.x < 0)
				animation.play('walkL');
			else if (velocity.x > 0)
				animation.play('walkR');
		}

		if (y >= FlxG.height - height)
		{
			y = FlxG.height - height;
			acceleration.y = 0;
			if (!FlxG.keys.anyPressed([SPACE, UP]))
				velocity.y = 0;
		}
		else
		{
			if (!dashing)
				acceleration.y = 600;
			else
				acceleration.y = 0;
		}

		if (rollin)
		{
			if (x <= 0)
			{
				x = 1;
				acceleration.x *= -1;
				velocity.x *= -0.75;
			}
			else if (x >= FlxG.width - width)
			{
				x = FlxG.width - width;
				acceleration.x *= -1;
				velocity.x *= -0.75;
			}
		}

		super.update(elapsed);
	}
}
