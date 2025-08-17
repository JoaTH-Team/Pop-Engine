#! /bin/sh

haxe docs/docs.hxml
haxelib run dox -i docs -o pages --title "Pop Engine Documentation" -D source-path https://github.com/JoaTH-Team/Pop-Engine/tree/main/source