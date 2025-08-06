package;

import sys.FileSystem;
import sys.io.File;

class CrashHandler
{
    public static function handleCrash(error:Dynamic, ?message:String):Void
    {
        var errorText = message != null ? message : "Unknown error";
        var details = Std.string(error);
        
        // Save crash info to file
        var crashInfo = 'CRASH: $errorText\nDetails: $details\nTime: ${Date.now()}\n\n';
        
        try {
            var existingLog = FileSystem.exists("crash_log.txt") ? File.getContent("crash_log.txt") : "";
            File.saveContent("crash_log.txt", crashInfo + existingLog);
        } catch (e:Dynamic) {
            trace("Could not save crash log");
        }
        
        // Show simple error message
        trace('CRASH: $errorText - $details');
        
        #if windows
        Sys.command('msg * "Pop Engine crashed: $errorText"');
        #end
        
        // Exit
        Sys.exit(1);
    }
    
    public static function reportError(error:Dynamic, ?context:String):Void
    {
        var msg = context != null ? '$context: $error' : Std.string(error);
        trace('ERROR: $msg');
        
        try {
            var existingLog = FileSystem.exists("error_log.txt") ? File.getContent("error_log.txt") : "";
            File.saveContent("error_log.txt", '${Date.now()}: $msg\n' + existingLog);
        } catch (e:Dynamic) {
            Sys.println("Error log: " + Std.string(e));
        }
    }
}
