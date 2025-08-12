# Example stuff for Pop Engine
### Note
For each game content create, you must have a `FirstState.hxs` or `FirstState.lua` when run your game content

To create your `FirstState`, create a `states` folder on `content/<your-content>/data/` and then create your `FirstState` script file

Also Note: If FirstState have both file with HScript and Lua, the engine will load the HScript one only!

### Lua Part
[See all Lua API here](Lua-Code.md)

#### Create Sprite (LUA)
```lua
function create()
    createSprite("myTag", 0, 0, "myImage")
    add("myTag")
end
```

#### Create Text (LUA)
```lua
function create()
    createText("myTag", 0, 0, 0, "This is my text", 32)
    add("myTag")
end
```

#### Load Animtion SpriteSheet (LUA)
```lua
function create()
    createSprite("myTag", 0, 0)
    loadSpriteSheet("myTag", "mySpriteSheet") -- will load both mySpriteSheet.png and mySpriteSheet.xml
    makeAnimation("myTag", [
        {name = "idle", prefix = "coolIdle0", frameRate = 24, looped = false},
        {name = "soCool", prefix = "soCool0", frameRate = 24, looped = false}
    ])
    playAnimation("myTag", "idle") -- `playAnim()` also work
end

function update(elapsed)
    if keyJustPress("SPACE") then
        playAnimation("myTag", "soCool")
    end

    if keyJustPress("Z") then
        playAnimation("myTag", "idle")
    end
end
```

#### Set/Get Property (LUA)
```lua
function create()
    createSprite("myTag", 0, 0, "myImage")
    add("myTag")
    
    setProperty("myTag.x", 100) -- move myTag x position to 100

    print(getProperty("myTag.x")) -- return myTag x position
end
```

### HScript Part
#### Create Sprite (HSCRIPT)
```haxe
var mySprite:FlxSprite;

function create() {
    mySprite = new FlxSprite(20, 20);
    mySprite.loadGraphic("myImage");
    add(mySprite);
}
```

#### Create Text (HSCRIPT)
```haxe
function create() {
    var myText = new FlxText(20, 20, 0, "This is my text", 32);
    add(myText);
}
```

#### Load Animation SpriteSheet (HSCRIPT)
```haxe
var myTag:FlxSprite;

function create() {
    myTag = new FlxSprite(0, 0);
    myTag.frames = Util.getSparrowAtlas("mySpriteSheet");
    myTag.animation.addByPrefix("idle", "coolIdle0", 24, false);
    myTag.animation.addByPrefix("soCool", "soCool0", 24, false);
    myTag.animation.play("idle"); // `myTag.playAnimation` or `myTag.playAnim` also work too
    add(myTag);
}

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.SPACE) {
        myTag.animation.play("soCool");
    }

    if (FlxG.keys.justPressed.Z) {
        myTag.animation.play("idle");
    }    
}
```

#### Imported Class (HSCRIPT)
```haxe
import("DebugCounter")

function new() {
    DebugCounter.instance.x = 30;
    DebugCounter.instance.y = 30;
}
```

#### Imported Script (HSCRIPT)
```haxe
// states/FirstState.hxs
var cool = importScript("sample/Cool.hxs");

function create() {
    trace(cool.importMe());
}

// sample/Cool.hxs
function importMe() {
    return 'is da cool trace';
}
```

### Both Part
#### Set/Get tagged Lua object (HSCRIPT | LUA)
```lua
-- states/FirstState.lua
function create()
    createText("myTag", 0, 0, 0, "This is my text", 32)
    add("myTag")
end
```

```haxe
// scripts/FirstState/thing.hxs
function create() {
    tagLua("myTag").x = 100;
}
```