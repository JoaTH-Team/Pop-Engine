package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class ManagerSubState extends FlxSubState
{
    /**
     * For set the content info such as Name mods, Desc, version, directory path
     */
    public static var config:Array<Dynamic> = [];

    var nameText:FlxText;
    var descText:FlxText;
    var versionText:FlxText;
    var dirText:FlxText;

    override function create() {
        super.create();

        var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        bg.alpha = 0;
        add(bg);

        nameText = new FlxText(30, 30, 0, config[0], 32);
        nameText.setBorderStyle(OUTLINE, FlxColor.BLACK);
        nameText.alpha = 0;
        add(nameText);

        descText = new FlxText(nameText.x, nameText.y + 140, 0, "Description: " + config[1], 24);
        descText.setBorderStyle(OUTLINE, FlxColor.BLACK);
        descText.alpha = 0;
        add(descText);  
        
        versionText = new FlxText(nameText.x, descText.y + 40, 0, "Version Content: " + config[2], 24);
        versionText.setBorderStyle(OUTLINE, FlxColor.BLACK);
        versionText.alpha = 0;
        add(versionText);  

        dirText = new FlxText(nameText.x, versionText.y + 40, 0, "Directory Path: " + config[3], 18);
        dirText.setBorderStyle(OUTLINE, FlxColor.BLACK);
        dirText.alpha = 0;
        add(dirText);

        FlxTween.tween(bg, {alpha: 0.4}, 0.25, {ease: FlxEase.sineInOut});
        FlxTween.tween(nameText, {alpha: 1}, 0.25, {ease: FlxEase.sineInOut});
        FlxTween.tween(descText, {alpha: 1}, 0.25, {ease: FlxEase.sineInOut, startDelay: 0.2});
        FlxTween.tween(versionText, {alpha: 1}, 0.25, {ease: FlxEase.sineInOut, startDelay: 0.3});
        FlxTween.tween(dirText, {alpha: 1}, 0.25, {ease: FlxEase.sineInOut, startDelay: 0.4});
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE) {
            close();
        }
    }
}