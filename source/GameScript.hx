package;

import custom.CustomFlxColor;
import custom.CustomFlxTextAlign;
import flixel.FlxG;
import joalor64gh.HScript;
import sys.io.File;

using StringTools;

class GameScript extends HScript
{
	public function syncVar()
	{
		if (LuaScript.taggedVariable == null)
			return;

		for (tag => value in LuaScript.taggedVariable)
		{
			try
			{
				set(tag, value);
			}
			catch (e:Dynamic)
			{
				CrashHandler.reportError(e, 'Failed to sycn all variable from Lua');
			}
		}
	}

    public function new(file:String) {
        super(file);

        initConfig(true);
        
        importFunc("flixel.FlxG");
        importFunc("flixel.FlxSprite");
        importFunc("flixel.FlxCamera");
        importFunc("flixel.FlxObject");
        importFunc("flixel.FlxBasic");
        importFunc("flixel.text.FlxText");
        importFunc("flixel.sound.FlxSound");
        importFunc("flixel.util.FlxTimer");
        importFunc("flixel.util.FlxSave");
        importFunc("flixel.math.FlxMath");
        importFunc("flixel.system.FlxModding");
		importFunc("flixel.system.FlxAssets");
        set("FlxRuntimeShader", flixel.addons.display.FlxRuntimeShader);
        set("FlxWaveform", flixel.addons.display.waveform.FlxWaveform);
        set("FlxWaveformBuffer", flixel.addons.display.waveform.FlxWaveformBuffer);

        importFunc("openfl.Lib");

        importFunc("lime.app.Application");

        importFunc("Paths");

        set("game", GameState.instance);
        set("import", importFunc);
        set("add", GameState.instance.add);
        set("remove", GameState.instance.remove);
        set("insert", GameState.instance.insert);

        set("FlxColor", CustomFlxColor);
        set("FlxTextAlign", CustomFlxTextAlign);

		syncVar();

        try {
            executeString(File.getContent(file));
        } catch (e:Dynamic) {
            CrashHandler.reportError(e, 'HScript loading: $file');
            throw e;
        }
    }

    function importFunc(daClass:String, ?asDa:String) {
		final splitClassName = [for (e in daClass.split('.')) e.trim()];
		final className = splitClassName.join('.');
		final daClassObj:Class<Dynamic> = Type.resolveClass(className);
		final daEnum:Enum<Dynamic> = Type.resolveEnum(className);

		if (daClassObj == null && daEnum == null)
			FlxG.stage.application.window.alert('Class / Enum at $className does not exist.', 'HScript Error!');
		else if (daEnum != null) {
			var daEnumField = {};
			for (daConstructor in daEnum.getConstructors())
				Reflect.setField(daEnumField, daConstructor, daEnum.createByName(daConstructor));
			set(asDa != null && asDa != '' ? asDa : splitClassName[splitClassName.length - 1], daEnumField);
		} else
			set(asDa != null && asDa != '' ? asDa : splitClassName[splitClassName.length - 1], daClassObj);
	}
}
