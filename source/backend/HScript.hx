package backend;

import crowplexus.hscript.Interp.LocalVar;
import crowplexus.iris.Iris;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxRuntimeShader;
import flixel.addons.display.waveform.FlxWaveform;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.system.FlxAssets.FlxShader;
import flixel.system.FlxAssets;
import flixel.system.FlxModding;
import flixel.text.FlxText;
import flixel.util.FlxSave;
import objects.PopSprite;
import objects.PopText;
import states.GameState;
import states.GameSubState;
import sys.io.File;

using StringTools;

class HScript extends Iris
{
	var locals(get, set):Map<String, LocalVar>;

	function get_locals():Map<String, LocalVar>
	{
		var result:Map<String, LocalVar> = new Map();
		@:privateAccess
		for (key in interp.locals.keys())
		{
			result.set(key, {r: interp.locals.get(key).r, const: interp.locals.get(key).const});
		}
		return result;
	}

	function set_locals(local:Map<String, LocalVar>)
	{
		@:privateAccess
		interp.locals = local;
		return local;
	}

	public function getAll():Dynamic
	{
		var result:Dynamic = {};
		@:privateAccess
		if (interp != null && interp.locals != null)
		{
			for (i in interp.locals.keys())
			{
				var value = interp.locals.get(i).r;
				if (value != null)
					Reflect.setField(result, i, value);
			}
		}

		if (interp != null && interp.variables != null)
		{
			for (i in interp.variables.keys())
			{
				if (!Reflect.hasField(result, i))
				{
					var value = interp.variables.get(i);
					if (value != null)
						Reflect.setField(result, i, value);
				}
			}
		}

		return result;
	}

	public function new(FileName:String)
	{
		super(File.getContent(FileName));

		config.autoPreset = true;
		config.autoRun = false;
		config.name = FileName;
		config.packageName = FileName;

		set("importScript", function(scriptFile:String)
		{
			var hscript:HScript = new HScript(scriptFile);
			hscript.execute();
			GameState.instance.scriptArray.push(hscript);
			return hscript.getAll();
		});

		set("CustomState", GameState);
		set("GameState", GameState);
		set("CustomSubState", GameSubState);
		set("GameSubState", GameSubState);
		set("PopSprite", PopSprite);
		set("PopText", PopText);
		set("Paths", Paths);

		set("FlxG", FlxG);
		set("FlxSprite", FlxSprite);
		set("FlxText", FlxText);
		set("FlxCamera", FlxCamera);
		set("FlxModding", FlxModding);
		set("FlxRuntimeShader", FlxRuntimeShader);
		set("FlxShader", FlxShader);
		set("FlxMath", FlxMath);
		set("FlxSave", FlxSave);
		set("FlxSound", FlxSound);
		set("FlxObject", FlxObject);
		set("FlxBasic", FlxBasic);
		set("FlxAssets", FlxAssets);
		set("FlxWaveform", FlxWaveform);

		set("state", GameState.instance);
		set("subState", GameSubState.instance);

		execute();
	}

	override function call(fun:String, ?args:Array<Dynamic>):IrisCall
	{
		if (fun == null || !exists(fun))
			return null;
		return super.call(fun, args);
	}
}