package backend;

import flixel.FlxG;
import flixel.system.FlxModding;
import states.GameState;

class Argument {
    public static function parseCommand(args:Array<String>):Bool {
        switch (args[0]) {
            default:
                return false;
            case "run":
                Paths.dirPath = FlxModding.get(args[1]).directory();
				FlxG.switchState(() -> new GameState("FirstState"));
                return true;
        }
    }
}