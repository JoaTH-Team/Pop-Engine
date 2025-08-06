# Example stuff for Pop Engine
### Lua Part
[See all Lua API here](Lua-Code.md)

#### Create Sprite (LUA)
```lua
function create()
    createSprite("myTag", 0, 0, "myImage")
    add("myTag")
end

function update(elapsed)
    setMovement("myTag", ["W", "A", "S", "D"], 100) -- move character with speed 100
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
        {name: "idle", prefix: "coolIdle0", frameRate: 24, looped: false},
        {name: "soCool", prefix: "soCool0", frameRate: 24, looped: false}
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

### HScript Part
#### Create Sprite (HSCRIPT)
```haxe
var mySprite:FlxSprite;

function create() {
    mySprite = new FlxSprite(20, 20);
    mySprite.loadGraphic("myImage");
    add(mySprite);
}

function update(elapsed:Float) {
    if (FlxG.keys.pressed.A) mySprite.x -= 1;
    if (FlxG.keys.pressed.D) mySprite.x += 1;
    if (FlxG.keys.pressed.W) mySprite.y -= 1;
    if (FlxG.keys.pressed.S) mySprite.y += 1;
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