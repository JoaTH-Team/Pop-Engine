package backend;

import flixel.FlxG;
import flixel.system.FlxModding;
import states.GameState;

using StringTools;

class Argument {
	public static var hscriptType:String = "iris";

    public static function parseCommand(args:Array<String>):Bool {
		if (args.length == 0)
			return false;

		for (i in 0...args.length)
		{
			if (args[i] == "use" && i + 1 < args.length && args[i + 1].startsWith("hscript="))
			{
				var type = args[i + 1].substring("hscript=".length);
				if (type == "flixel" || type == "iris")
				{
					hscriptType = type;
				}
				args.splice(i, 2);
			}
		}

		if (args.length == 0)
			return false;
        
        switch (args[0]) {
            default:
                return false;
            case "run":
				if (args.length < 2)
					return false;
                Paths.dirPath = FlxModding.get(args[1]).directory();
				FlxG.switchState(() -> new GameState("FirstState"));
                return true;
        }
    }
}