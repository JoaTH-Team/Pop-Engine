package backend;

import flixel.addons.display.FlxRuntimeShader;
import flixel.addons.display.waveform.FlxWaveform;
import flixel.system.FlxAssets.FlxShader;
import flixel.system.scripting.FlxHScript;
import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;
import objects.PopSprite;
import objects.PopText;
import states.GameState;
import states.GameSubState;

/**
 * HScriptFlixel is a extends class `FlxHScript` of the `flixel-modding` library
 * 
 * Is on working yooo
 */
class HScriptFlixel extends FlxHScript
{
    public function new(FileName:String) {
        super(FileName);
		// Video
		FlxHScript.setGlobalVariable("FlxVideoSprite", FlxVideoSprite);
		FlxHScript.setGlobalVariable("FlxVideo", FlxVideo);
		FlxHScript.setGlobalVariable("FlxWaveform", FlxWaveform);
		FlxHScript.setGlobalVariable("FlxRuntimeShader", FlxRuntimeShader);
		FlxHScript.setGlobalVariable("FlxShader", FlxShader);

		setVariable("CustomState", GameState);
		setVariable("GameState", GameState);
		setVariable("CustomSubState", GameSubState);
		setVariable("GameSubState", GameSubState);
		setVariable("PopSprite", PopSprite);
		setVariable("PopText", PopText);
		setVariable("Paths", Paths);
		setVariable("GameVar", GameVar);

		setVariable("state", GameState.instance);
		setVariable("subState", GameSubState.instance);

		setVariable("setVar", GameVar.setVar);
		setVariable("getVar", GameVar.getVar);
		setVariable("removeVar", GameVar.removeVar);
		setVariable("existsVar", GameVar.existsVar);
		setVariable("clearVar", GameVar.clearVar);

		loadGlobals();
    }

    public function call(funcName:String, funcArgs:Array<Dynamic>) {
        if (interp.variables.exists(funcName)) {
            try {
                return Reflect.callMethod(this, interp.variables.get(funcName), funcArgs == null ? [] : funcArgs);
            }
        }
        return null;
    }
}