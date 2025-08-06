package;

import hxluajit.wrapper.LuaUtils;

class LuaCallbackScript extends GameScript
{
    public function new(file:String) {
        super(file);

        set("LuaUtils", LuaUtils);
        set("vm", LuaScript.vm);
        set("LuaScript", LuaScript);

        set("addCallback", function (name:String, fn:Dynamic) {
            return LuaUtils.addFunction(LuaScript.vm, name, fn);
        });
    }    
}