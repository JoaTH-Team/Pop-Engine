package states;

import backend.HScript;
import backend.LuaCallbackScript;
import backend.LuaScript;
import cpp.RawPointer;
import flixel.addons.ui.FlxUIState;
import hxluajit.LuaL;
import hxluajit.Types.Lua_State;
import hxluajit.wrapper.LuaUtils;
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

    public function new(state:String) {
        instance = this;

        luaVM = LuaL.newstate();
        LuaL.openlibs(luaVM);

        stateName = state.split('/').pop().split('\\').pop().split('.')[0];

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

        if (state.endsWith(".lua"))
        {
            stateLua = new LuaScript(state);
        }
        else
        {
            stateHScript = new HScript(state);
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
    }

    function setCallback(name:String, args:Array<Dynamic>) {
		if (stateHScript != null)
			stateHScript.call(name, args);
		if (stateLua != null)
			stateLua.callFunction(name, args);
		if (hscriptArray != null || luaArray != null || luaCallbackScript != null) 
		{
			for (i in hscriptArray)
				i?.call(name, args);
			for (i in luaArray)
                i?.callFunction(name, args);
			for (i in luaCallbackScript)
				i?.call(name, args);    
        }    
    }
}