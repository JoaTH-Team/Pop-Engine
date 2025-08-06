package custom;

import flixel.input.keyboard.FlxKey;

class CustomFlxKey {
    public static var ANY:Int = -2;
    public static var NONE:Int = -1;
    public static var A:Int = 65;
    public static var B:Int = 66;
    public static var C:Int = 67;
    public static var D:Int = 68;
    public static var E:Int = 69;
    public static var F:Int = 70;
    public static var G:Int = 71;
    public static var H:Int = 72;
    public static var I:Int = 73;
    public static var J:Int = 74;
    public static var K:Int = 75;
    public static var L:Int = 76;
    public static var M:Int = 77;
    public static var N:Int = 78;
    public static var O:Int = 79;
    public static var P:Int = 80;
    public static var Q:Int = 81;
    public static var R:Int = 82;
    public static var S:Int = 83;
    public static var T:Int = 84;
    public static var U:Int = 85;
    public static var V:Int = 86;
    public static var W:Int = 87;
    public static var X:Int = 88;
    public static var Y:Int = 89;
    public static var Z:Int = 90;

    public static var ZERO:Int = 48;
    public static var ONE:Int = 49;
    public static var TWO:Int = 50;
    public static var THREE:Int = 51;
    public static var FOUR:Int = 52;
    public static var FIVE:Int = 53;
    public static var SIX:Int = 54;
    public static var SEVEN:Int = 55;
    public static var EIGHT:Int = 56;
    public static var NINE:Int = 57;

    public static var ENTER:Int = 13;
    public static var ESCAPE:Int = 27;
    public static var BACKSPACE:Int = 8;
    public static var SPACE:Int = 32;
    public static var SHIFT:Int = 16;
    public static var CONTROL:Int = 17;
    public static var ALT:Int = 18;
    public static var TAB:Int = 9;
    public static var DELETE:Int = 46;
    public static var PRINTSCREEN:Int = 301;

    public static var UP:Int = 38;
    public static var DOWN:Int = 40;
    public static var LEFT:Int = 37;
    public static var RIGHT:Int = 39;

    public static var F1:Int = 112;
    public static var F2:Int = 113;
    public static var F3:Int = 114;
    public static var F4:Int = 115;
    public static var F5:Int = 116;
    public static var F6:Int = 117;
    public static var F7:Int = 118;
    public static var F8:Int = 119;
    public static var F9:Int = 120;
    public static var F10:Int = 121;
    public static var F11:Int = 122;
    public static var F12:Int = 123;

    public static var NUMPADZERO:Int = 96;
    public static var NUMPADONE:Int = 97;
    public static var NUMPADTWO:Int = 98;
    public static var NUMPADTHREE:Int = 99;
    public static var NUMPADFOUR:Int = 100;
    public static var NUMPADFIVE:Int = 101;
    public static var NUMPADSIX:Int = 102;
    public static var NUMPADSEVEN:Int = 103;
    public static var NUMPADEIGHT:Int = 104;
    public static var NUMPADNINE:Int = 105;
    public static var NUMPADMINUS:Int = 109;
    public static var NUMPADPLUS:Int = 107;
    public static var NUMPADPERIOD:Int = 110;
    public static var NUMPADMULTIPLY:Int = 106;

    public static function fromString(key:String):Int {
        return FlxKey.fromString(key);
    }

    public static function toString(key:Int):String {
        return FlxKey.toStringMap.get(key);
    }
}