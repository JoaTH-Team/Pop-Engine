package;

import cpp.RawPointer;
import custom.CustomFlxKey;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import hxluajit.Lua;
import hxluajit.LuaL;
import hxluajit.Types.Lua_State;
import hxluajit.wrapper.LuaUtils;
import sys.io.File;

class LuaScript {
    public static var vm:RawPointer<Lua_State> = null;

    public static var taggedVariable:Map<String, Dynamic> = new Map<String, Dynamic>();

    // Memory management
    private static var maxTaggedObjects:Int = 500;
    private static var lastCleanupTime:Float = 0;
    private static var cleanupInterval:Float = 30.0; 
    
    public function new(file:String) {
        vm = LuaL.newstate();

        LuaL.openlibs(vm);

        // Create Function
        callback("createSprite", function (tag:String, x:Float, y:Float, paths:String = null) {
            manageMemory();
            var sprite:FlxSprite = new FlxSprite(x, y);
            sprite.loadGraphic(Paths.image(paths));
            sprite.active = true;
			taggedVariable.set(tag, sprite);
            return sprite;
        });
        callback("createText", function (tag:String, x:Float, y:Float, width:Int = 0, text:String = "", size:Int = 8) {
            manageMemory();
            var text:FlxText = new FlxText(x, y, width, text, size);
            text.active = true;
			taggedVariable.set(tag, text);
            return text;
        });

        // Sprite Function
        callback("loadGraphic", function (tag:String, paths:String) {
            if (taggedVariable.exists(tag)) 
                taggedVariable.get(tag).loadGraphic(Paths.image(paths));
        });
        callback("loadSpriteSheet", function (tag:String, paths:String, type:String = "sparrow") {
            if (taggedVariable.exists(tag))
            {
                switch (type) {
                    case "sparrow":
                        taggedVariable.get(tag).frames = FlxAtlasFrames.fromSparrow(Paths.image(paths), Paths.file('images/$paths.xml'));
                    case "packer":
                        taggedVariable.get(tag).frames = FlxAtlasFrames.fromTexturePackerXml(Paths.image(paths), Paths.file('images/$paths.xml'));
                }
            }
        });
        callback("makeAnimation", function (tag:String, animationConfigs:Array<{name:String, prefix:String, frameRate:Float, looped:Bool}>) {
            if (taggedVariable.exists(tag))
            {
                for (config in animationConfigs) {
                    taggedVariable.get(tag).animation.addByPrefix(config.name, config.prefix, config.frameRate, config.looped);
                }
            }
        });
        callbackMore(["playAnimation", "playAnim"], function (tag:String, animName:String, force:Bool = false) {
            if (taggedVariable.exists(tag))
            {
                taggedVariable.get(tag).animation.play(animName, force);
            }
        });

        // Utils Function
        callback("add", function (tag:String) {
            if (taggedVariable.exists(tag)) {
                GameState.instance.add(taggedVariable.get(tag));
            }
        });
        callback("remove", function (tag:String) {
            if (taggedVariable.exists(tag)) {
                GameState.instance.remove(taggedVariable.get(tag));
                taggedVariable.remove(tag);
            }
        });
        callback("insert", function (pos:Int, tag:String) {
            if (taggedVariable.exists(tag)) {
                GameState.instance.insert(pos, taggedVariable.get(tag));
            }
        });
        
        // Property Function
        callback("setProperty", function (objectPath:String, value:Dynamic) {
            var pathParts = objectPath.split(".");
            var tagName = pathParts[0];
            
            if (taggedVariable.exists(tagName)) {
                var object = taggedVariable.get(tagName);
                
                if (pathParts.length == 2) {
                    var property = pathParts[1];
                    Reflect.setProperty(object, property, value);
                }
            }
        });
        callback("getProperty", function (objectPath:String) {
            var pathParts = objectPath.split(".");
            var tagName = pathParts[0];
            
            if (taggedVariable.exists(tagName)) {
                var object = taggedVariable.get(tagName);
                
                if (pathParts.length == 2) {
                    var property = pathParts[1];
                    return Reflect.getProperty(object, property);
                }
            }
            
            return null;
        });

        // Action Functions
        callbackMore(["keyJustPress", "inputJustPress"], function (keyName:String) {
            function getKeyName(name:String) {
                var key = Reflect.getProperty(CustomFlxKey, name.toUpperCase());
                return (key != null) ? key : CustomFlxKey.NONE;
            }
            return FlxG.keys.anyJustPressed([getKeyName(keyName)]);
        });

        // Memory Manager Function
        callback("cleanupMemory", function () {
            manageMemory();
        });
        callback("getTaggedObjectCount", function () {
            return Lambda.count(taggedVariable);
        });
        callback("destroyTag", function (tag:String) {
            if (taggedVariable.exists(tag)) {
                var obj = taggedVariable.get(tag);
                if (obj != null && Std.isOfType(obj, FlxBasic)) {
                    var basic:FlxBasic = cast obj;
                    basic.destroy();
                }
                taggedVariable.remove(tag);
            }
        });
        callback("clearAllTags", function () {
            for (tag in taggedVariable.keys()) {
                var obj = taggedVariable.get(tag);
                if (obj != null && Std.isOfType(obj, FlxBasic)) {
                    var basic:FlxBasic = cast obj;
                    GameState.instance.remove(basic);
                    basic.destroy();
                }
            }
            taggedVariable.clear();
            trace("All tagged objects cleared");
        });

        try {
            LuaUtils.doString(vm, File.getContent(file));
        } catch (e:Dynamic) {
            CrashHandler.reportError(e, 'Lua script loading: $file');
            throw e;
        }
    }

    private static function manageMemory() {
        var currentTime = haxe.Timer.stamp();
        var objectCount = Lambda.count(taggedVariable);
        
        if (objectCount > maxTaggedObjects || (currentTime - lastCleanupTime) > cleanupInterval) {
            trace('Cleaning up memory (${objectCount} objects)...');
            
            var toRemove:Array<String> = [];
            for (tag in taggedVariable.keys()) {
                var obj = taggedVariable.get(tag);
                
                // Check if object is still in the game state or if it's been destroyed
                if (obj != null) {
                    if (Std.isOfType(obj, flixel.FlxBasic)) {
                        var basic:flixel.FlxBasic = cast obj;
                        if (!basic.exists || basic.active == false) {
                            toRemove.push(tag);
                        }
                    }
                } else {
                    toRemove.push(tag);
                }
            }
            
            // Remove dead objects
            for (tag in toRemove) {
                taggedVariable.remove(tag);
            }
            
            lastCleanupTime = currentTime;
            trace('Cleanup completed. Removed ${toRemove.length} objects');
        }
    }

    public function callFunction(name:String, args:Array<Dynamic>) {
        return LuaUtils.callFunctionByName(vm, name, args);
    }

    public function callback(name:String, args:Dynamic) {
        return LuaUtils.addFunction(vm, name, args);
    }

    public function callbackMore(name:Array<String>, args:Dynamic) {
        for (i in name) {
            callback(i.toString(), args);
        }
    }
    
    public static function cleanupAll() {
        trace("Performing full cleanup for lua...");
        for (tag in taggedVariable.keys()) {
            var obj = taggedVariable.get(tag);
            if (obj != null && Std.isOfType(obj, flixel.FlxBasic)) {
                var basic:flixel.FlxBasic = cast obj;
                basic.destroy();
            }
        }
        taggedVariable.clear();
        
        if (vm != null) {
            Lua.close(vm);
            vm = null;
        }
        
        trace("Full cleanup for lua completed");
    }
}
