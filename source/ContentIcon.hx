package;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.display.BitmapData;

class ContentIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;

	public function new(string:String)
	{
		super();

		if (string != null && string.length > 0)
		{
			try
			{
				loadGraphic(BitmapData.fromFile(string));
			}
			catch (e:Dynamic)
			{
				FlxG.log.warn(e);
				loadGraphic(Paths.image('pictureMissing'));
			}
		}
		else
			loadGraphic(Paths.image('pictureMissing'));

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