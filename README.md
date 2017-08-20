## Dependency graph of critical structures

```
- Prefab: what an object "is"
  - Asset: art media files on disk
  - EntityScript: instance of an entity
    - StateGraph: states of this entity instance
    - BufferedAction: an instance of an action to be executed
      - Action: reference to enum of possible actions
      - Recipe: validate action capability is earned
        - TechTree: structure requirements
        - Ingredient: item requirements
    - Component: what an object "does"
      - Replica: sync component data with network
    - Brain: artificial intelligence
      - BehaviourTree: hierarchy of things entity will do
        - BehaviourNode: logical building blocks
```

the build output has to symlinked to 

C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Beta\mods

e.g., open cmd.exe

# client side

mklink /J "C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Beta\mods\base" "F:\Creative\DST_Mods\base\build"

# server side

mklink /J "H:\Games\SteamLibrary\steamapps\common\Don't Starve Together Dedicated Server\mods\base" "F:\Creative\DST_Mods\base\build"

"Paste as Shortcut" or  alt+right-click "Link to" will not work


for references:
- read actual src

- read examples
  https://forums.kleientertainment.com/files/file/203-api-examples/
  
- read community api doc
  http://dontstarveapi.com/


for debugging:

use that windows program for log output LogExpert
F:\Downloads\tools\LogExpert\LogExpert.exe

after running the game at least once,
open the file ~\Documents\Klei\DoNotStarveTogether\client_log.txt
and keep it open (the app will refresh/tail it)
you can set highlights on certain words to help your eye find it admist the wall of text



AND

use vscode-debuggee (based on moddebug which DST devs apparently use)
(place that .lua file they give you in LUA_PATH)

Recommend using Visual Studio Code IDE
with following plugins:
- patrys.vscode-code-outline
- devCAT.lua-debug
- trixnz.vscode-lua

also:
- luarocks install dkjson 
- luarocks install luacheck
- luarocks install mobdebug # also compiles + installs luasocket dependency needed by vscode-debuggee

REMEMBER: You must run luarocks in x86 Native Tools Command Prompt for VS2017 and as Administrator

the LUA environment variables are a bitch but i got by unzipping luarocks for windows .zip
this command assumes to use packaged lua 5.1 binaries and installs to default location on C:\
install.bat /L 

it will print the env vars in the output that you need to add
what it does not explain well is that you need to concatenate them all yourself
DO NOT set the PATHEXT env var. that is the most assinine suggestion.
%APPDATA% needs to be manually replaced they say. i just did not but you could try not doing it.

i also copy + renamed lua5.1.exe to lua.exe for convenience (typing `lua` in cmd just works)







opening asset files:

- sound: use FMOD from Steam DST Tools launcher

  FMOD Event Player is the best and can play .fev
  H:\Games\SteamLibrary\steamapps\common\Don't Starve Mod Tools\mod_tools\FMOD_Designer\fmod_eventplayer.exe

- anim: use ktools from forums and then Spriter on *.scml file
  https://forums.kleientertainment.com/files/file/583-ktools-cross-platform-modding-tools-for-dont-starve/
  NOTE you have to unzip the *_build.zip and then the desired animation *.zip into a single folder to proceed with following

"F:\Creative\DST_Mods\tools\ktools-4.4.4-win32\ktools-4.4.4\krane.exe" -v "F:\Desktop\tmp\dst\tmp\anim.bin" "F:\Desktop\tmp\dst\tmp\build.bin" "F:\Desktop\tmp\dst\tmp"

"F:\Creative\DST_Mods\tools\ktools-4.4.4-win32\ktools-4.4.4\ktech.exe" "F:\Desktop\tmp\dst\tmp\atlas-0.tex"

- image (.tex): use Handsom Matt's tools from klei forum
  https://forums.kleientertainment.com/files/file/73-handsome-matts-tools/

- packaging mod from steam: use Steam tools launcher (default radio selection)

