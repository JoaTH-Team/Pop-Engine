package;

import hxluajit.wrapper.LuaUtils;
import sys.io.File;

class LuaCallbackScript extends GameScript
{
    public function new(file:String) {
		super(file);

        set("LuaUtils", LuaUtils);
        set("vm", LuaScript.vm);
        set("LuaScript", LuaScript);
		set("taggedVariable", LuaScript.taggedVariable);

        set("addCallback", function (name:String, fn:Dynamic) {
			trace("is this possible");
			return LuaScript.callbackStatic(name, fn);
        });
		set("withoutReturn", function(name:String, fn:Dynamic)
		{
			LuaUtils.addFunction(LuaScript.vm, name, fn);
		});

		trace(file);

		try
		{
			executeString(File.getContent(file));
		}
		catch (e:Dynamic)
		{
			CrashHandler.reportError(e, 'HScript loading: $file');
			throw e;
		}
	}
}