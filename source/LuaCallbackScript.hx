package;

import hxluajit.wrapper.LuaUtils;
import sys.io.File;

class LuaCallbackScript extends GameScript
{
    public function new(file:String) {
		super(null);

        set("LuaUtils", LuaUtils);
        set("vm", LuaScript.vm);
        set("LuaScript", LuaScript);

        set("addCallback", function (name:String, fn:Dynamic) {
            return LuaUtils.addFunction(LuaScript.vm, name, fn);
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