# HScript API Stuff
> Just to be clear, HScript Iris type and HScript Flixel type variable, function are same, classes import and other stuff might not same

## Variable
- `state`: This variable will get the `GameState` variable class
- `subState`: This variable will get the `GameSubState` variable class
## Function
- `setVar(name:String, val:Dynamic)`: Set a variable that can be used to other scripts
- `getVar(name:String)`: Get a variable if that exists
- `removeVar(name:String)`: Remove a variable if that exist, after remove, that variable will not able to use anymore
- `existsVar(name:String)`: Use to check bool if that variable exists
- `clearVar()`: Clear and remove all variable exists
## Classes on Pop Engine
- Scene:
    > State and sub state scripts will always store in `data/states/` folder
    - State: `CustomState(FileName:String)`, `GameState(FileName:String)`: Use for switch a state if you use `FlxG.switchState(() -> new CustomState("<nameState>.hxs"))`
    - Sub-State: `CustomSubState(FileName:String)`, `GameSubState(FileName:String)`: Use for open a sub state if you use `openSubState(new CustomSubState("<nameState>.hxs"))`
- Objects:
    - `PopSprite`: A FlxSprite extends, currently have `makePrefixAnim(name:String, prefix:String, fps:Int = 24, looped:Bool = false)`
    - `PopText`: FlxText extends, currently have `asMenuItem`, once enable it, is will now work as a menu selected item (recommened use `asMenuItem` when use FlxTypedGroup)
- Backend:
    - `Paths`: Get all file you needed
    - `GameVar`: Is contains `setVar`, `getVar`,... function
- HaxeFlixel (Some Class have to fix to work on script):
    - `FlxColor`: Get all thingy about FlxColor