package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MainMenu extends FlxState
{
	var highText:FlxText;

	override function create()
	{
		super.create();

		var tit = createText((FlxG.height / 2) - 32, ["Roll, Dash, Fight!"], [32], [FlxColor.CYAN], [FlxColor.BLUE]);
		add(tit);

		var playButt = new FlxButton(0, 0, "Play!", function() FlxG.switchState(new PlayState()));
		var shopButt = new FlxButton(0, 0, "Shop!", function() openSubState(new Shop()));
		var contButt = new FlxButton(0, 0, "Controls!", function() openSubState(new Controls()));

		contButt.x = shopButt.x = playButt.x = FlxG.width / 2 - playButt.width / 2;

		playButt.y = (2 * FlxG.height / 3) - playButt.height / 2;
		shopButt.y = playButt.y + playButt.height + 5;
		contButt.y = shopButt.y + shopButt.height + 5;

		add(playButt);
		add(shopButt);
		add(contButt);

		highText = new FlxText(0, 20, 0, "Highscore: 0", 16);
		highText.x = FlxG.width / 2 - highText.width / 2;
		add(highText);
	}

	public static function createText(initY:Float = 150, array:Array<String>, sizeArr:Array<Int>, colArr:Array<FlxColor>, shadColArr:Array<FlxColor>)
	{
		if (array.length == 0)
			array = ['Hello', 'World'];
		if (sizeArr.length == 0)
			sizeArr = [16];
		if (colArr.length == 0)
			colArr = [FlxColor.WHITE];
		if (shadColArr.length == 0)
			shadColArr = [FlxColor.GRAY];

		var group = new FlxTypedGroup<FlxText>();

		var last = new FlxText(0, 0, 0, "", sizeArr[0]);
		last.x = FlxG.width / 2 - last.width / 2;
		last.y = initY - last.height;
		group.add(last);

		for (i in 0...array.length)
		{
			var col = colArr[i];
			var shadCol = shadColArr[i];
			var size = sizeArr[i];

			var text = new FlxText(0, 0, 0, array[i], size);
			text.x = FlxG.width / 2 - text.width / 2;
			text.y = last.y + last.height + 5;
			text.color = col;
			text.setBorderStyle(FlxTextBorderStyle.SHADOW, shadCol, size / 4);
			group.add(text);
			last = text;
		}

		return group;
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
			FlxG.switchState(new PlayState());

		highText.text = "Highscore: " + PlayState.enemsKilled;

		super.update(elapsed);
	}
}
