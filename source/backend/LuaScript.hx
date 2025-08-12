package backend;

import hxluajit.wrapper.LuaUtils;
import objects.PopSprite;
import states.GameState;

class LuaScript {
    public static var taggedVariable:Map<String, Dynamic> = new Map<String, Dynamic>();

    public function new(FileName:String) {
        LuaUtils.addFunction(GameState.luaVM, "createSprite", function (tag:String, x:Float, y:Float, paths:String) {
            var sprite:PopSprite = new PopSprite(x, y, Paths.image(paths, true));
            sprite.active = true;
            return taggedVariable.set(tag, sprite);
        });

		LuaUtils.doFile(GameState.luaVM, FileName);
    }

    /**
     * USE FOR LUA ARRAY ONLY
     */
    public function callFunction(name:String, args:Array<Dynamic>) {
        return LuaUtils.callFunctionByName(GameState.luaVM, name, args);
    }
}