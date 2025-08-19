package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.FlxModding;
import haxe.CallStack;
import haxe.io.Path;
import openfl.display.Sprite;
import openfl.events.UncaughtErrorEvent;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class Main extends Sprite
{
	var game:FlxGame;

	public function new()
	{
		super();

		FlxModding.init(true, "assets", "content");

		hxvlc.util.Handle.init();

		SaveData.bind("PopEngineData", "Pop Engine Data");
		SaveData.reBindData("hscriptType");
		SaveData.reBindData("disableOverlayGrid");

		game = new FlxGame(0, 0, states.ManagerState, 60, 60, false, false);
		addChild(game);
		FlxG.mouse.useSystemCursor = true;
		FlxG.game.focusLostFramerate = 60;

		FlxG.stage.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);

		FlxG.signals.gameResized.add(function(w, h)
		{
			if (FlxG.cameras != null)
			{
				for (cam in FlxG.cameras.list)
				{
					if (cam != null && cam.filters != null)
						resetSpriteCache(cam.flashSprite);
				}
			}
			if (FlxG.game != null)
				resetSpriteCache(FlxG.game);
		});
	}

	static function resetSpriteCache(sprite:Sprite):Void
	{
		@:privateAccess {
			sprite.__cacheBitmap = null;
			sprite.__cacheBitmapData = null;
		}
	}

	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "PopEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error;
		// remove if you're modding and want the crash log message to contain the link
		// please remember to actually modify the link for the github page to report the issues to.
		#if officialBuild
		errMsg += "\nPlease report this error to the GitHub page: https://github.com/JoaTH-Team/Pop-Engine";
		#end
		errMsg += "\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		FlxG.stage.window.alert(errMsg, "Error!");
		Sys.exit(1);
	}
}