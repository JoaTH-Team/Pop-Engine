# HScript Code API
> Right now this documment wiki is only work on `v1.0.0`, `v2.0.0` is a reworked version

Some hscript stuff, also check [Example code from Pop Engine](Example.md) for more detail

## Classes are imported
- HaxeFlixel: `FlxG`, `FlxSprite`, `FlxCamera`, `FlxObject`, `FlxBasic`, `FlxText`, `FlxSound`, `FlxTimer`, `FlxMath`, `FlxAssets`, `FlxRuntimeShader`, `FlxColor` (Custom one), `FlxTextAlign` (Custom one)
- Flixel Modding: `FlxModding`
- Flixel Waveform: `FlxWaveform`, `FlxWaveformBuffer`
- OpenFL: `Lib`
- Lime: `Application`
- Pop Engine: `Paths`

## Common thing have
- `import(daClass:String, ?asName:String)`: Import a classes to the HScript code, if you want to have a unique name for your class to import, edit `asName`, if not, is will get the class name
- `importScript(file:String)`: Import a scripts file to the game and let it run, is will also push the current scripts was import to the `scriptArray` from `GameState.instance`
- `add(object:FlxBasic)`: Added a object to the game
- `remove(object:FlxBasic)`: Remove a object from the game
- `insert(pos:Int, obj:FlxBasic)`: Added a object with specific position (is like Array)
- `tagLua(tag:String)`: Get a tagged variable from Lua code

## Variable
- `game`: Get a variable, function from `GameState.instance`