package states;

import backend.Argument;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxUIState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.system.FlxModpack;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import objects.ContentIcon;
import objects.PopText;

class ManagerState extends FlxUIState
{
    var contentArray:Array<String> = [];
	var iconArray:Array<ContentIcon> = [];
    var groupContent:FlxTypedGroup<PopText>;
    var curSelected:Int = 0;

	var emptylist:Bool = false;

    override function create() {
		if (Argument.parseCommand(Sys.args()))
		{
			return;
		}
		Sys.println("Pop Engine HScript use type: " + Argument.hscriptType);

		FlxG.resizeGame(800, 600);
		FlxG.resizeWindow(800, 600);

        FlxModding.reload();

		FlxModding.mods.forEachExists(function(mod:FlxModpack)
		{
			contentArray.push(mod.name);
		});

        super.create();

		var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33C4C4C4, 0x0));
		grid.velocity.set(40, 40);
		add(grid);

        groupContent = new FlxTypedGroup<PopText>();
        add(groupContent);

        for (i in 0...contentArray.length)
        {
            var text:PopText = new PopText(30, 0, 0, contentArray[i], 24);
            text.targetY = i;
            text.ID = i;
            text.asMenuItem = true;
            groupContent.add(text);
			var icon:ContentIcon = new ContentIcon(FlxModding.get(contentArray[i]).iconDirectory());
			icon.sprTracker = text;
			iconArray.push(icon);
			add(icon);
        }
		changeSelection();
		var infoText:FlxText = new FlxText(10, FlxG.height - 22, 0, "Press F1 to display more info on the current selected content", 16);
		infoText.setBorderStyle(OUTLINE, FlxColor.BLACK);
		if (!emptylist)
			add(infoText);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
		if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
			changeSelection(FlxG.keys.justPressed.UP ? -1 : 1);

		if (FlxG.keys.justPressed.F1 && !emptylist)
		{
			var getMods = FlxModding.get(contentArray[curSelected]);
			ManagerSubState.config = [
				getMods.name,
				getMods.description,
				getMods.version,
				Std.string(getMods.directory())
			];
			openSubState(new ManagerSubState());
		}

		if (FlxG.keys.justPressed.F5)
			FlxG.switchState(() -> new states.ManagerState());

		if (FlxG.keys.justPressed.ENTER)
		{
			try
			{
				Paths.dirPath = FlxModding.get(contentArray[curSelected]).directory();
				FlxTween.tween(camera, {zoom: 1.25}, 0.5, {
					ease: FlxEase.sineInOut,
					onStart: function(tween:FlxTween)
					{
						camera.fade(FlxColor.BLACK, 0.5);
					},
					onComplete: function(tween:FlxTween)
					{
						FlxG.switchState(() -> new GameState("FirstState"));
					}
				});
			}
			catch (e) {}
		}
    }

    function changeSelection(change:Int = 0) {
		try
		{
			curSelected = FlxMath.wrap(curSelected + change, 0, contentArray.length - 1);

			var inSelected:Int = 0;
			for (i in 0...iconArray.length)
			{
				iconArray[i].alpha = 0.6;
			}

			iconArray[curSelected].alpha = 1;

			groupContent.forEach(function(text:PopText)
			{
				text.targetY = inSelected - curSelected;
				inSelected += 1;
				if (text.ID == curSelected)
				{
					text.color = FlxColor.YELLOW;
					text.alpha = 1;
				}
				else
				{
					text.color = FlxColor.WHITE;
					text.alpha = 0.5;
				}
			});
		}
		catch (e)
		{
			trace("Empty List");

			var text:FlxText = new FlxText(0, 0, 0, "DIDN'T FOUND ANY CONTENT\nCREATE ONE AND THEN PRESS F5 TO RELOAD", 24);
			text.color = FlxColor.RED;
			text.setBorderStyle(OUTLINE, FlxColor.BLACK);
			text.alignment = CENTER;
			text.screenCenter();
			text.updateHitbox();
			add(text);

			emptylist = true;
		}
    }
}