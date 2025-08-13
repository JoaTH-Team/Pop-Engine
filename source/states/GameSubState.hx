package states;

import backend.HScript;
import flixel.addons.ui.FlxUISubState;
import sys.FileSystem;

using StringTools;

class GameSubState extends FlxUISubState
{
	public static var instance:GameSubState;

	public var scriptArray:Array<HScript> = [];
	public var scriptState:HScript;
	public var stateName:String = '';

	public function new(file:String)
	{
		super();

		instance = this;

		stateName = file.split('/').pop().split('\\').pop().split('.')[0];

		scriptState = new HScript(Paths.data('states/${file}.hxs'));

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
						scriptArray.push(new HScript(fullPath));
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