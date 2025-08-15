package states;

import backend.HScriptIris;
import flixel.addons.ui.FlxUIState;
import sys.FileSystem;

using StringTools;

class GameState extends FlxUIState
{
	public static var instance:GameState;

	public var scriptArray:Array<HScriptIris> = [];
	public var scriptState:HScriptIris;
	public var stateName:String = '';

	public function new(file:String)
	{
		super();

		instance = this;

		stateName = file.split('/').pop().split('\\').pop().split('.')[0];

		scriptState = new HScriptIris(Paths.data('states/${file}.hxs'));

		var foldersToCheck:Array<String> = [Paths.file('data/scripts/$stateName/'), Paths.file('data/scripts/global/')];
		for (folder in foldersToCheck)
		{
			if (FileSystem.exists(folder) && FileSystem.isDirectory(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					var fullPath:String = folder + file;
					if (file.endsWith('.hxs'))
					{
						scriptArray.push(new HScriptIris(fullPath));
					}
				}
			}
		}

		callFunction("new", []);
    }

    override function create() {
		super.create();

		callFunction("create", []);
    }    

    override function update(elapsed:Float) {
		super.update(elapsed);

		callFunction("update", [elapsed]);
	}

	override function draw()
	{
		super.draw();

		callFunction("draw", []);
	}

	override function destroy()
	{
		super.destroy();

		callFunction("destroy", []);

		scriptState.destroy();
		for (script in scriptArray)
			script?.destroy();
	}

	public function callFunction(name:String, args:Array<Dynamic>)
	{
		for (script in scriptArray)
			script?.call(name, args);
		scriptState.call(name, args);
	}
}