package objects;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.text.FlxText;

using StringTools;

class PopText extends FlxText
{
    public var asMenuItem:Bool = false;
    public var selected:Bool = false;
    public var targetY:Float = 0;
    
    public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true)
    {
        super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
    }
    
    override function update(elapsed:Float)
    {
        super.update(elapsed);
        
        if (asMenuItem)
        {
            var scaledY = FlxMath.remapToRange(targetY, 0, 1, 0, 1.3);
            this.y = FlxMath.lerp(y, (scaledY * 120) + (FlxG.height * 0.48), 0.16);

            if (selected)
            {
                text = "> " + text.trim();
            }
            else
            {
                text = text.trim();
            }
        }
    }
}