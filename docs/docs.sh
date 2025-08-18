#! /bin/sh
haxe docs/docs.hxml
haxelib run dox -i docs -o pages --title "Pop Engine API" -D source-path https://github.com/JoaTH-Team/Pop-Engine/tree/main/source
