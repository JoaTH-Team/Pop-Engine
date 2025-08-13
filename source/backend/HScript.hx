package backend;

import crowplexus.iris.Iris;
import crowplexus.iris.IrisConfig.RawIrisConfig;
import sys.io.File;

using StringTools;

class HScript extends Iris
{
    final RawConfig:RawIrisConfig;

	public static var Function_Stop:Dynamic = 1;
	public static var Function_Continue:Dynamic = 0;

    public function new(FileName:String) {
        RawConfig = {autoPreset: true, autoRun: false, name: FileName.split('/').pop().split('\\').pop().split('.')[0]}
        
		super(File.getContent(FileName), RawConfig);

		set("Function_Stop", Function_Stop);
		set("Function_Continue", Function_Continue);
        
		set("FlxG", flixel.FlxG);
		set("FlxMath", flixel.math.FlxMath);
		set("FlxSprite", flixel.FlxSprite);
		set("FlxText", flixel.text.FlxText);
		set("FlxCamera", flixel.FlxCamera);
		set("FlxTimer", flixel.util.FlxTimer);
		set("FlxTween", flixel.tweens.FlxTween);
		set("FlxEase", flixel.tweens.FlxEase);
        set("FlxMath", flixel.math.FlxMath);
        set("FlxModding", flixel.system.FlxModding);
        set("FlxRuntimeShader", flixel.addons.display.FlxRuntimeShader);
        set("FlxWaveform", flixel.addons.display.waveform.FlxWaveform);
        set("FlxWaveformBuffer", flixel.addons.display.waveform.FlxWaveformBuffer);

        set("Paths", backend.Paths);
        set("GameState", states.GameState);
        
        set("PopSprite", objects.PopSprite);
        set("PopText", objects.PopText);
        
        set("game", states.GameState.instance);

        execute();
    }    
	override function call(fun:String, ?args:Array<Dynamic>):IrisCall
	{
		if (fun == null || !exists(fun))
			return null;
		return super.call(fun, args);
	}
}