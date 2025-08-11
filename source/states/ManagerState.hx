package states;

import flixel.addons.ui.FlxUIState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.util.FlxColor;
import objects.PopText;

class ManagerState extends FlxUIState
{
    var contentArray:Array<String> = [];
    var groupContent:FlxTypedGroup<PopText>;
    var curSelected:Int = 0;

    override function create() {
        FlxModding.reload();

        super.create();

        groupContent = new FlxTypedGroup<PopText>();
        add(groupContent);

        for (i in 0...contentArray.length)
        {
            var text:PopText = new PopText(30, 0, 0, contentArray[i], 24);
            text.targetY = i;
            text.ID = i;
            text.asMenuItem = true;
            groupContent.add(text);
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    function changeSelection(change:Int = 0) {
        curSelected = FlxMath.wrap(curSelected + change, 0, contentArray.length - 1);

        groupContent.forEach(function (text:PopText) {
            if (text.ID == curSelected) {
                text.color = FlxColor.YELLOW;
                text.alpha = 1;
            } else {
                text.color = FlxColor.WHITE;
                text.alpha = 0.5;
            }
        });
    }
}