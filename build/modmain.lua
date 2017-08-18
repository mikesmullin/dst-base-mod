local _G = GLOBAL
local pcall = _G.pcall
local getmetatable = _G.getmetatable
local getmetatable = _G.getmetatable
local setmetatable = _G.setmetatable
local rawset = _G.rawset
local select = _G.select
local debug = _G.debug
-- Generated by Haxe 3.4.2 (git build master @ 890f8c7)
local _hx_array_mt = {
  __newindex = function(t,k,v)
    local len = t.length
    t.length =  k >= len and (k + 1) or len
    rawset(t,k,v)
  end
}

local function _hx_tab_array(tab,length)
  tab.length = length
  return setmetatable(tab, _hx_array_mt)
end

local function _hx_anon_newindex(t,k,v) t.__fields__[k] = true; rawset(t,k,v); end
local _hx_anon_mt = {__newindex=_hx_anon_newindex}
local function _hx_a(...)
  local __fields__ = {};
  local ret = {__fields__ = __fields__};
  local max = select('#',...);
  local tab = {...};
  local cur = 1;
  while cur < max do
    local v = tab[cur];
    __fields__[v] = true;
    ret[v] = tab[cur+1];
    cur = cur + 2
  end
  return setmetatable(ret, _hx_anon_mt)
end

local function _hx_e()
  return setmetatable({__fields__ = {}}, _hx_anon_mt)
end

local function _hx_o(obj)
  return setmetatable(obj, _hx_anon_mt)
end

local function _hx_new(prototype)
  return setmetatable({__fields__ = {}}, {__newindex=_hx_anon_newindex, __index=prototype})
end

local _hxClasses = {}
Int = (function() _hxClasses.Int = _hx_o({__fields__={__name__=true},__name__={"Int"}}); return _hxClasses.Int end)();
Dynamic = (function() 
_hxClasses.Dynamic = _hx_o({__fields__={__name__=true},__name__={"Dynamic"}}); return _hxClasses.Dynamic end)();
Float = (function() 
_hxClasses.Float = _hx_e(); return _hxClasses.Float end)();
Float.__name__ = {"Float"}
Bool = (function() 
_hxClasses.Bool = _hx_e(); return _hxClasses.Bool end)();
Bool.__ename__ = {"Bool"}
Class = (function() 
_hxClasses.Class = _hx_o({__fields__={__name__=true},__name__={"Class"}}); return _hxClasses.Class end)();
Enum = _hx_e();

local Array = _hx_e()
local Main = _hx_e()
local String = _hx_e()
local Std = _hx_e()
local haxe = {}
haxe.Log = _hx_e()
haxe.io = {}
haxe.io.Eof = _hx_e()
local lua = {}
lua.Boot = _hx_e()

local _hx_bind, _hx_bit, _hx_staticToInstance, _hx_funcToField, _hx_maxn, _hx_print, _hx_apply_self, _hx_box_mr, _hx_bit_clamp, _hx_table, _hx_bit_raw

Array.new = {}
Array.prototype = _hx_a(
  'join', function(self,sep) 
    local tbl = ({});
    local _gthis = self;
    local cur_length = 0;
    local i = _hx_o({__fields__={hasNext=true,next=true},hasNext=function(self) 
      do return cur_length < _gthis.length end;
    end,next=function(self) 
      cur_length = cur_length + 1;
      do return _gthis[cur_length - 1] end;
    end});
    while (i:hasNext()) do 
      local i1 = i:next();
      _G.table.insert(tbl,Std.string(i1));
      end;
    do return _G.table.concat(tbl,sep) end
  end,
  'push', function(self,x) 
    _G.rawset(self,self.length,x);
    _G.rawset(self,"length",self.length + 1);
    do return _G.rawget(self,"length") end
  end,
  'iterator', function(self) 
    local _gthis = self;
    local cur_length = 0;
    do return _hx_o({__fields__={hasNext=true,next=true},hasNext=function(self) 
      do return cur_length < _gthis.length end;
    end,next=function(self) 
      cur_length = cur_length + 1;
      do return _gthis[cur_length - 1] end;
    end}) end
  end
)

Main.new = {}
Main.main = function() 
  haxe.Log.trace("MikesPlugin: " .. "debug mode is enabled.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
  _G.CHEATS_ENABLED = true;
  _G.require("debugtools");
  _G.PRINT_SOURCE = true;
  _G.DISABLE_MOD_WARNING = true;
  local inst = _G.CreateEntity();
  inst:ListenForEvent("entitywake",function(_self,data) 
    haxe.Log.trace("MikesPlugin: " .. "event entitywake",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
  end,inst);
  inst:ListenForEvent("onremove",function(self1,data1) 
    haxe.Log.trace("MikesPlugin: " .. "event onremove",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
  end,inst);
  AddSimPostInit(function() 
    haxe.Log.trace("MikesPlugin: " .. "AddSimPostInit",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    if (nil == _G.TheWorld) then 
      do return end;
    end;
    haxe.Log.trace("MikesPlugin: " .. "and TheWorld",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    if (_G.TheNet:GetIsServer()) then 
      haxe.Log.trace("MikesPlugin: " .. "I'm a server.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    end;
    if (_G.TheNet:GetIsClient()) then 
      haxe.Log.trace("MikesPlugin: " .. "I'm a client.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    end;
    if (_G.TheNet:IsDedicated()) then 
      haxe.Log.trace("MikesPlugin: " .. "I'm a dedicated server.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    else
      haxe.Log.trace("MikesPlugin: " .. "I'm NOT a dedicated server.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    end;
    if (_G.TheWorld.ismastersim) then 
      haxe.Log.trace("MikesPlugin: " .. "I'm a master simulator.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    else
      haxe.Log.trace("MikesPlugin: " .. "I'm NOT a master simulator.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    end;
    inst:ListenForEvent("ms_newplayercharacterspawned",function(self2,data2) 
      haxe.Log.trace("MikesPlugin: " .. "event ms_newplayercharacterspawned",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
      if (not _G.InGamePlay()) then 
        do return end;
      end;
      haxe.Log.trace("MikesPlugin: " .. "and InGamePlay()",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
      haxe.Log.trace("MikesPlugin: " .. "main() starting up...",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    end,_G.TheWorld);
  end);
  AddGamePostInit(function() 
    haxe.Log.trace("MikesPlugin: " .. "AddGamePostInit",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
  end);
  AddPlayerPostInit(function(inst1) 
    haxe.Log.trace("MikesPlugin: " .. "AddPlayerPostInit",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    local bleuCheese = _G.net_bool(inst1.GUID,"bleucheese","bleucheesedirty");
    if (_G.TheNet:GetIsClient()) then 
      _G.require("serpent");
      inst1:ListenForEvent("bleucheesedirty",function() 
        local s = "bleu cheese dirtied to " .. Std.string(bleuCheese:value());
        haxe.Log.trace("MikesPlugin: " .. s,_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
      end);
    end;
    if (_G.TheNet:IsDedicated()) then 
      bleuCheese:set(false);
    end;
    local s1 = "bleuCheese is " .. Std.string(bleuCheese:value());
    haxe.Log.trace("MikesPlugin: " .. s1,_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    if (_G.TheNet:IsDedicated()) then 
      inst1:DoTaskInTime(5,function() 
        bleuCheese:set(true);
      end);
    end;
    inst1:DoTaskInTime(6,function() 
      local s2 = "bleuCheese is " .. Std.string(bleuCheese:value());
      haxe.Log.trace("MikesPlugin: " .. s2,_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Utils.hx",lineNumber=14,className="Utils",methodName="log"}));
    end);
  end);
end

String.new = {}
String.__index = function(s,k) 
  if (k == "length") then 
    do return _G.string.len(s) end;
  else
    local o = String.prototype;
    local field = k;
    if ((function() 
      local _hx_1
      if (o.__fields__ ~= nil) then 
      _hx_1 = o.__fields__[field] ~= nil; else 
      _hx_1 = o[field] ~= nil; end
      return _hx_1
    end )()) then 
      do return String.prototype[k] end;
    else
      if (String.__oldindex ~= nil) then 
        do return String.__oldindex[k] end;
      else
        do return nil end;
      end;
    end;
  end;
end
String.fromCharCode = function(code) 
  do return _G.string.char(code) end;
end
String.prototype = _hx_a(
  'toString', function(self) 
    do return self end
  end
)

Std.new = {}
Std.string = function(s) 
  do return lua.Boot.__string_rec(s) end;
end

haxe.Log.new = {}
haxe.Log.trace = function(v,infos) 
  local str = nil;
  if (infos ~= nil) then 
    str = infos.fileName .. ":" .. infos.lineNumber .. ": " .. Std.string(v);
    if (infos.customParams ~= nil) then 
      str = str .. ("," .. infos.customParams:join(","));
    end;
  else
    str = v;
  end;
  if (str == nil) then 
    str = "null";
  end;
  _hx_print(str);
end

haxe.io.Eof.new = {}
haxe.io.Eof.prototype = _hx_a(
  'toString', function(self) 
    do return "Eof" end
  end
)

lua.Boot.new = {}
lua.Boot.isArray = function(o) 
  if (_G.type(o) == "table") then 
    if ((o.__enum__ == nil) and (_G.getmetatable(o) ~= nil)) then 
      do return _G.getmetatable(o).__index == Array.prototype end;
    else
      do return false end;
    end;
  else
    do return false end;
  end;
end
lua.Boot.printEnum = function(o,s) 
  if (o.length == 2) then 
    do return o[0] end;
  else
    local str = Std.string(o[0]) .. "(";
    s = s .. "\t";
    local _g1 = 2;
    local _g = o.length;
    while (_g1 < _g) do 
      _g1 = _g1 + 1;
      local i = _g1 - 1;
      if (i ~= 2) then 
        str = str .. ("," .. lua.Boot.__string_rec(o[i],s));
      else
        str = str .. lua.Boot.__string_rec(o[i],s);
      end;
      end;
    do return str .. ")" end;
  end;
end
lua.Boot.printClassRec = function(c,result,s) 
  if (result == nil) then 
    result = "";
  end;
  local f = lua.Boot.__string_rec;
  for k,v in pairs(c) do if result ~= '' then result = result .. ', ' end result = result .. k .. ':' .. f(v, s.. '	') end;
  do return result end;
end
lua.Boot.__string_rec = function(o,s) 
  if (s == nil) then 
    s = "";
  end;
  local _g = type(o);
  local _g1 = _g;
  if (_g1) == "boolean" then 
    do return tostring(o) end;
  elseif (_g1) == "function" then 
    do return "<function>" end;
  elseif (_g1) == "nil" then 
    do return "null" end;
  elseif (_g1) == "number" then 
    if (o == _G.math.huge) then 
      do return "Infinity" end;
    else
      if (o == -_G.math.huge) then 
        do return "-Infinity" end;
      else
        if (o ~= o) then 
          do return "NaN" end;
        else
          do return tostring(o) end;
        end;
      end;
    end;
  elseif (_g1) == "string" then 
    do return o end;
  elseif (_g1) == "table" then 
    if (o.__enum__ ~= nil) then 
      do return lua.Boot.printEnum(o,s) end;
    else
      if ((o.toString ~= nil) and not lua.Boot.isArray(o)) then 
        do return o:toString() end;
      else
        if (lua.Boot.isArray(o)) then 
          local o2 = o;
          if (s.length > 5) then 
            do return "[...]" end;
          else
            local _g2 = _hx_tab_array({ }, 0);
            local _g11 = 0;
            while (_g11 < o2.length) do 
              local i = o2[_g11];
              _g11 = _g11 + 1;
              _g2:push(lua.Boot.__string_rec(i,s .. 1));
              end;
            do return "[" .. _g2:join(",") .. "]" end;
          end;
        else
          if (o.__class__ ~= nil) then 
            do return "{" .. lua.Boot.printClassRec(o,"",s .. "\t") .. "}" end;
          else
            local fields = lua.Boot.fieldIterator(o);
            local buffer = ({});
            local first = true;
            _G.table.insert(buffer,"{ ");
            local f = fields;
            while (f:hasNext()) do 
              local f1 = f:next();
              if (first) then 
                first = false;
              else
                _G.table.insert(buffer,", ");
              end;
              _G.table.insert(buffer,"" .. Std.string(f1) .. " : " .. Std.string(o[f1]));
              end;
            _G.table.insert(buffer," }");
            do return _G.table.concat(buffer,"") end;
          end;
        end;
      end;
    end;
  elseif (_g1) == "thread" then 
    do return "<thread>" end;
  elseif (_g1) == "userdata" then 
    do return "<userdata>" end;else
  _G.error("Unknown Lua type",0); end;
end
lua.Boot.fieldIterator = function(o) 
  local tbl = (function() 
    local _hx_1
    if (o.__fields__ ~= nil) then 
    _hx_1 = o.__fields__; else 
    _hx_1 = o; end
    return _hx_1
  end )();
  local cur = _G.pairs(tbl);
  local next_valid = function(tbl1,val) 
    while (lua.Boot.hiddenFields[val] ~= nil) do 
      val = cur(tbl1,val);
      end;
    do return val end;
  end;
  local cur_val = next_valid(tbl,cur(tbl,nil));
  do return _hx_o({__fields__={next=true,hasNext=true},next=function(self) 
    local ret = cur_val;
    cur_val = next_valid(tbl,cur(tbl,cur_val));
    do return ret end;
  end,hasNext=function(self) 
    do return cur_val ~= nil end;
  end}) end;
end
local _hx_string_mt = _G.getmetatable('');
String.__oldindex = _hx_string_mt.__index;
_hx_string_mt.__index = String.__index;
_hx_string_mt.__add = function(a,b) return Std.string(a)..Std.string(b) end;
_hx_string_mt.__concat = _hx_string_mt.__add
_hx_array_mt.__index = Array.prototype

local _hx_static_init = function()
  lua.Boot.hiddenFields = {__id__=true, hx__closures=true, super=true, prototype=true, __fields__=true, __ifields__=true, __class__=true, __properties__=true}
  
end

_hx_print = print or (function() end)
_hx_static_init();
Main.main()
return _hx_exports
