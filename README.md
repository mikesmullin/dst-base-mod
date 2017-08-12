the build output has to symlinked to 

C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Beta\mods

e.g., open cmd.exe

mklink /J "C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Beta\mods\base" "F:\Creative\DST_Mods\base\build"

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

