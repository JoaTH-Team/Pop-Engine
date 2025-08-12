package backend;

import hxluajit.wrapper.LuaUtils;
import states.GameState;

class LuaCallbackScript extends HScript
{
    public function new(FileName:String) {
        super(Paths.data('lua_more_callback/$FileName'));

        set("LuaUtils", LuaUtils);
        set("addCallback", function (name:String, fun:Dynamic) {
            return LuaUtils.addFunction(GameState.luaVM, name, fun);
        });

        execute();
    }    
}