# DST Base Mod

## What is this?

I like to play Don't Starve Together a lot.  
Often I am playing with Steam Community Workshop mods enabled.  
Occasionally, I like to make my own mods.  
When I do, I use this as a starting point.  

## What else is this?

It may be a long time between when I create mods,  
and a lot of the details I learn are easy to forget.  
This `README.md` in particular serves as a set of notes to more easily jog my memory  
about how DST modding works in general.  
(That's because official notes are non-existent, and community notes are not well-organized.)

## Your first DST mod

If this is your first time making a mod, there are a number of resources you should look at before using this one.

- https://www.youtube.com/watch?v=bSaWX2vWh8k
- https://www.lua.org/pil/contents.html
- https://steamcommunity.com/sharedfiles/filedetails/?id=441378551
- https://forums.kleientertainment.com/files/category/5-modding-tools-tutorials-examples/
- https://forums.kleientertainment.com/forums/forum/79-dont-starve-together-mods-and-tools/
- https://forums.kleientertainment.com/files/file/203-api-examples/

Recently, a community member made this unofficial SDK.  
Honestly, it's a similar idea to this repo, but better executed.  
I recommend it instead:
- https://github.com/dstmodders/mod-sdk

But feel free to read on for more tips...

## Recommended tools
- I recommend to use Visual Studio Code (vscode) as the code editor
  - w/ the vscode "Lua" extension  
    https://marketplace.visualstudio.com/items?itemName=sumneko.lua

## Using the console

The default console provided in DST is pretty awful.  
You should install the `Better Console` mod.  

- then you can paste long lines
- it concatenates them all onto one line though
- so you'll need to add space at the beginning or end of each line, before copying

### Useful console commands
- `c_freecrafting()` to enter creative mode
- `c_supergodmode()` to become invulnerable
- `c_reset()` or `c_rollback()` (anything that causes a world reload) to reload your mod script w/o restarting DST
- `print()` to print to console
- `dumptable()` pretty-print any var to console (handles circular dependencies well)
- `print(debugstack());` print stack trace. `debug.traceback()` is treated like an error, and is less informative.
- `print(TheInput:GetWorldEntityUnderMouse():GetDebugString())` list anything you'd want to know about an EntityScript instance
- `dumptable(debug.getinfo(somefunction))` debug.getinfo dumps info about given variables or functions

see also: https://dontstarve.fandom.com/wiki/Console/Don%27t_Starve_Together_Commands

## Viewing console logs

To view the output, it's easiest to tail the log files from outside the process:
```
%homepath%/Documents/Klei/DoNotStarveTogether/master_server_log.txt
%homepath%/Documents/Klei/DoNotStarveTogether/client_log.txt
```

You can tail this using anything. Some examples for Windows:
 
- WSL2 Ubuntu bash `tail`
- Visual Studio Code (vscode) extension "Log Viewer"

## Viewing the source code of other mods 

The mods you download via Steam Workshop are stored here:

```
C:\Program Files (x86)\Steam\steamapps\workshop\content\322330\
```

It doesn't seem like you can fully edit these, however.  
Your changes are likely to be overridden, and your `require()` includes rejected for not matching the manifest.

Older mods, and your custom mods, will go here:

```
C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together\mods\
```

There is also this third-party tool which will download mods from Steam Workshop as an archive file, you can then extract wherever.

- http://steamworkshopdownloader.com/


### To make a new mod

- Create a new directory here
- Copy an existing mod in (change mod `name`, `author,` and `version` in `modinfo.lua` so it will appear separate)
- start editing `modmain.lua`

## The DST API

These notes are summarized for my own memory, and may be totally incorrect.   
It is my WIP interpretation.

```
- Prefab: what an object "is"
  - Asset: art media files on disk
  - EntityScript: instance of an entity
    - StateGraph: rules of animation playback and timing for Prefabs and EntityScripts
    - BufferedAction: an instance of an action to be executed
      - Action: reference to enum of possible actions
      - Recipe: validate action capability is earned
        - TechTree: structure requirements
        - Ingredient: item requirements
    - Component: what an object "does" (e.g., eat, attack, follow)
      - Replica: sync component data with network
    - Brain: artificial intelligence
      - BehaviourTree: hierarchy of things entity will try
        - BehaviourNode: logical building blocks
```

see also: https://web.archive.org/web/20190326202102/http://dontstarveapi.com/

## Attaching an interactive debugger

One time I managed to set and stop on breakpoints, and inspect the global and local scope.  
This is optional, but can be more useful that relying solely on printing to the console log.  
Here are my notes from how I did that.

- use vscode-debuggee (based on moddebug which DST devs apparently use)  
  (place that .lua file they give you in LUA_PATH)
- Recommend using Visual Studio Code IDE
  with following plugins:
  - `devCAT.lua-debug`
- also:
  - `luarocks install dkjson`
  - `luarocks install luacheck`
  - `luarocks install mobdebug` # also compiles + installs luasocket dependency needed by vscode-debuggee

**REMEMBER:** You must run luarocks in `x86 Native Tools Command Prompt`, as Administrator.

**NOTICE:** The LUA environment variables are a bit confusing, but I got it by unzipping luarocks for windows `.zip`.  
The `install.bat /L` command assumes to use packaged lua 5.1 binaries and installs to default location on `C:\`.
- It will print the env vars in the output that you need to add.  
- What it does not explain well is that you need to concatenate them all yourself.  
- DO NOT set the `PATHEXT` env var.
- `%APPDATA%` needs to be manually replaced.
- Copy + rename `lua5.1.exe` => `lua.exe` for convenience (then typing `lua` in cmd just works)  

## Manipulating art asset files

Many of the art assets are not using common file formats/extensions.

- for **audio/sound**: use `FMOD` from `Don't Starve Mod Tools` which is installable from `Tools` category using Steam.
- `FMOD Event Player` is can play `.fev` files. look for it under:  
  `\SteamLibrary\steamapps\common\Don't Starve Mod Tools\mod_tools\FMOD_Designer\fmod_eventplayer.exe`

- for **animations**: 
  - use `ktools` from forums 
  - then use `Spriter` (from `Don't Starve Mod Tools` on any `*.scml` file.
  - see also: https://forums.kleientertainment.com/files/file/583-ktools-cross-platform-modding-tools-for-dont-starve/
  - example:
    - unzip the `*_build.zip` and then the desired animation `*.zip` into a single folder 
    - `ktools-4.4.4-win32\ktools-4.4.4\krane.exe -v anim.bin build.bin ./`
    - `ktools-4.4.4-win32\ktools-4.4.4\ktech.exe atlas-0.tex`
  - for images `.tex`: use `Handsom Matt's tools` from klei forum  
    https://forums.kleientertainment.com/files/file/73-handsome-matts-tools/

- for publishing your mod to steam: use the default radio selection for `Don't Starve Mod Tools` launcher.
