package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

class Enemy extends FlxSprite
{
	var player:Player;
	var jumping:Bool;

	public var rollin:Bool;
	public var maxHealth:Float = 200;
	public var power:Float;
	public var maxPower:Float = 100;
	public var dashing:Bool;

	override public function new(x:Float = 100, y:Float = 100, player:Player)
	{
		super(x, y);

		this.player = player;

		loadGraphic("assets/images/enemy.png", true, 32, 32);
		animation.add('idle', [0, 1, 2], 10, false);
		animation.add('walkL', [0, 3, 4], 10, true, true);
		animation.add('walkR', [0, 3, 4], 10, true, false);
		animation.add('attackL', [5, 6, 0], 10, false, true);
		animation.add('attackR', [5, 6, 0], 10, false, false);

		drag.x = 300;
		rollin = false;

		health = maxHealth;
	}

	function normAI()
	{
		var ang = FlxAngle.angleBetween(this, player);
		if (FlxMath.distanceBetween(this, player) > 22)
		{
			if (!rollin)
			{
				if (!dashing)
				{
					if ((touching == FLOOR || y >= FlxG.height - height))
						velocity.x = Math.cos(ang) * 175;
					else
						velocity.x = Math.cos(ang) * 225;
				}
			}
			else
			{
				if ((touching == FLOOR || y >= FlxG.height - height))
					acceleration.x = Math.cos(ang) * 175;
				else
					acceleration.x = Math.cos(ang) * 225;
			}
		}
		else
		{
			if (!rollin)
			{
				velocity.x = 0;
			}
			else
			{
				acceleration.x = 0;
			}
		}

		if ((player.y < y) && (touching == FLOOR || y >= FlxG.height - height))
			velocity.y = -200 * ((1) + (.05 * PlayState.enemsKilled));
	}

	function dash()
	{
		if (FlxMath.distanceBetween(this, player) > 96 && !dashing && !rollin)
		{
			if (power >= maxPower / 3)
			{
				if (FlxG.random.bool(1))
				{
					dashing = true;
					velocity.y = 0;
					velocity.x = Math.cos(FlxAngle.angleBetween(this, player)) * 600;
					new FlxTimer().start(0.25, function(timer:FlxTimer):Void dashing = false);
					power -= maxPower / 3;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		normAI();
		dash();

		if (!rollin)
			power += 0.1;
		else if (rollin)
			power -= Math.abs(angularVelocity) / 1000;

		if (power <= 0 && rollin)
		{
			rollin = false;
			loadGraphic("assets/images/enemy.png", true, 32, 32);
			animation.add('idle', [0, 1, 2], 10, false);
			animation.add('walkL', [0, 3, 4], 10, true, true);
			animation.add('walkR', [0, 3, 4], 10, true, false);
			animation.add('attackL', [5, 6, 0], 10, false, true);
			animation.add('attackR', [5, 6, 0], 10, false, false);
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

		if (power >= maxPower)
		{
			if (FlxG.random.bool(0.1))
			{
				if (rollin)
				{
					rollin = false;
					loadGraphic("assets/images/enemy.png", true, 32, 32);
					animation.add('idle', [0, 1, 2], 10, false);
					animation.add('walkL', [0, 3, 4], 10, true, true);
					animation.add('walkR', [0, 3, 4], 10, true, false);
					animation.add('attackL', [5, 6, 0], 10, false, true);
					animation.add('attackR', [5, 6, 0], 10, false, false);
				}
				else if (!rollin)
				{
					rollin = true;
					loadGraphic("assets/images/alt-enemy.png", true, 16, 16);
				}
			}
		}

		if (y >= FlxG.height - height)
		{
			y = FlxG.height - height;
			acceleration.y = 0;
			if (!FlxG.keys.anyPressed([W, SPACE, UP]))
				velocity.y = 0;
		}
		else
			acceleration.y = 600;

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

		if (!rollin)
		{
			if (FlxMath.distanceBetween(this, player) > 22)
			{
				if (Math.abs(velocity.x) < 5)
				{
					animation.play('idle');
				}
				else if (velocity.x < -5)
					animation.play('walkL');
				else if (velocity.x > 5)
					animation.play('walkR');
			}
			else
			{
				if (player.x < x)
					animation.play('attackL');
				else if (player.x > x)
					animation.play('attackR');
			}
		}

		super.update(elapsed);
	}
}
