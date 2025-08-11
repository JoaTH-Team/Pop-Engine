package;

import flixel.FlxGame;
import flixel.system.FlxModding;
import openfl.display.Sprite;

class Main extends Sprite
{
	var game:FlxGame;

	public function new()
	{
		super();

		FlxModding.init(true, "assets", "content");

		game = new FlxGame(0, 0, states.ManagerState, 60, 60, false, false);
		addChild(game);
	}
}