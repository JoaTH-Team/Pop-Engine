package backend;

import hxluajit.Lua;
import hxluajit.wrapper.LuaUtils;
import objects.PopSprite;
import states.GameState;
import sys.io.File;

class LuaScript {
    public static var taggedVariable:Map<String, Dynamic> = new Map<String, Dynamic>();

	public static var Function_Stop:Dynamic = 1;
	public static var Function_Continue:Dynamic = 0;

	var content:String = null;

    public function new(FileName:String) {
		content = File.getContent(FileName);

		LuaUtils.setVariable(GameState.luaVM, "Function_Stop", Function_Stop);
		LuaUtils.setVariable(GameState.luaVM, "Function_Continue", Function_Continue);

        LuaUtils.addFunction(GameState.luaVM, "createSprite", function (tag:String, x:Float, y:Float, paths:String) {
            var sprite:PopSprite = new PopSprite(x, y, Paths.image(paths, true));
            sprite.active = true;
            return taggedVariable.set(tag, sprite);
        });

		LuaUtils.addFunction(GameState.luaVM, "trace", function(data:Dynamic)
		{
			Sys.println('[LUA ($FileName)]: ${Std.string(data)}');
		});

		execute();
	}

	public function execute()
	{
		LuaUtils.doString(GameState.luaVM, content);
	}

	public function callFunction(name:String, args:Array<Dynamic>):Dynamic
	{
		if (GameState.luaVM == null)
			return Function_Continue;

		LuaUtils.callFunctionByName(GameState.luaVM, name, args);
		return Function_Continue;
	}

	public function destroy()
	{
		// return LuaUtils.cleanupStateFunctions(GameState.luaVM);
    }
}