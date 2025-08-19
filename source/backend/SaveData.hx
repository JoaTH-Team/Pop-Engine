package backend;

import flixel.FlxG;

class SaveData
{
    public static function bind(key:String, label:String):Void
    {
        FlxG.save.bind(key, label);
    }

    public static function reBindData(name:String):Bool
    {
        FlxG.save.bind(name, name);
        
        if (FlxG.save.data != null && Reflect.fields(FlxG.save.data).length > 0)
            return true;
            
        return false;
    }

    public static function flush():Void
    {
        FlxG.save.flush();
    }

    public static function getData(key:String):Dynamic
    {
        return Reflect.field(FlxG.save.data, key);
    }

    public static function setData(key:String, value:Dynamic):Void
    {
        Reflect.setField(FlxG.save.data, key, value);
    }
}