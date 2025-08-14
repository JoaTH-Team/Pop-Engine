package backend;

class GameVar {
    public static var tagVariable:Map<String, Dynamic> = new Map<String, Dynamic>();

    public static function setVar(name:String, val:Dynamic) {
        return tagVariable.set(name, val);
    }

    public static function getVar(name:String) {
        return tagVariable.get(name);
    }

    public static function clearVar() {
        return tagVariable.clear();
    }

    public static function removeVar(name:String) {
        return tagVariable.remove(name);
    }

    public static function existsVar(name:String) {
        return tagVariable.exists(name);
    }
}