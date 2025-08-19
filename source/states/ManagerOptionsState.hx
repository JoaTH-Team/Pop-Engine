package states;

import backend.Argument;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import objects.PopText;

class ManagerOptionsState extends FlxState
{
    var options:Array<String> = ["HScript Type", "Disable Overlay Grid"];
    var curSelected:Int = 0;
    var optionsGroup:FlxTypedGroup<PopText>;
    
    override function create() {
        super.create();

        SaveData.reBindData("hscriptType");
		SaveData.reBindData("disableOverlayGrid");

        optionsGroup = new FlxTypedGroup<PopText>();
        add(optionsGroup);
        for (i in 0...options.length) {
            var text:PopText = new PopText(30, 0, 0, options[i], 24);
            text.targetY = i;
            text.ID = i;
            text.asMenuItem = true;
            optionsGroup.add(text);
        }

        optionsGroup.forEach(function(text:PopText) {
            if (text.ID == 0)
                text.text = 'HScript Type: ${Argument.hscriptType}';
            else if (text.ID == 1)
                text.text = 'Disable Overlay Grid: ${SaveData.getData("disableOverlayGrid") ? "ON" : "OFF"}';
        });

        changeSelection();
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);

		if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
			changeSelection(FlxG.keys.justPressed.UP ? -1 : 1);

        if (FlxG.keys.justPressed.ESCAPE) {
            SaveData.flush();
            FlxG.switchState(() -> new ManagerState());
        }

        optionsGroup.forEach(function(text:PopText) {
            if (text.ID == 0)
                text.text = 'HScript Type: ${Argument.hscriptType}';
            else if (text.ID == 1)
                text.text = 'Disable Overlay Grid: ${SaveData.getData("disableOverlayGrid") ? "ON" : "OFF"}';
        });

        if (FlxG.keys.justPressed.ENTER) {
            switch (options[curSelected]) {
                case "HScript Type":
                    Argument.hscriptType = Argument.hscriptType == "flixel" ? "iris" : "flixel";
                    SaveData.setData("hscriptType", Argument.hscriptType);
                    SaveData.flush();
                    changeSelection(0);
                case "Disable Overlay Grid":
                    SaveData.setData("disableOverlayGrid", !SaveData.getData("disableOverlayGrid"));
                    SaveData.flush();
                    changeSelection(0);
            }
        }
    }

    function changeSelection(change:Int = 0) {
		curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);
		var inSelected:Int = 0;
		optionsGroup.forEach(function(text:PopText)
		{
			text.targetY = inSelected - curSelected;
			inSelected += 1;
			if (text.ID == curSelected)
			{
				text.alpha = 1;
			}
			else
			{
				text.alpha = 0.5;
			}
		});
    }
}