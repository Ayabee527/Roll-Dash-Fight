package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Shop extends FlxSubState
{
	var defense:FlxText;
	var attack:FlxText;
	var powGain:FlxText;
	var powLoss:FlxText;

	var defCost:Int;
	var attCost:Int;
	var pGCost:Int;
	var pLCost:Int;

	public static var defLvl:Int;
	public static var attLvl:Int;
	public static var pGLvl:Int;
	public static var pLLvl:Int;

	var buys:Array<FlxText>;
	var buyCosts:Array<Int>;
	var levels:Array<Int>;

	var curSelected:Int = 0;

	public static var boughts:Int = 1;

	var kills:FlxText;

	override function create()
	{
		super.create();

		bgColor = 0xFF000000;

		kills = new FlxText(0, 10, 0, "Kills: 0", 16);
		kills.x = FlxG.width - kills.width - 10;
		kills.color = FlxColor.WHITE;
		kills.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.GRAY, kills.size / 4);
		add(kills);

		defense = new FlxText(0, 0, 0, "Defense [Cost: 5]", 24);
		attack = new FlxText(0, 0, 0, "Attack [Cost: 5]", 24);
		powGain = new FlxText(0, 0, 0, "Power Gain [Cost: 5]", 24);
		powLoss = new FlxText(0, 0, 0, "Power Loss [Cost: 5]", 24);

		defense.y = FlxG.height / 4;
		attack.y = defense.y + defense.height + 15;
		powGain.y = attack.y + attack.height + 15;
		powLoss.y = powGain.y + powGain.height + 15;

		buys = [defense, attack, powGain, powLoss];
		buyCosts = [defCost, attCost, pGCost, pLCost];
		levels = [defLvl, attLvl, pGLvl, pLLvl];

		for (text in buys)
		{
			text.color = FlxColor.CYAN;
			text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLUE, text.size / 4);
			add(text);
		}

		var backButt = new FlxButton(10, 10, "Back", function()
		{
			close();
			FlxG.switchState(new MainMenu());
		});
		add(backButt);
	}

	override function update(elapsed:Float)
	{
		if (PlayState.enemsKilled == null)
			kills.text = "Kills: 0";
		else
			kills.text = "Kills: " + PlayState.enemsKilled;

		for (text in buys)
			text.x = FlxG.width / 2 - text.width / 2;

		kills.x = FlxG.width - kills.width - 10;

		if (FlxG.keys.justPressed.DOWN)
		{
			if (curSelected == buys.length - 1)
				curSelected = 0;
			else
				curSelected++;
		}
		else if (FlxG.keys.justPressed.UP)
		{
			if (curSelected == 0)
				curSelected = buys.length - 1;
			else
				curSelected--;
		}

		for (index in 0...buys.length)
		{
			if (curSelected == index)
			{
				buys[index].color = FlxColor.ORANGE;
				buys[index].borderColor = FlxColor.RED;
			}
			else
			{
				buys[index].color = FlxColor.CYAN;
				buys[index].borderColor = FlxColor.BLUE;
			}
		}

		for (index in 0...buyCosts.length)
		{
			buyCosts[index] = Std.int(Math.pow(boughts, 2));
		}

		defense.text = "Defense [Cost: " + buyCosts[0] + "] Level: " + Player.defense;
		attack.text = "Attack [Cost: " + buyCosts[1] + "] Level: " + Player.attack;
		powGain.text = "Power Gain [Cost: " + buyCosts[2] + "] Level: " + Player.powGain;
		powLoss.text = "Power Loss [Cost: " + buyCosts[3] + "] Level: " + Player.powLoss;

		if (FlxG.keys.justPressed.ENTER)
		{
			if (PlayState.enemsKilled >= buyCosts[0])
			{
				FlxG.camera.flash(FlxColor.WHITE, 0.5);
				boughts++;

				switch (curSelected)
				{
					case 0:
						Player.defense++;
						levels[0]++;
					case 1:
						Player.attack++;
						levels[1]++;
					case 2:
						Player.powGain++;
						levels[2]++;
					case 3:
						Player.powLoss++;
						levels[3]++;
				}
			}
			else
			{
				FlxG.camera.shake(0.01, 0.1);
			}
		}

		super.update(elapsed);
	}
}
