package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class GameOver extends FlxSubState
{
	override function create()
	{
		bgColor = 0xDD000000;

		var mocks = [
			"Better luck next time!",
			"Oof",
			"Try again, youll do better im sure",
			"Damn, get rekt",
			"You should buy stuff from the shop"
		];

		var tit = MainMenu.createText((FlxG.height / 2) - 32, ["You Died!", " ", mocks[FlxG.random.int(0, mocks.length - 1)]], [32, 16, 16],
			[FlxColor.CYAN, FlxColor.WHITE, FlxColor.ORANGE], [FlxColor.BLUE, FlxColor.GRAY, FlxColor.RED]);
		add(tit);

		var shopButt = new FlxButton(0, 0, "Shop!", function() openSubState(new Shop()));
		shopButt.x = (FlxG.width / 3) - shopButt.width / 2;
		shopButt.y = (4 * FlxG.height / 5) - shopButt.height / 2;
		add(shopButt);

		var restartButt = new FlxButton(0, 0, "Restart!", function()
		{
			FlxG.resetState();
			close();
		});
		restartButt.x = (4 * FlxG.width / 5) - restartButt.width - restartButt.width / 2;
		restartButt.y = shopButt.y;
		add(restartButt);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
