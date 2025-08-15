package objects;

import flixel.FlxSprite;
import flixel.system.FlxModding;
import flixel.util.FlxColor;
import haxe.io.Bytes;
import openfl.display.BitmapData;

class ContentIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;

	public function new(string:String)
	{
		super();

		if (string != null)
			loadGraphic(FlxModding.system.getBitmapData(string));
		else
			makeGraphic(64, 64, FlxColor.TRANSPARENT);

		setGraphicSize(64, 64);
		scrollFactor.set();
		updateHitbox();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
		{
			setPosition(sprTracker.x + sprTracker.width + 5, sprTracker.y + -15);
			scrollFactor.set(sprTracker.scrollFactor.x, sprTracker.scrollFactor.y);
		}
	}
}