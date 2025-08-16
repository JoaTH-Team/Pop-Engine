# Build Pop Engine
Pop Engine is use Haxe with Flixel Framework, so is should be easier to build

## Install
1. Install [Haxe 4.3.7](https://haxe.org/download/version/4.3.7/) (or maybe the [latest version](https://haxe.org/download/))
2. After finished Haxe setup, download the engine source by [git](https://git-scm.com/downloads) or just download as [zip](https://github.com/JoaTH-Team/Pop-Engine/archive/refs/heads/main.zip)
3. Open the source, we gonna install some haxelib, to install sum haxelib, just copy this command into your terminal:
```
haxelib install flixel
haxelib run lime flixel setup
haxelib run lime setup
haxelib install flixel-modding
haxelib install flixel-waveform
haxelib install hscript-iris
haxelib install hxvlc
haxelib install hscript
```
4. Now you can able to build this project yay!
## Build
### Windows version
You will need to have Visual Studio to able compile this project, thankfully, you can do this once click: 
- Go to the root project, open `build` folder and then open the `msvc.bat`, is will auto install visual studio and some stuff needed for build this project
- After that, you will now able to use command like `haxelib run lime test windows` or `lime build windows`
### Mac version
Sorry but idk how to build on MacOS
### Linux version
> Note: this part is for Linux/Debian rn, idk about other Linux Distro

While install some haxelib, you will need also to install some dependencies for some Haxelib (such as `hxvlc`), just copy the command again:
```
sudo apt-get install vlc libvlc-dev libvlccore-dev vlc-bin
```
After that, if you come can't build the project due to missing or something like `gcc`, just install the `gcc` by command:
```
sudo apt-get install gcc
```
After that, you now will able to build this project with command like `haxelib run lime test linux` or `lime build linux`