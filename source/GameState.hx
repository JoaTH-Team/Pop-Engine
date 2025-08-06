package;

import flixel.FlxState;
import sys.FileSystem;

using StringTools;

class GameState extends FlxState
{
	var stateHScript:GameScript;
	var stateLua:LuaScript;

	// Array Content
	public var luaModuleScript:Array<LuaCallbackScript> = []; // this is gonna be funni
	public var scriptArray:Array<GameScript> = []; // store all .hxs file
	public var luaArray:Array<LuaScript> = []; // store all .lua file

	public static var instance:GameState = null;

	public function new(state:String) {
		instance = this;

		super();

		if (state.endsWith(".lua")) {
			stateLua = new LuaScript(state);
		} else {
			stateHScript = new GameScript(state);
		}

		// Script Folder check
		var foldersToCheck:String = Paths.file('data/scripts/');
		if (FileSystem.exists(foldersToCheck) && FileSystem.isDirectory(foldersToCheck)) {
			for (file in FileSystem.readDirectory(foldersToCheck)) {
				var fullPath:String = foldersToCheck + file;
				if (file.endsWith('.hxs')) {
					scriptArray.push(new GameScript(fullPath));
				} else if (file.endsWith('.lua')) {
					luaArray.push(new LuaScript(fullPath));
				}
			}
		}

		// Lua Module folder check
		var foldersToCheck:String = Paths.file('data/lua_more_callback/');
		if (FileSystem.exists(foldersToCheck) && FileSystem.isDirectory(foldersToCheck)) {
			for (file in FileSystem.readDirectory(foldersToCheck)) {
				var fullPath:String = foldersToCheck + file;
				if (file.endsWith('.hxs')) {
					luaModuleScript.push(new LuaCallbackScript(fullPath));
				}
			}
		}
		
		callFunction("new", []);
	}

	override public function create()
	{
		super.create();

		callFunction("create", []);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		callFunction("update", [elapsed]);
	}

	override function draw() 
	{
		super.draw();

		callFunction("draw", []);
	}
	
	override public function destroy()
	{
		callFunction("destroy", []);
		
		if (stateLua != null) {
			LuaScript.cleanupAll();
			stateLua = null;
		}
		
		if (stateHScript != null) {
			stateHScript = null;
		}
		
		super.destroy();
	}

	function callFunction(func:String, args:Array<Dynamic>) {
		try {
			if (stateHScript != null)
				stateHScript.call(func, args);
			if (stateLua != null)
				stateLua.callFunction(func, args);
			if (scriptArray != null || luaArray != null || luaModuleScript != null) 
			{
				for (i in scriptArray)
					i?.call(func, args);

				for (i in luaArray)
					i?.callFunction(func, args);

				for (i in luaModuleScript)
					i?.call(func, args);
			}
		} catch (e:Dynamic) {
			CrashHandler.reportError(e, 'Script function call: $func');
			trace('Script error in $func: $e');
		}
	}
}
