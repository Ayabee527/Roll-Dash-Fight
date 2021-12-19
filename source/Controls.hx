package;

import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Controls extends FlxSubState
{
	override function create()
	{
		super.create();
		bgColor = FlxColor.BLACK;

		var cont = MainMenu.createText(75, [
			"[UP] to jump!",
			"[DOWN] to transform",
			"[LEFT AND RIGHT] to move",
			"[C] to attack",
			"[X] to dash in whatever",
			"direction youre holding"
		], [24, 24, 24, 24, 24, 24], [
			FlxColor.PINK,
			FlxColor.PINK,
			FlxColor.PINK,
			FlxColor.PINK,
			FlxColor.PINK,
			FlxColor.PINK
		], [
			FlxColor.PURPLE,
			FlxColor.PURPLE,
			FlxColor.PURPLE,
			FlxColor.PURPLE,
			FlxColor.PURPLE,
			FlxColor.PURPLE
		]);
		add(cont);

		var back = new FlxButton(10, 10, "Back!", function() close());
		add(back);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
