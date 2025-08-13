package states;

import backend.HScript;
import backend.LuaCallbackScript;
import backend.LuaScript;
import cpp.RawPointer;
import flixel.addons.ui.FlxUIState;
import hxluajit.LuaL;
import hxluajit.Types.Lua_State;
import sys.FileSystem;

using StringTools;

class GameState extends FlxUIState
{
    public static var instance:GameState = null;
    public static var luaVM:Null<RawPointer<Lua_State>> = null;

    public var luaArray:Array<LuaScript> = [];
    public var hscriptArray:Array<HScript> = [];
    public var luaCallbackScript:Array<HScript> = [];
    
    public var stateName:String = null;

    public var stateHScript:HScript;
    public var stateLua:LuaScript;

	public function new(stateFile:String)
	{
        instance = this;

        luaVM = LuaL.newstate();
        LuaL.openlibs(luaVM);

		stateName = stateFile.split('/').pop().split('\\').pop().split('.')[0];

		trace(stateFile);
		trace(stateName);

        super();

        var foldersToCheck:String = Paths.file('data/lua_more_callback/');
		if (FileSystem.exists(foldersToCheck) && FileSystem.isDirectory(foldersToCheck)) {
			for (file in FileSystem.readDirectory(foldersToCheck)) {
				var fullPath:String = foldersToCheck + file;
				if (file.endsWith('.hxs')) {
					luaCallbackScript.push(new LuaCallbackScript(fullPath));
				}
			}
		}

		if (stateFile.endsWith(".lua"))
        {
			stateLua = new LuaScript(stateFile);
        }
        else
        {
			stateHScript = new HScript(stateFile);
        }

		var foldersToCheck:Array<String> = [Paths.file('data/scripts/$stateName/')];
		for (folder in foldersToCheck)
		{
			if (FileSystem.exists(folder) && FileSystem.isDirectory(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					var fullPath:String = folder + file;
					if (file.endsWith('.hxs'))
					{
						hscriptArray.push(new HScript(fullPath));
					}
					else if (file.endsWith('.lua'))
					{
						luaArray.push(new LuaScript(fullPath));
					}
				}
			}
		}

		var foldersToCheck:Array<String> = [Paths.file('data/scripts/global/')];
		for (folder in foldersToCheck)
		{
			if (FileSystem.exists(folder) && FileSystem.isDirectory(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					var fullPath:String = folder + file;
					if (file.endsWith('.hxs'))
					{
						hscriptArray.push(new HScript(fullPath));
					}
					else if (file.endsWith('.lua'))
					{
						luaArray.push(new LuaScript(fullPath));
					}
				}
			}
		}

		stateLua.execute();
		stateHScript.execute();

        setCallback("new", []);
    }

    override function create() {
        super.create();

        setCallback("create", []);
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);

        setCallback("update", []);
    }

    override function draw() {
        super.draw();

        setCallback("draw", []);
    }

    override function destroy() {
        super.destroy();

        setCallback("destroy", []);

        if (stateHScript != null)
            stateHScript = null;

        if (stateLua != null)
            stateLua = null;
		for (i in hscriptArray)
		{
			i?.destroy();
		}
		for (i in luaCallbackScript)
		{
			i?.destroy();
		}
		for (i in luaArray)
		{
			i?.destroy();
		}
	}

	function setCallback(funcName:String, args:Array<Dynamic>)
	{
		callOnLuas(funcName, args);
		callOnScripts(funcName, args);
		if (stateHScript != null)
			stateHScript.call(funcName, args);

		if (stateLua != null)
			stateLua.callFunction(funcName, args);
	}

	private function callOnScripts(funcName:String, args:Array<Dynamic>):Dynamic
	{
		var value:Dynamic = HScript.Function_Continue;

		for (i in 0...hscriptArray.length)
		{
			final call:Dynamic = hscriptArray[i].call(funcName, args);
			final bool:Bool = call == HScript.Function_Continue;
			if (!bool && call != null)
				value = call;
		}

		for (i in 0...luaCallbackScript.length)
		{
			final call:Dynamic = luaCallbackScript[i].call(funcName, args);
			final bool:Bool = call == HScript.Function_Continue;
			if (!bool && call != null)
				value = call;
		}

		return value;
	}

	private function callOnLuas(funcName:String, args:Array<Dynamic>):Dynamic
	{
		var value:Dynamic = LuaScript.Function_Continue;

		for (i in 0...luaArray.length)
		{
			var ret:Dynamic = luaArray[i].callFunction(funcName, args);
			if (ret != LuaScript.Function_Continue)
				value = ret;
		}
		return value;
	}
}