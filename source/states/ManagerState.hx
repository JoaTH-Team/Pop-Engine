package states;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.system.FlxModpack;
import flixel.util.FlxColor;
import objects.PopText;

class ManagerState extends FlxUIState
{
    var contentArray:Array<String> = [];
    var groupContent:FlxTypedGroup<PopText>;
    var curSelected:Int = 0;

    override function create() {
        FlxModding.reload();

		FlxModding.mods.forEachExists(function(mod:FlxModpack)
		{
			contentArray.push(mod.name);
		});

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
		changeSelection();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
		if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
			changeSelection(FlxG.keys.justPressed.UP ? -1 : 1);

		if (FlxG.keys.justPressed.F5)
			FlxG.switchState(() -> new states.ManagerState());

		if (FlxG.keys.justPressed.ENTER)
		{
			try
			{
				Paths.dirPath = FlxModding.get(contentArray[curSelected]).directory();
			}
			catch (e) {}
		}
    }

    function changeSelection(change:Int = 0) {
        curSelected = FlxMath.wrap(curSelected + change, 0, contentArray.length - 1);

		var inSelected:Int = 0;
        groupContent.forEach(function (text:PopText) {
			text.targetY = inSelected - curSelected;
			inSelected += 1;
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