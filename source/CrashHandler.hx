package;

import flixel.FlxG;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

class CrashHandler
{
	/**
	 * Handles a fatal crash - shows message, logs it, and exits
	 * @param error The error that occurred
	 * @param message Optional description
	 */
    public static function handleCrash(error:Dynamic, ?message:String):Void
    {
		var errorText = message != null ? message : "Unknown crash";
        var details = Std.string(error);
        
		trace('CRASH: $errorText - $details');
		FlxG.stage.window.alert('Game error: $errorText\nDetails: $details', "Pop Engine Crash");

		logError('CRASH', errorText, details);

		Sys.exit(1);
	}
    
	/**
	 * Report a error during the game - show error context, error message and then make a pop-up, after that will create a .log file into the ./game-logs/
	 * @param error Error message
	 * @param context Error context
	 * @param showPopup Allow to show pop-up (Default is `true`)
	 */
	public static function reportError(error:Dynamic, ?context:String, showPopup:Bool = true):Void
	{
		var errorText = context != null ? context : "Error occurred";
		var details = Std.string(error);

		trace('ERROR: $errorText - $details');

		if (showPopup)
		{
			FlxG.stage.window.alert('Game error: $errorText\nDetails: $details', "Pop Engine Error");
		}
        
		logError('ERROR', errorText, details);
    }
    
	private static function logError(type:String, message:String, details:String):Void
	{
		try
		{
			if (!FileSystem.exists("game-logs"))
			{
				FileSystem.createDirectory("game-logs");
			}

			var timestamp = Date.now().toString().split(" ").join("_").split(":").join("-");
			var logFile = 'game-logs/${type}_$timestamp.log';

			var logContent = '$type: $message\n' + 'Time: ${Date.now()}\n' + 'Details: $details\n';

			File.saveContent(logFile, logContent);
        } catch (e:Dynamic) {
			trace("Failed to write log: " + e);
        }
    }
}