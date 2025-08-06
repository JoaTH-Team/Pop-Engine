package;

import flixel.FlxGame;
import flixel.system.FlxModding;
import flixel.util.FlxColor;
import hxluajit.Lua;
import hxluajit.LuaJIT;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		
		try {
			FlxModding.init(true, "assets", "content");
			Sys.println('Lua Project version: Lua (${Lua.VERSION}) - LuaJIT (${LuaJIT.VERSION})');

			addChild(new FlxGame(0, 0, ManagerState));
			addChild(new DebugCounter(2, 2, FlxColor.WHITE));
		} catch (e:Dynamic) {
			CrashHandler.handleCrash(e, "Failed to initialize Pop Engine");
		}
	}
}
