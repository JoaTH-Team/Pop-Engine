package backend;

import crowplexus.hscript.Interp.LocalVar;
import crowplexus.iris.Iris;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxRuntimeShader;
import flixel.addons.display.waveform.FlxWaveform;
import flixel.effects.FlxFlicker;
import flixel.group.FlxContainer;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.system.FlxAssets.FlxShader;
import flixel.system.FlxAssets;
import flixel.system.FlxModding;
import flixel.text.FlxInputText;
import flixel.text.FlxText;
import flixel.util.FlxSave;
import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;
import objects.PopSprite;
import objects.PopText;
import popengine.FlxScriptColor;
import states.GameState;
import states.GameSubState;
import sys.io.File;

using StringTools;

/**
 * HScript Iris is a Iris extends of the `hscript-iris` library
 * 
 * Is a default HScript classes use on Pop Engine
 */
class HScriptIris extends Iris
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

		parser.allowJSON = parser.allowMetadata = parser.allowTypes = true;

		set("importScript", function(scriptFile:String)
		{
			var hscript:HScriptIris = new HScriptIris(backend.Paths.data('$scriptFile.hxs'));
			hscript.execute();
			hscript.getAll();
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
		set("GameVar", GameVar);

		set("FlxG", FlxG);
		set("FlxSprite", FlxSprite);
		set("FlxText", FlxText);
		set("FlxInputText", FlxInputText);
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
		set("FlxVideoSprite", FlxVideoSprite);
		set("FlxVideo", FlxVideo);
		set("FlxColor", FlxScriptColor);
		set("FlxGroup", FlxGroup);
		set("FlxTypedGroup", FlxTypedGroup);
		set("FlxContainer", FlxContainer);
		set("FlxSpriteGroup", FlxSpriteGroup);
		set("FlxFlicker", FlxFlicker);
		set("FlxBackdrop", FlxBackdrop);

		set("state", GameState.instance);
		set("subState", GameSubState.instance);

		set("setVar", GameVar.setVar);
		set("getVar", GameVar.getVar);
		set("removeVar", GameVar.removeVar);
		set("existsVar", GameVar.existsVar);
		set("clearVar", GameVar.clearVar);

		execute();
	}

	override function call(fun:String, ?args:Array<Dynamic>):IrisCall
	{
		if (fun == null || !exists(fun))
			return null;
		return super.call(fun, args);
	}
}