package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.system.FlxModding;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class ManagerState extends FlxState
{
    var listContent:Array<String> = [];
    var iconGame:Array<ContentIcon> = [];

    var listGroup:FlxTypedGroup<FlxText>;
    var listSelected:Int = 0;

    var camFollow:FlxObject;
    var camHUD:FlxCamera;

	override public function create()
	{
		super.create();
        FlxModding.reload(true);

        FlxModding.mods.forEachExists(function (content) {
            listContent.push(content.name);
        });

        var grid:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33C4C4C4, 0x0));
		grid.velocity.set(40, 40);
		add(grid);

		camFollow = new FlxObject(80, 0, 0, 0);
		camFollow.screenCenter(X);
		add(camFollow);

        camHUD = new FlxCamera();
        camHUD.bgColor = FlxColor.TRANSPARENT;
        FlxG.cameras.add(camHUD, false);

        listGroup = new FlxTypedGroup<FlxText>();
        add(listGroup);

        for (i in 0...listContent.length) {
            var text:FlxText = new FlxText(10, (i * 66) + 100, 0, listContent[i], 24);
            text.ID = i;
            text.setBorderStyle(OUTLINE, FlxColor.BLACK);
            listGroup.add(text);

            trace(FlxModding.get(listContent[i]).iconDirectory());

            var icon:ContentIcon = new ContentIcon(FlxModding.get(listContent[i]).iconDirectory());
			icon.sprTracker = text;
			iconGame.push(icon);
			add(icon);
        }

        var title:FlxText = new FlxText(0, 0, "Manager Content", 32);
        title.setBorderStyle(OUTLINE, FlxColor.BLACK);
        title.screenCenter(X);
        title.x += 100;
        title.y += 20;
        title.camera = camHUD;
        add(title);

        FlxG.camera.follow(camFollow, null, 0.15);

        changeSelection();
    }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	
        if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
            changeSelection((FlxG.keys.justPressed.UP ? -1 : 1));

        if (FlxG.keys.justPressed.ENTER) {
            try {
                Paths.dirPath = FlxModding.get(listContent[listSelected]).directory();
                
                var file:String = null;
                var hxsFile = Paths.data('states/FirstState.hxs');
                var luaFile = Paths.data('states/FirstState.lua');
                
                if (sys.FileSystem.exists(hxsFile)) {
                    file = hxsFile;
                } else if (sys.FileSystem.exists(luaFile)) {
                    file = luaFile;
                } else {
                    file = hxsFile;
                }
                
                FlxG.switchState(() -> new GameState(file));
            } catch (e:Dynamic) {
                CrashHandler.reportError(e, 'Failed to switch to game state');
                FlxG.stage.application.window.alert('Failed to load content: ${listContent[listSelected]}\nError: $e', 'Load Error');
            }
        }
    }

    function changeSelection(change:Int = 0) {
        try {
            listSelected = FlxMath.wrap(listSelected + change, 0, listContent.length - 1);

            listGroup.forEach(function (text:FlxText) {
                if (text.ID == listSelected) {
                    text.color = FlxColor.YELLOW;
                    camFollow.y = text.y;
                } else {
                    text.color = FlxColor.WHITE;
                }
            });
        } catch (e) {
            CrashHandler.reportError(e.message, "Failed at moving content");
        }
    }
}