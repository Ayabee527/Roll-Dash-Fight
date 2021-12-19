package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	var player:Player;
	var enem:Enemy;
	var hud:HUD;

	public static var enemsKilled:Int;

	override public function create()
	{
		super.create();
		bgColor = FlxColor.GRAY;

		player = new Player(100, FlxG.height - 100);
		add(player);

		enem = new Enemy(FlxG.width - 100, FlxG.height - 100, player);
		add(enem);

		hud = new HUD(player, enem);
		add(hud);
	}

	override public function update(elapsed:Float)
	{
		FlxSpriteUtil.bound(player);

		hud.updateHUD(enemsKilled);

		if (!player.alive)
		{
			if (!player.dead)
			{
				player.dead = true;
				openSubState(new GameOver());
			}
		}

		if (FlxG.overlap(enem, player))
		{
			if (FlxG.keys.justPressed.C)
			{
				if (!player.rollin && !player.dashing)
				{
					enem.hurt(5 * ((1) + (0.25 * Player.attack)));
				}
			}
		}

		if (FlxG.keys.pressed.C)
		{
			if (!player.rollin)
			{
				if (enem.x < player.x)
					player.animation.play('attackL', true);
				else if (enem.x >= player.x)
					player.animation.play('attackR', true);
			}
		}

		if (FlxMath.distanceBetween(enem, player) < 22 && !FlxFlicker.isFlickering(player))
		{
			if (!player.rollin && !player.dashing)
			{
				FlxFlicker.flicker(player);
				player.hurt((10 * ((1) + (.1 * enemsKilled))) / ((1) + (0.25 * Player.defense)));
			}
		}

		if (enem.rollin || player.rollin)
		{
			FlxG.collide(enem, player);
			if (FlxG.overlap(enem, player))
			{
				if (enem.alive)
				{
					player.hurt(Math.abs(enem.angularVelocity / 1000));
					enem.hurt(Math.abs(player.angularVelocity / 1000));
				}
			}
		}

		if (!FlxFlicker.isFlickering(player))
			player.hurt(-0.1);

		enem.hurt(-0.1 * ((1) + (.01 * enemsKilled)));

		if (enem.health <= 10)
		{
			enemsKilled++;
			enem.setPosition(FlxG.width - 100, FlxG.height - 100);
			enem.hurt(-enem.maxHealth);
			// remove(enem);
			// enem = new Enemy(FlxG.width - 100, FlxG.height - 100, player);
			// add(enem);
		}

		player.health = FlxMath.bound(player.health, 0, player.maxHealth);
		enem.health = FlxMath.bound(enem.health, 0, enem.maxHealth);

		player.power = FlxMath.bound(player.power, 0, player.maxPower);
		enem.power = FlxMath.bound(enem.power, 0, enem.maxPower);

		super.update(elapsed);
	}
}
