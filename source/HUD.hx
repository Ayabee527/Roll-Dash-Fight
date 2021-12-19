package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class HUD extends FlxGroup
{
	var eHealthBar:FlxBar;
	var pHealthBar:FlxBar;

	var ePowBar:FlxBar;
	var pPowBar:FlxBar;

	var killedText:FlxText;

	var eHealthText:FlxText;
	var ePowText:FlxText;

	var pHealthText:FlxText;
	var pPowText:FlxText;

	override public function new(player:Player, enem:Enemy)
	{
		super();

		pHealthBar = new FlxBar(10, 10, LEFT_TO_RIGHT, 200, 20, player, "health", 0, player.maxHealth, true);
		pHealthBar.createGradientBar([FlxColor.ORANGE, FlxColor.RED], [FlxColor.GREEN, FlxColor.LIME], 1, 180, true);
		add(pHealthBar);

		eHealthBar = new FlxBar(0, 10, RIGHT_TO_LEFT, 200, 20, enem, "health", 0, enem.maxHealth, true);
		eHealthBar.x = FlxG.width - eHealthBar.width - 10;
		eHealthBar.createGradientBar([FlxColor.RED, FlxColor.ORANGE], [FlxColor.LIME, FlxColor.GREEN], 1, 180, true);
		add(eHealthBar);

		pPowBar = new FlxBar(10, pHealthBar.y + pHealthBar.height + 25, BOTTOM_TO_TOP, 20, 150, player, "power", 0, player.maxPower, true);
		pPowBar.createGradientBar([FlxColor.RED, FlxColor.ORANGE], [FlxColor.LIME, FlxColor.GREEN], 1, 270, true);
		add(pPowBar);

		ePowBar = new FlxBar(0, eHealthBar.y + eHealthBar.height + 25, BOTTOM_TO_TOP, 20, 150, enem, "power", 0, enem.maxPower, true);
		ePowBar.x = FlxG.width - ePowBar.width - 10;
		ePowBar.createGradientBar([FlxColor.RED, FlxColor.ORANGE], [FlxColor.LIME, FlxColor.GREEN], 1, 270, true);
		add(ePowBar);

		killedText = new FlxText(0, 0, 0, "Killed Enemies: 0", 16);
		killedText.x = FlxG.width / 2 - killedText.width / 2;
		killedText.y = 200 - killedText.height / 2;
		add(killedText);

		pHealthText = new FlxText(0, 0, 0, "Your Health", 16);
		pHealthText.x = pHealthBar.getGraphicMidpoint().x - pHealthText.width / 2;
		pHealthText.y = pHealthBar.getGraphicMidpoint().y - pHealthText.height / 2;
		add(pHealthText);

		eHealthText = new FlxText(0, 0, 0, "Enemy Health", 16);
		eHealthText.x = eHealthBar.getGraphicMidpoint().x - eHealthText.width / 2;
		eHealthText.y = eHealthBar.getGraphicMidpoint().y - eHealthText.height / 2;
		add(eHealthText);

		pPowText = new FlxText(0, 0, 16, "Power", 16);
		pPowText.x = pPowBar.getGraphicMidpoint().x - pPowText.width / 2;
		pPowText.y = pPowBar.getGraphicMidpoint().y - pPowText.height / 2;
		add(pPowText);

		ePowText = new FlxText(0, 0, 16, "Power", 16);
		ePowText.x = ePowBar.getGraphicMidpoint().x - ePowText.width / 2;
		ePowText.y = ePowBar.getGraphicMidpoint().y - ePowText.height / 2;
		add(ePowText);
	}

	public function updateHUD(enemsKilled:Int)
	{
		if (enemsKilled == null)
			killedText.text = "Killed Enemies: 0";
		else
			killedText.text = "Killed Enemies: " + enemsKilled;
		killedText.x = FlxG.width / 2 - killedText.width / 2;
		killedText.y = 200 - killedText.height / 2;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
