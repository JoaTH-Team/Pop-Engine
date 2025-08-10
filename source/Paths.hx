package;

import flixel.FlxG;
import flixel.system.FlxModding;

class Paths {
    public static var dirPath:String = "assets/";

    inline public static function file(name:String) {
        return '$dirPath/$name';
    }

    inline public static function image(name:String, cache:Bool = true) {
        return FlxModding.system.getBitmapData(file('images/$name.png'), cache);
    }

    inline public static function sound(name:String, cache:Bool = true) {
        if (cache)
            FlxG.sound.cache(dirPath + "sounds/" + name + ".ogg");
        return file('sounds/$name.ogg');
    }

    inline public static function music(name:String, cache:Bool = true) {
        if (cache)
            FlxG.sound.cache(dirPath + "music/" + name + ".ogg");
        return file('music/$name.ogg');
    }

    inline public static function data(name:String) {
        return file('data/$name');
    }
	inline public static function video(name:String)
	{
		return file('videos/$name.mp4');
	}

	inline public static function fonts(name:String)
	{
		return file('fonts/$name');
	}
}