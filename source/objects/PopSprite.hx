package objects;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PopSprite extends FlxSprite
{
    public function new(x:Float, y:Float, ?graphic:FlxGraphicAsset) {
        super(x, y, graphic);
    }

    public function makePrefixAnim(name:String, prefix:String, fps:Int = 24, looped:Bool = false) {
        return this.animation.addByPrefix(name, prefix, fps, looped);
    }
}