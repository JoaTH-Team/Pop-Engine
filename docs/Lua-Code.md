# Lua Code API
Lot of lua, also check [Example code from Pop Engine](Example.md) for more detail

## Common callback
- `createObject(tag:String, x:Float, y:Float)`: Create a object using `FlxObject`
- `createSprite(tag:String, x:Float, y:Float, paths:String)`: Create a sprite using `FlxSprite`
- `createText(tag:String, x:Float, y:Float, width:Int = 0, text:String = "", size:Int = 8)`: Create a text using `FlxText`
- `add(tag:String)`: Add a object into the state
- `remove(tag:String)`: Remove a object from a game
- `insert(pos:Int, tag:String)`: Like add object into game, but you can change the position of the index for object (is like array ig)

## Sprite callback
- `loadGraphic(tag:String, paths:String)`: Load a single sprite
- `loadSpriteSheet(tag:String, paths:String, type:String = "sparrow")`: Load a sprite sheet, for `type`, these have 2 options such as `sparrow` and `packer`
- `makeAnimation(tag:String, animationConfigs:Array<{name:String, prefix:String, frameRate:Float, looped:Bool}>)`: Make a prefix animation for your sprite sheet
- `playAnimation(tag:String, animName:String, force:Bool = false)` | `playAnim(tag:String, animName:String, force:Bool = false)`: Play an animation for your sprite sheet

## Property callback
- `setProperty(objectPath:String, value:Dynamic)`: Set a tag object property value
- `getProperty(objectPath:String)`: Get a tag object property value

## Some Utils callback
- `cleanupMemory()`: Clean up some memory
- `getTaggedObjectCount()`: Get all the tag object such as sprite, text,... to a int
- `destroyTag(tag:String)`: Run a `destroy()` for a call back that have it (like run `sprite.destroy();`)

# Lua Code more API
> Im real lazy for it, so i create this one

You can actually create your own Lua API by added a HScript file into the `data/lua_more_callback/<callback_name>.hxs`

Note: You will have only use `function new()` only, function `function create()`, `function update(elapsed:Float)`,... are not able to run for some haxelib reason

For quick example, is should be like:
```haxe
function new() {
    addCallback("funni", function () {
        trace("real funni");
    });
}
```

And after that, we can use `funni()`, is will trace a text `real funni`, into your console, for use the `funni()`, is should be like:
```lua
function create()
    funni() -- will trace `real funni`
end
```