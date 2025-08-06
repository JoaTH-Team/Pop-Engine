package custom;

import flixel.util.FlxColor;

class CustomFlxColor {
    public static var BLACK:Int = FlxColor.BLACK;
    public static var BLUE:Int = FlxColor.BLUE;
    public static var BROWN:Int = FlxColor.BROWN;
    public static var CYAN:Int = FlxColor.CYAN;
    public static var GRAY:Int = FlxColor.GRAY;
    public static var GREEN:Int = FlxColor.GREEN;
    public static var LIME:Int = FlxColor.LIME;
    public static var MAGENTA:Int = FlxColor.MAGENTA;
    public static var ORANGE:Int = FlxColor.ORANGE;
    public static var PINK:Int = FlxColor.PINK;
    public static var PURPLE:Int = FlxColor.PURPLE;
    public static var RED:Int = FlxColor.RED;
    public static var TRANSPARENT:Int = FlxColor.TRANSPARENT;
    public static var WHITE:Int = FlxColor.WHITE;
    public static var YELLOW:Int = FlxColor.YELLOW;

    public static function add(color1:Int, color2:Int):Int {
        return FlxColor.add(color1, color2);
    }

    public static function fromCMYK(cyan:Float, magenta:Float, yellow:Float, black:Float):Int {
        return FlxColor.fromCMYK(cyan, magenta, yellow, black);
    }

    public static function fromHSB(hue:Float, saturation:Float, brightness:Float):Int {
        return FlxColor.fromHSB(hue, saturation, brightness);
    }

    public static function fromHSL(hue:Float, saturation:Float, lightness:Float):Int {
        return FlxColor.fromHSL(hue, saturation, lightness);
    }

    public static function fromInt(color:Int):Int {
        return FlxColor.fromInt(color);
    }

    public static function fromRGB(red:Int, green:Int, blue:Int):Int {
        return FlxColor.fromRGB(red, green, blue);
    }

    public static function fromRGBFloat(red:Float, green:Float, blue:Float):Int {
        return FlxColor.fromRGBFloat(red, green, blue);
    }

    public static function fromString(color:String):Int {
        return FlxColor.fromString(color);
    }

    public static function interpolate(color1:Int, color2:Int, factor:Float):Int {
        return FlxColor.interpolate(color1, color2, factor);
    }

    public static function to24Bit(color:Int):Int {
        return color & 0xffffff;
    }
}