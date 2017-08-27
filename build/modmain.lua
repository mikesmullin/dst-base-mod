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
haxe.io = {}
haxe.io.Eof = _hx_e()
local lua = {}
lua.Boot = _hx_e()
local utils = {}
utils.Logger = _hx_e()
utils.Lua = _hx_e()

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
  utils.Logger.log("debug mode is enabled.",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=20,className="Main",methodName="main"}));
  _G.CHEATS_ENABLED = true;
  _G.require("debugtools");
  _G.PRINT_SOURCE = true;
  _G.DISABLE_MOD_WARNING = true;
  local ValidateAttackTarget = function(combat,target,force_attack,x,z,has_weapon,reach) 
    if (not combat:CanTarget(target)) then 
      do return false end;
    end;
    local targetcombat = target.replica.combat;
    if (nil ~= targetcombat) then 
      if (combat:IsAlly(target)) then 
        do return false end;
      else
        if (not ((force_attack or combat:IsRecentTarget(target)) or (targetcombat:GetTarget() == combat.inst))) then 
          if (not (target:HasTag("hostile") or ((has_weapon and target:HasTag("monster")) and not target:HasTag("player")))) then 
            do return false end;
          end;
          local follower = target.replica.follower;
          if (nil ~= follower) then 
            local leader = follower:GetLeader();
            if (((nil ~= leader) and leader:HasTag("player")) and (leader.replica.combat:GetTarget() ~= combat.inst)) then 
              do return false end;
            end;
          end;
        end;
      end;
    end;
    local reach1 = (function() 
      local _hx_1
      if (target.Physics ~= nil) then 
      _hx_1 = reach + target.Physics:GetRadius(); else 
      _hx_1 = reach; end
      return _hx_1
    end )();
    do return target:GetDistanceSqToPoint(x,0,z) <= (reach1 * reach1) end;
  end;
  env.AddClassPostConstruct("components/playercontroller",function(_self) 
    _self.GetAttackTarget = function(self,force_attack1,force_target,isretarget) 
      _G.nolineprint("--");
      utils.Logger.log("PlayerController:GetAttackTarget()",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=107,className="Main",methodName="main"}));
      utils.Logger.log("  " .. ((function() 
        local _hx_2
        if (force_attack1) then 
        _hx_2 = "force_attack TRUE"; else 
        _hx_2 = "force_attack FALSE"; end
        return _hx_2
      end )()),_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=108,className="Main",methodName="main"}));
      utils.Logger.log("  " .. ((function() 
        local _hx_3
        if (nil ~= force_target) then 
        _hx_3 = "force_target " .. force_target.prefab; else 
        _hx_3 = "force_target NULL"; end
        return _hx_3
      end )()),_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=109,className="Main",methodName="main"}));
      utils.Logger.log("  " .. ((function() 
        local _hx_4
        if (isretarget) then 
        _hx_4 = "isretarget TRUE"; else 
        _hx_4 = "isretarget FALSE"; end
        return _hx_4
      end )()),_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=110,className="Main",methodName="main"}));
      _G.nolineprint(_G.debugstack());
      utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=113,className="Main",methodName="main"}));
      if (_self.inst:HasTag("playerghost") or _self.inst.replica.inventory:IsHeavyLifting()) then 
        do return nil end;
      end;
      utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=120,className="Main",methodName="main"}));
      local combat1 = _self.inst.replica.combat;
      if (nil == combat1) then 
        do return nil end;
      end;
      utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=124,className="Main",methodName="main"}));
      if (nil ~= _self.inst.sg) then 
        if (_self.inst.sg:HasStateTag("attack")) then 
          do return nil end;
        else
          if (_self.inst:HasTag("attack")) then 
            do return nil end;
          end;
        end;
      end;
      local _hx_5_coords_x, _hx_5_coords_y, _hx_5_coords_z = _self.inst.Transform:GetWorldPosition();
      local attackrange = combat1:GetAttackRangeWithWeapon();
      local rad = (function() 
        local _hx_6
        if (_self.directwalking) then 
        _hx_6 = attackrange; else 
        _hx_6 = attackrange + 6; end
        return _hx_6
      end )();
      local reach2 = (_self.inst.Physics:GetRadius() + rad) + 0.1;
      local has_weapon1 = _self.inst:HasTag("beaver");
      if (not has_weapon1) then 
        local inventory = _self.inst.replica.inventory;
        local tool = (function() 
          local _hx_7
          if (nil ~= inventory) then 
          _hx_7 = inventory:GetEquippedItem(_G.EQUIPSLOTS.HANDS); else 
          _hx_7 = nil; end
          return _hx_7
        end )();
        if (nil ~= tool) then 
          local inventoryitem = tool.replica.inventoryitem;
          if (nil ~= inventoryitem) then 
            has_weapon1 = inventoryitem:IsWeapon();
          else
            has_weapon1 = false;
          end;
        end;
      end;
      utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=153,className="Main",methodName="main"}));
      if (((((isretarget and combat1:CanHitTarget(force_target)) and (nil ~= force_target.replica.health)) and not force_target.replica.health:IsDead()) and _G.CanEntitySeeTarget(_self.inst,force_target)) and ValidateAttackTarget(combat1,force_target,force_attack1,_hx_5_coords_x,_hx_5_coords_z,has_weapon1,reach2)) then 
        do return force_target end;
      end;
      if (nil ~= force_target) then 
        utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=173,className="Main",methodName="main"}));
        if (ValidateAttackTarget(combat1,force_target,force_attack1,_hx_5_coords_x,_hx_5_coords_z,has_weapon1,reach2)) then 
          do return force_target end;
        else
          do return nil end;
        end;
      end;
      utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=187,className="Main",methodName="main"}));
      local nearby_ents = _G.TheSim:FindEntities(_hx_5_coords_x,_hx_5_coords_y,_hx_5_coords_z,rad + 5,_hx_tab_array({[0]="_combat" }, 1),_hx_tab_array({[0]="INLIMBO" }, 1));
      local nearest_dist = _G.math.huge;
      isretarget = false;
      force_target = nil;
      utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=199,className="Main",methodName="main"}));
      local pair = utils.Lua.ipairs(nearby_ents);
      while (pair:hasNext()) do 
        local pair1 = pair:next();
        local nearbyEntity = pair1.value;
        utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=204,className="Main",methodName="main"}));
        if (ValidateAttackTarget(combat1,nearbyEntity,force_attack1,_hx_5_coords_x,_hx_5_coords_z,has_weapon1,reach2) and _G.CanEntitySeeTarget(_self.inst,nearbyEntity)) then 
          utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=216,className="Main",methodName="main"}));
          local dsq = _self.inst:GetDistanceSqToInst(nearbyEntity);
          local dist;
          if (dsq <= 0) then 
            dist = 0;
          else
            if (nearbyEntity.Physics ~= nil) then 
              dist = _G.math.max(0,_G.math.sqrt(dsq) - nearbyEntity.Physics:GetRadius());
            else
              dist = _G.math.sqrt(dsq);
            end;
          end;
          if (not isretarget and combat1:IsRecentTarget(nearbyEntity)) then 
            if (dist < (attackrange + .1)) then 
              utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=234,className="Main",methodName="main"}));
              do return nearbyEntity end;
            end;
            isretarget = true;
          end;
          if (dist < nearest_dist) then 
            nearest_dist = dist;
            force_target = nearbyEntity;
          end;
        else
          if (not isretarget and combat1:IsRecentTarget(nearbyEntity)) then 
            isretarget = true;
          end;
        end;
        end;
      utils.Logger.log("",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=251,className="Main",methodName="main"}));
      do return force_target end
     end;
  end);
  env.AddClassPostConstruct("components/combat_replica",function(combat2) 
    local oldIsAlly = _hx_bind(combat2,combat2.IsAlly);
    combat2.IsAlly = function(self,target1) 
      utils.Logger.log("combat replica IsAlly()",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=290,className="Main",methodName="main"}));
      local ally = oldIsAlly(target1);
      if (ally) then 
        do return ally end;
      end;
      local weapon = combat2:GetWeapon();
      if ((nil ~= weapon) and weapon:HasTag("icestaff")) then 
        if ((nil ~= target1.components.freezable) and target1.components.freezable:IsFrozen()) then 
          ally = true;
        else
          ally = false;
        end;
      end;
      do return ally end
     end;
  end);
  env.AddPlayerPostInit(function(player) 
    utils.Logger.log("AddPlayerPostInit",_hx_o({__fields__={fileName=true,lineNumber=true,className=true,methodName=true},fileName="Main.hx",lineNumber=318,className="Main",methodName="main"}));
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

utils.Logger.new = {}
utils.Logger.log = function(s,pos) 
  _G.nolineprint(pos.fileName .. ":" .. pos.lineNumber .. ": " .. "MikesPlugin: " .. s);
end

utils.Lua.new = {}
utils.Lua.ipairs = function(table) 
  local i = 1;
  do return _hx_o({__fields__={next=true,hasNext=true},next=function(self) 
    local i1 = i;
    i = i + 1;
    do return _hx_o({__fields__={index=true,value=true},index=i1,value=table[i - 1]}) end;
  end,hasNext=function(self) 
    do return nil ~= table[i] end;
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

_hx_bind = function(o,m)
  if m == nil then return nil end;
  local f;
  if o._hx__closures == nil then
    _G.rawset(o, '_hx__closures', {});
  else 
    f = o._hx__closures[m];
  end
  if (f == nil) then
    f = function(...) return m(o, ...) end;
    o._hx__closures[m] = f;
  end
  return f;
end
_hx_static_init();
Main.main()
return _hx_exports
