package backend;

import flixel.system.scripting.FlxHScript;

/**
 * HScriptFlixel is a extends class `FlxHScript` of the `flixel-modding` library
 * 
 * Is on working yooo
 */
class HScriptFlixel extends FlxHScript
{
    public function new(FileName:String) {
        super(FileName);
    }

    public function call(funcName:String, funcArgs:Array<Dynamic>) {
        if (interp.variables.exists(funcName)) {
            try {
                return Reflect.callMethod(this, interp.variables.get(funcName), funcArgs == null ? [] : funcArgs);
            }
        }
        return null;
    }
}