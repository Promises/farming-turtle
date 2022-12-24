--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]

local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        ____moduleCache[file] = { value = (select("#", ...) > 0) and module(...) or module(file) }
        return ____moduleCache[file].value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["event"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local function __TS__ArraySlice(self, first, last)
    local len = #self
    local ____first_0 = first
    if ____first_0 == nil then
        ____first_0 = 0
    end
    first = ____first_0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    local ____last_1 = last
    if ____last_1 == nil then
        ____last_1 = len
    end
    last = ____last_1
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

-- End of Lua Library inline imports
local ____exports = {}
____exports.CharEvent = __TS__Class()
local CharEvent = ____exports.CharEvent
CharEvent.name = "CharEvent"
function CharEvent.prototype.____constructor(self)
    self.character = ""
end
function CharEvent.prototype.get_name(self)
    return "char"
end
function CharEvent.prototype.get_args(self)
    return {self.character}
end
function CharEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "char" then
        return nil
    end
    local ev = __TS__New(____exports.CharEvent)
    ev.character = args[2]
    return ev
end
____exports.KeyEvent = __TS__Class()
local KeyEvent = ____exports.KeyEvent
KeyEvent.name = "KeyEvent"
function KeyEvent.prototype.____constructor(self)
    self.key = 0
    self.isHeld = false
    self.isUp = false
end
function KeyEvent.prototype.get_name(self)
    return self.isUp and "key_up" or "key"
end
function KeyEvent.prototype.get_args(self)
    local ____self_key_1 = self.key
    local ____table_isUp_0
    if self.isUp then
        ____table_isUp_0 = nil
    else
        ____table_isUp_0 = self.isHeld
    end
    return {____self_key_1, ____table_isUp_0}
end
function KeyEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "key" and args[1] ~= "key_up" then
        return nil
    end
    local ev = __TS__New(____exports.KeyEvent)
    ev.key = args[2]
    ev.isUp = args[1] == "key_up"
    local ____ev_3 = ev
    local ____ev_isUp_2
    if ev.isUp then
        ____ev_isUp_2 = false
    else
        ____ev_isUp_2 = args[3]
    end
    ____ev_3.isHeld = ____ev_isUp_2
    return ev
end
____exports.PasteEvent = __TS__Class()
local PasteEvent = ____exports.PasteEvent
PasteEvent.name = "PasteEvent"
function PasteEvent.prototype.____constructor(self)
    self.text = ""
end
function PasteEvent.prototype.get_name(self)
    return "paste"
end
function PasteEvent.prototype.get_args(self)
    return {self.text}
end
function PasteEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "paste" then
        return nil
    end
    local ev = __TS__New(____exports.PasteEvent)
    ev.text = args[2]
    return ev
end
____exports.TimerEvent = __TS__Class()
local TimerEvent = ____exports.TimerEvent
TimerEvent.name = "TimerEvent"
function TimerEvent.prototype.____constructor(self)
    self.id = 0
    self.isAlarm = false
end
function TimerEvent.prototype.get_name(self)
    return self.isAlarm and "alarm" or "timer"
end
function TimerEvent.prototype.get_args(self)
    return {self.id}
end
function TimerEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "timer" and args[1] ~= "alarm" then
        return nil
    end
    local ev = __TS__New(____exports.TimerEvent)
    ev.id = args[2]
    ev.isAlarm = args[1] == "alarm"
    return ev
end
____exports.TaskCompleteEvent = __TS__Class()
local TaskCompleteEvent = ____exports.TaskCompleteEvent
TaskCompleteEvent.name = "TaskCompleteEvent"
function TaskCompleteEvent.prototype.____constructor(self)
    self.id = 0
    self.success = false
    self.error = nil
    self.params = {}
end
function TaskCompleteEvent.prototype.get_name(self)
    return "task_complete"
end
function TaskCompleteEvent.prototype.get_args(self)
    if self.success then
        return __TS__ArrayConcat({self.id, self.success}, self.params)
    else
        return {self.id, self.success, self.error}
    end
end
function TaskCompleteEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "task_complete" then
        return nil
    end
    local ev = __TS__New(____exports.TaskCompleteEvent)
    ev.id = args[2]
    ev.success = args[3]
    if ev.success then
        ev.error = nil
        ev.params = __TS__ArraySlice(args, 3)
    else
        ev.error = args[4]
        ev.params = {}
    end
    return ev
end
____exports.RedstoneEvent = __TS__Class()
local RedstoneEvent = ____exports.RedstoneEvent
RedstoneEvent.name = "RedstoneEvent"
function RedstoneEvent.prototype.____constructor(self)
end
function RedstoneEvent.prototype.get_name(self)
    return "redstone"
end
function RedstoneEvent.prototype.get_args(self)
    return {}
end
function RedstoneEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "redstone" then
        return nil
    end
    local ev = __TS__New(____exports.RedstoneEvent)
    return ev
end
____exports.TerminateEvent = __TS__Class()
local TerminateEvent = ____exports.TerminateEvent
TerminateEvent.name = "TerminateEvent"
function TerminateEvent.prototype.____constructor(self)
end
function TerminateEvent.prototype.get_name(self)
    return "terminate"
end
function TerminateEvent.prototype.get_args(self)
    return {}
end
function TerminateEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "terminate" then
        return nil
    end
    local ev = __TS__New(____exports.TerminateEvent)
    return ev
end
____exports.DiskEvent = __TS__Class()
local DiskEvent = ____exports.DiskEvent
DiskEvent.name = "DiskEvent"
function DiskEvent.prototype.____constructor(self)
    self.side = ""
    self.eject = false
end
function DiskEvent.prototype.get_name(self)
    return self.eject and "disk_eject" or "disk"
end
function DiskEvent.prototype.get_args(self)
    return {self.side}
end
function DiskEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "disk" and args[1] ~= "disk_eject" then
        return nil
    end
    local ev = __TS__New(____exports.DiskEvent)
    ev.side = args[2]
    ev.eject = args[1] == "disk_eject"
    return ev
end
____exports.PeripheralEvent = __TS__Class()
local PeripheralEvent = ____exports.PeripheralEvent
PeripheralEvent.name = "PeripheralEvent"
function PeripheralEvent.prototype.____constructor(self)
    self.side = ""
    self.detach = false
end
function PeripheralEvent.prototype.get_name(self)
    return self.detach and "peripheral_detach" or "peripheral"
end
function PeripheralEvent.prototype.get_args(self)
    return {self.side}
end
function PeripheralEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "peripheral" and args[1] ~= "peripheral_detach" then
        return nil
    end
    local ev = __TS__New(____exports.PeripheralEvent)
    ev.side = args[2]
    ev.detach = args[1] == "peripheral_detach"
    return ev
end
____exports.RednetMessageEvent = __TS__Class()
local RednetMessageEvent = ____exports.RednetMessageEvent
RednetMessageEvent.name = "RednetMessageEvent"
function RednetMessageEvent.prototype.____constructor(self)
    self.sender = 0
    self.protocol = nil
end
function RednetMessageEvent.prototype.get_name(self)
    return "rednet_message"
end
function RednetMessageEvent.prototype.get_args(self)
    return {self.sender, self.message, self.protocol}
end
function RednetMessageEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "rednet_message" then
        return nil
    end
    local ev = __TS__New(____exports.RednetMessageEvent)
    ev.sender = args[2]
    ev.message = args[3]
    ev.protocol = args[4]
    return ev
end
____exports.ModemMessageEvent = __TS__Class()
local ModemMessageEvent = ____exports.ModemMessageEvent
ModemMessageEvent.name = "ModemMessageEvent"
function ModemMessageEvent.prototype.____constructor(self)
    self.side = ""
    self.channel = 0
    self.replyChannel = 0
    self.distance = 0
end
function ModemMessageEvent.prototype.get_name(self)
    return "modem_message"
end
function ModemMessageEvent.prototype.get_args(self)
    return {
        self.side,
        self.channel,
        self.replyChannel,
        self.message,
        self.distance
    }
end
function ModemMessageEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "modem_message" then
        return nil
    end
    local ev = __TS__New(____exports.ModemMessageEvent)
    ev.side = args[2]
    ev.channel = args[3]
    ev.replyChannel = args[4]
    ev.message = args[5]
    ev.distance = args[6]
    return ev
end
____exports.HTTPEvent = __TS__Class()
local HTTPEvent = ____exports.HTTPEvent
HTTPEvent.name = "HTTPEvent"
function HTTPEvent.prototype.____constructor(self)
    self.url = ""
    self.handle = nil
    self.error = nil
end
function HTTPEvent.prototype.get_name(self)
    return self.error == nil and "http_success" or "http_failure"
end
function HTTPEvent.prototype.get_args(self)
    local ____self_url_6 = self.url
    local ____temp_4
    if self.error == nil then
        ____temp_4 = self.handle
    else
        ____temp_4 = self.error
    end
    local ____temp_5
    if self.error ~= nil then
        ____temp_5 = self.handle
    else
        ____temp_5 = nil
    end
    return {____self_url_6, ____temp_4, ____temp_5}
end
function HTTPEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "http_success" and args[1] ~= "http_failure" then
        return nil
    end
    local ev = __TS__New(____exports.HTTPEvent)
    ev.url = args[2]
    if args[1] == "http_success" then
        ev.error = nil
        ev.handle = args[3]
    else
        ev.error = args[3]
        if ev.error == nil then
            ev.error = ""
        end
        ev.handle = args[4]
    end
    return ev
end
____exports.WebSocketEvent = __TS__Class()
local WebSocketEvent = ____exports.WebSocketEvent
WebSocketEvent.name = "WebSocketEvent"
function WebSocketEvent.prototype.____constructor(self)
    self.handle = nil
    self.error = nil
end
function WebSocketEvent.prototype.get_name(self)
    return self.error == nil and "websocket_success" or "websocket_failure"
end
function WebSocketEvent.prototype.get_args(self)
    local ____temp_7
    if self.handle == nil then
        ____temp_7 = self.error
    else
        ____temp_7 = self.handle
    end
    return {____temp_7}
end
function WebSocketEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "websocket_success" and args[1] ~= "websocket_failure" then
        return nil
    end
    local ev = __TS__New(____exports.WebSocketEvent)
    if args[1] == "websocket_success" then
        ev.handle = args[2]
        ev.error = nil
    else
        ev.error = args[2]
        ev.handle = nil
    end
    return ev
end
____exports.MouseEventType = MouseEventType or ({})
____exports.MouseEventType.Click = 0
____exports.MouseEventType[____exports.MouseEventType.Click] = "Click"
____exports.MouseEventType.Up = 1
____exports.MouseEventType[____exports.MouseEventType.Up] = "Up"
____exports.MouseEventType.Scroll = 2
____exports.MouseEventType[____exports.MouseEventType.Scroll] = "Scroll"
____exports.MouseEventType.Drag = 3
____exports.MouseEventType[____exports.MouseEventType.Drag] = "Drag"
____exports.MouseEventType.Touch = 4
____exports.MouseEventType[____exports.MouseEventType.Touch] = "Touch"
____exports.MouseEventType.Move = 5
____exports.MouseEventType[____exports.MouseEventType.Move] = "Move"
____exports.MouseEvent = __TS__Class()
local MouseEvent = ____exports.MouseEvent
MouseEvent.name = "MouseEvent"
function MouseEvent.prototype.____constructor(self)
    self.button = 0
    self.x = 0
    self.y = 0
    self.side = nil
    self.type = ____exports.MouseEventType.Click
end
function MouseEvent.prototype.get_name(self)
    return ({
        [____exports.MouseEventType.Click] = "mouse_click",
        [____exports.MouseEventType.Up] = "mouse_up",
        [____exports.MouseEventType.Scroll] = "mouse_scroll",
        [____exports.MouseEventType.Drag] = "mouse_drag",
        [____exports.MouseEventType.Touch] = "monitor_touch",
        [____exports.MouseEventType.Move] = "mouse_move"
    })[self.type]
end
function MouseEvent.prototype.get_args(self)
    local ____temp_8
    if self.type == ____exports.MouseEventType.Touch then
        ____temp_8 = self.side
    else
        ____temp_8 = self.button
    end
    return {____temp_8, self.x, self.y}
end
function MouseEvent.init(self, args)
    if not (type(args[1]) == "string") then
        return nil
    end
    local ev = __TS__New(____exports.MouseEvent)
    local ____type = args[1]
    if ____type == "mouse_click" then
        ev.type = ____exports.MouseEventType.Click
        ev.button = args[2]
        ev.side = nil
    elseif ____type == "mouse_up" then
        ev.type = ____exports.MouseEventType.Up
        ev.button = args[2]
        ev.side = nil
    elseif ____type == "mouse_scroll" then
        ev.type = ____exports.MouseEventType.Scroll
        ev.button = args[2]
        ev.side = nil
    elseif ____type == "mouse_drag" then
        ev.type = ____exports.MouseEventType.Drag
        ev.button = args[2]
        ev.side = nil
    elseif ____type == "monitor_touch" then
        ev.type = ____exports.MouseEventType.Touch
        ev.button = 0
        ev.side = args[2]
    elseif ____type == "mouse_move" then
        ev.type = ____exports.MouseEventType.Move
        ev.button = args[2]
        ev.side = nil
    else
        return nil
    end
    ev.x = args[3]
    ev.y = args[4]
    return ev
end
____exports.ResizeEvent = __TS__Class()
local ResizeEvent = ____exports.ResizeEvent
ResizeEvent.name = "ResizeEvent"
function ResizeEvent.prototype.____constructor(self)
    self.side = nil
end
function ResizeEvent.prototype.get_name(self)
    return self.side == nil and "term_resize" or "monitor_resize"
end
function ResizeEvent.prototype.get_args(self)
    return {self.side}
end
function ResizeEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "term_resize" and args[1] ~= "monitor_resize" then
        return nil
    end
    local ev = __TS__New(____exports.ResizeEvent)
    if args[1] == "monitor_resize" then
        ev.side = args[2]
    else
        ev.side = nil
    end
    return ev
end
____exports.TurtleInventoryEvent = __TS__Class()
local TurtleInventoryEvent = ____exports.TurtleInventoryEvent
TurtleInventoryEvent.name = "TurtleInventoryEvent"
function TurtleInventoryEvent.prototype.____constructor(self)
end
function TurtleInventoryEvent.prototype.get_name(self)
    return "turtle_inventory"
end
function TurtleInventoryEvent.prototype.get_args(self)
    return {}
end
function TurtleInventoryEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "turtle_inventory" then
        return nil
    end
    local ev = __TS__New(____exports.TurtleInventoryEvent)
    return ev
end
local SpeakerAudioEmptyEvent = __TS__Class()
SpeakerAudioEmptyEvent.name = "SpeakerAudioEmptyEvent"
function SpeakerAudioEmptyEvent.prototype.____constructor(self)
    self.side = ""
end
function SpeakerAudioEmptyEvent.prototype.get_name(self)
    return "speaker_audio_empty"
end
function SpeakerAudioEmptyEvent.prototype.get_args(self)
    return {self.side}
end
function SpeakerAudioEmptyEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "speaker_audio_empty" then
        return nil
    end
    local ev
    ev.side = args[2]
    return ev
end
local ComputerCommandEvent = __TS__Class()
ComputerCommandEvent.name = "ComputerCommandEvent"
function ComputerCommandEvent.prototype.____constructor(self)
    self.args = {}
end
function ComputerCommandEvent.prototype.get_name(self)
    return "computer_command"
end
function ComputerCommandEvent.prototype.get_args(self)
    return self.args
end
function ComputerCommandEvent.init(self, args)
    if not (type(args[1]) == "string") or args[1] ~= "computer_command" then
        return nil
    end
    local ev
    ev.args = __TS__ArraySlice(args, 1)
    return ev
end
____exports.GenericEvent = __TS__Class()
local GenericEvent = ____exports.GenericEvent
GenericEvent.name = "GenericEvent"
function GenericEvent.prototype.____constructor(self)
    self.args = {}
end
function GenericEvent.prototype.get_name(self)
    return self.args[1]
end
function GenericEvent.prototype.get_args(self)
    return __TS__ArraySlice(self.args, 1)
end
function GenericEvent.init(self, args)
    local ev = __TS__New(____exports.GenericEvent)
    ev.args = args
    return ev
end
local eventInitializers = {
    ____exports.CharEvent.init,
    ____exports.KeyEvent.init,
    ____exports.PasteEvent.init,
    ____exports.TimerEvent.init,
    ____exports.TaskCompleteEvent.init,
    ____exports.RedstoneEvent.init,
    ____exports.TerminateEvent.init,
    ____exports.DiskEvent.init,
    ____exports.PeripheralEvent.init,
    ____exports.RednetMessageEvent.init,
    ____exports.ModemMessageEvent.init,
    ____exports.HTTPEvent.init,
    ____exports.WebSocketEvent.init,
    ____exports.MouseEvent.init,
    ____exports.ResizeEvent.init,
    ____exports.TurtleInventoryEvent.init,
    SpeakerAudioEmptyEvent.init,
    ComputerCommandEvent.init,
    ____exports.GenericEvent.init
}
function ____exports.pullEventRaw(self, filter)
    if filter == nil then
        filter = nil
    end
    local args = table.pack({coroutine.yield(filter)})
    for ____, init in ipairs(eventInitializers) do
        local ev = init(nil, args)
        if ev ~= nil then
            return ev
        end
    end
    return ____exports.GenericEvent:init(args)
end
function ____exports.pullEvent(self, filter)
    if filter == nil then
        filter = nil
    end
    local ev = ____exports.pullEventRaw(nil, filter)
    if __TS__InstanceOf(ev, ____exports.TerminateEvent) then
        error("Terminated", 0)
    end
    return ev
end
function ____exports.pullEventRawAs(self, ____type, filter)
    if filter == nil then
        filter = nil
    end
    local ev = ____exports.pullEventRaw(nil, filter)
    if __TS__InstanceOf(ev, ____type) then
        return ev
    else
        return nil
    end
end
function ____exports.pullEventAs(self, ____type, filter)
    if filter == nil then
        filter = nil
    end
    local ev = ____exports.pullEvent(nil, filter)
    if __TS__InstanceOf(ev, ____type) then
        return ev
    else
        return nil
    end
end
return ____exports
 end,
["config.inventories"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
return ____exports
 end,
["farmer"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ObjectValues(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = obj[key]
    end
    return result
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

-- End of Lua Library inline imports
local ____exports = {}
local Direction = Direction or ({})
Direction.North = 0
Direction[Direction.North] = "North"
Direction.East = 1
Direction[Direction.East] = "East"
Direction.South = 2
Direction[Direction.South] = "South"
Direction.West = 3
Direction[Direction.West] = "West"
local NO_Z = 0
local FUEL_SOURCE = "minecraft:charcoal"
local PLANT = {
    ["minecraft:potatoes"] = {name = "minecraft:potatoes", products = {"minecraft:potato", "minecraft:poisonous_potato"}, seed = "minecraft:potato", maxStage = 7},
    ["minecraft:wheat"] = {name = "minecraft:wheat", products = {"minecraft:wheat", "minecraft:wheat_seeds"}, seed = "minecraft:wheat_seeds", maxStage = 7},
    ["mysticalagriculture:inferium_crop"] = {name = "mysticalagriculture:inferium_crop", products = {"mysticalagriculture:inferium_essence", "mysticalagriculture:inferium_seeds", "mysticalagriculture:fertilized_essence"}, seed = "mysticalagriculture:inferium_seeds", maxStage = 7},
    ["mysticalagriculture:iron_crop"] = {name = "mysticalagriculture:iron_crop", products = {"mysticalagriculture:iron_essence", "mysticalagriculture:iron_seeds"}, seed = "mysticalagriculture:iron_seeds", maxStage = 7},
    ["mysticalagriculture:brass_crop"] = {name = "mysticalagriculture:brass_crop", products = {"mysticalagriculture:brass_essence", "mysticalagriculture:brass_seeds"}, seed = "mysticalagriculture:brass_seeds", maxStage = 7}
}
local FARMER_STATE = FARMER_STATE or ({})
FARMER_STATE.INIT = 0
FARMER_STATE[FARMER_STATE.INIT] = "INIT"
FARMER_STATE.CHECK_PLANTS = 1
FARMER_STATE[FARMER_STATE.CHECK_PLANTS] = "CHECK_PLANTS"
FARMER_STATE.REFUEL = 2
FARMER_STATE[FARMER_STATE.REFUEL] = "REFUEL"
FARMER_STATE.INVENTORY = 3
FARMER_STATE[FARMER_STATE.INVENTORY] = "INVENTORY"
FARMER_STATE.SLEEP = 4
FARMER_STATE[FARMER_STATE.SLEEP] = "SLEEP"
____exports.Farmer = __TS__Class()
local Farmer = ____exports.Farmer
Farmer.name = "Farmer"
function Farmer.prototype.____constructor(self)
    self.faceDirection = Direction.North
    self.currentLocation = vector.new(0, 0, NO_Z)
    self.startPosition = vector.new(0, 0, NO_Z)
    self.nextPlant = {0, 0}
    self.state = FARMER_STATE.INIT
    if self:fileExists("farmstate.json") then
        local data = self:getFileData("farmstate.json")
        if data then
            local read = textutils.unserialiseJSON(data)
            self.farmMaxY = read.farmMaxY
            self.farmMaxX = read.farmMaxX
            self.farm = read.farm
            self.faceDirection = read.faceDirection
            self.nextPlant = read.nextPlant
            self.currentLocation = vector.new(read.currentLocation[1], read.currentLocation[2], NO_Z)
            self.state = read.state
            self.inventories = read.inventories
            self.priorityStorage = read.priorityStorage
        end
        return
    end
    if not self:scanInventories() then
        return
    end
    local farmSize = self:getFarmSize()
    if not farmSize then
        self:resetTurtle()
        return
    end
    self.farmMaxX = farmSize[1]
    self.farmMaxY = farmSize[2]
    self.farm = self:scanFarm()
    self:resetTurtle()
    return
end
function Farmer.prototype.loop(self)
    repeat
        local ____switch8 = self.state
        local slots, itemSlot, container, plantName, plant, x, y
        local ____cond8 = ____switch8 == FARMER_STATE.INVENTORY
        if ____cond8 then
            print("INVENTORY MANAGEMENT")
            slots = self:optimiseInventory()
            if slots >= 4 then
                self.state = FARMER_STATE.CHECK_PLANTS
                break
            end
            self:dumpInventory()
            self.state = FARMER_STATE.CHECK_PLANTS
            break
        end
        ____cond8 = ____cond8 or ____switch8 == FARMER_STATE.REFUEL
        if ____cond8 then
            print("REFUEL")
            itemSlot = self:findItem(FUEL_SOURCE)
            if itemSlot then
                turtle.select(itemSlot + 1)
                turtle.refuel()
                self.state = FARMER_STATE.CHECK_PLANTS
                break
            end
            container = self.priorityStorage[FUEL_SOURCE]
            self:walkTo(container.location)
            turtle.suckDown()
            break
        end
        ____cond8 = ____cond8 or ____switch8 == FARMER_STATE.INIT
        if ____cond8 then
            if not self.farmMaxX or not self.farmMaxY or not self.farm then
                self:resetTurtle()
                return false
            end
            self.state = FARMER_STATE.CHECK_PLANTS
            self.nextPlant = {0, 0}
            self:writeState()
            break
        end
        ____cond8 = ____cond8 or ____switch8 == FARMER_STATE.SLEEP
        if ____cond8 then
            print("SLEEP")
            sleep(20)
            self.state = FARMER_STATE.CHECK_PLANTS
            self.nextPlant = {0, 0}
            break
        end
        ____cond8 = ____cond8 or ____switch8 == FARMER_STATE.CHECK_PLANTS
        if ____cond8 then
            if self:maintenanceNeeded() then
                break
            end
            self:walkToPoint({self.nextPlant[1], self.nextPlant[2] + 1})
            plantName = self.farm[(tostring(self.nextPlant[1]) .. "_") .. tostring(self.nextPlant[2])]
            plant = plantName and PLANT[self.farm[(tostring(self.nextPlant[1]) .. "_") .. tostring(self.nextPlant[2])]]
            print((tostring(self.nextPlant[1]) .. "_") .. tostring(self.nextPlant[2]))
            if plant then
                local block = self:getBlockInfo()
                if not block then
                    local seedItem = self:findItem(plant.seed)
                    if seedItem ~= nil then
                        turtle.select(seedItem + 1)
                        turtle.placeDown()
                    end
                elseif plant.name == block.name then
                    local plantBlock = block
                    local ____print_3 = print
                    local ____plant_name_2 = plant.name
                    local ____plantBlock_state_age_0 = plantBlock.state
                    if ____plantBlock_state_age_0 ~= nil then
                        ____plantBlock_state_age_0 = ____plantBlock_state_age_0.age
                    end
                    ____print_3(((((____plant_name_2 .. " (") .. tostring(____plantBlock_state_age_0)) .. "/") .. tostring(plant.maxStage)) .. ")")
                    local ____plantBlock_state_age_4 = plantBlock.state
                    if ____plantBlock_state_age_4 ~= nil then
                        ____plantBlock_state_age_4 = ____plantBlock_state_age_4.age
                    end
                    if ____plantBlock_state_age_4 == plant.maxStage then
                        self:replacePlant(plant)
                    end
                end
            end
            x = self.nextPlant[1]
            y = self.nextPlant[2]
            if x % 2 == 1 then
                if y == 0 then
                    if x == self.farmMaxX - 1 then
                        self.state = FARMER_STATE.SLEEP
                        self:walkTo(self.startPosition)
                        break
                    end
                    local ____self_nextPlant_6, ____1_7 = self.nextPlant, 1
                    ____self_nextPlant_6[____1_7] = ____self_nextPlant_6[____1_7] + 1
                    self.nextPlant[2] = 0
                else
                    local ____self_nextPlant_8, ____2_9 = self.nextPlant, 2
                    ____self_nextPlant_8[____2_9] = ____self_nextPlant_8[____2_9] - 1
                end
            else
                if y == self.farmMaxY - 1 then
                    if x == self.farmMaxX - 1 then
                        self.state = FARMER_STATE.SLEEP
                        self:walkTo(self.startPosition)
                        break
                    end
                    local ____self_nextPlant_10, ____1_11 = self.nextPlant, 1
                    ____self_nextPlant_10[____1_11] = ____self_nextPlant_10[____1_11] + 1
                    self.nextPlant[2] = self.farmMaxY - 1
                else
                    local ____self_nextPlant_12, ____2_13 = self.nextPlant, 2
                    ____self_nextPlant_12[____2_13] = ____self_nextPlant_12[____2_13] + 1
                end
            end
            break
        end
    until true
    return true
end
function Farmer.prototype.resetTurtle(self)
    self:walkTo(self.startPosition)
    self:setFacingDirection(Direction.North)
end
function Farmer.prototype.setFacingDirection(self, direction)
    local difference = (direction - self.faceDirection + 4) % 4
    if difference == 0 then
        return
    end
    if difference == 3 then
        turtle.turnLeft()
    else
        do
            local i = 0
            while i < difference do
                turtle.turnRight()
                i = i + 1
            end
        end
    end
    self.faceDirection = direction
    self:writeState()
end
function Farmer.prototype.findPlantDefinition(self, name)
    for ____, plant in ipairs(__TS__ObjectValues(PLANT)) do
        if name == plant.name then
            return plant
        end
    end
    return nil
end
function Farmer.prototype.findPlantDefinitionFromSeed(self, seedName)
    for ____, plant in ipairs(__TS__ObjectValues(PLANT)) do
        if seedName == plant.seed then
            return plant
        end
    end
    return nil
end
function Farmer.prototype.walkTo(self, destination)
    print(((("Walking To (" .. tostring(destination.x)) .. ", ") .. tostring(destination.y)) .. ")")
    local vecotriesed = vector.new(destination.x, destination.y, destination.z)
    local difference = vecotriesed:sub(self.currentLocation)
    while difference.x ~= 0 or difference.y ~= 0 do
        if difference.x > 0 then
            self:setFacingDirection(Direction.East)
            if turtle.forward() then
                self.currentLocation = self.currentLocation:add(vector.new(1, 0, NO_Z))
            else
                return false
            end
        elseif difference.x < 0 then
            self:setFacingDirection(Direction.West)
            if turtle.forward() then
                self.currentLocation = self.currentLocation:add(vector.new(-1, 0, NO_Z))
            else
                return false
            end
        elseif difference.y > 0 then
            self:setFacingDirection(Direction.North)
            if turtle.forward() then
                self.currentLocation = self.currentLocation:add(vector.new(0, 1, NO_Z))
            else
                return false
            end
        elseif difference.y < 0 then
            self:setFacingDirection(Direction.South)
            if turtle.forward() then
                self.currentLocation = self.currentLocation:add(vector.new(0, -1, NO_Z))
            else
                return false
            end
        end
        difference = vecotriesed:sub(self.currentLocation)
        self:writeState()
    end
    return true
end
function Farmer.prototype.dumpInventory(self)
    print("DUMPING INVENTORY")
    do
        local i = 0
        while i < 16 do
            turtle.select(i + 1)
            local inventoryItem = turtle.getItemDetail(i + 1)
            if inventoryItem then
                local isDone = false
                local storageInventory = self.priorityStorage[inventoryItem.name]
                if storageInventory then
                    print(storageInventory.location)
                    self:walkTo(vector.new(storageInventory.location.x, storageInventory.location.y, storageInventory.location.z))
                    if turtle.dropDown() then
                        isDone = true
                    end
                end
                if not isDone then
                    for ____, inventory in ipairs(self.inventories) do
                        self:walkTo(vector.new(inventory.location.x, inventory.location.y, inventory.location.z))
                        if turtle.dropDown() then
                            break
                        end
                    end
                end
            end
            i = i + 1
        end
    end
end
function Farmer.prototype.getBlockInfo(self)
    local hasBlock, blockInfo = table.unpack({turtle.inspectDown()})
    if hasBlock and type(blockInfo) == "table" then
        return blockInfo
    end
end
function Farmer.prototype.getPeripheralType(self)
    local peripheralName, peripheralType = peripheral.getType("bottom")
    if peripheralName and peripheralType then
        return {name = peripheralName, type = peripheralType}
    end
    return nil
end
function Farmer.prototype.getFarmSize(self)
    local farmSize = {1, 1}
    local foundMaxY = false
    local foundMaxX = false
    if not self:walkTo(vector.new(0, 1, NO_Z)) then
        return nil
    end
    while not foundMaxY do
        local current = self:getBlockInfo()
        if not current or not self:findPlantDefinition(current.name) then
            foundMaxY = true
            farmSize[2] = farmSize[2] - 1
            break
        end
        if not self:walkTo(self.currentLocation:add(vector.new(0, 1, NO_Z))) then
            foundMaxY = true
            break
        end
        farmSize[2] = farmSize[2] + 1
    end
    if not self:walkTo(vector.new(0, 1, NO_Z)) then
        return nil
    end
    while not foundMaxX do
        local current = self:getBlockInfo()
        if not current or not self:findPlantDefinition(current.name) then
            foundMaxX = true
            farmSize[1] = farmSize[1] - 1
            break
        end
        if not self:walkTo(self.currentLocation:add(vector.new(1, 0, NO_Z))) then
            foundMaxX = true
            break
        end
        farmSize[1] = farmSize[1] + 1
    end
    return farmSize
end
function Farmer.prototype.scanInventories(self)
    local inventories = {}
    local priorityStorage = {}
    if not self:walkTo(vector.new(0, 0, NO_Z)) then
        return false
    end
    local foundMax = false
    while not foundMax do
        if not self.currentLocation:equals(self.startPosition) then
            local current = self:getPeripheralType()
            if current and current.type == "inventory" then
                if __TS__StringIncludes(current.name, "drawers") then
                    local inventoryPeripheral = peripheral.wrap("bottom")
                    do
                        local i = 1
                        while i < inventoryPeripheral.size() + 1 do
                            local item = inventoryPeripheral.getItemDetail(i)
                            if item and item.name then
                                priorityStorage[item.name] = {items = {[item.name] = item.count}, location = self.currentLocation}
                            end
                            i = i + 1
                        end
                    end
                else
                    local items = {}
                    local inventoryPeripheral = peripheral.wrap("bottom")
                    do
                        local i = 1
                        while i < inventoryPeripheral.size() + 1 do
                            local item = inventoryPeripheral.getItemDetail(i)
                            if item and item.name then
                                items[item.name] = item.count
                            end
                            i = i + 1
                        end
                    end
                    inventories[#inventories + 1] = {items = items, location = self.currentLocation}
                end
            else
                foundMax = true
            end
        end
        if not self:walkTo(self.currentLocation:add(vector.new(1, 0, NO_Z))) then
            foundMax = true
            break
        end
    end
    self.inventories = inventories
    self.priorityStorage = priorityStorage
    return true
end
function Farmer.prototype.scanFarm(self)
    local farm = {}
    do
        local x = 0
        while x < self.farmMaxX do
            local function walkToCheck(____, x1, y1)
                self:walkTo(vector.new(x1, y1 + 1, NO_Z))
                local block = self:getBlockInfo()
                if block and self:findPlantDefinition(block.name) then
                    farm[(tostring(x) .. "_") .. tostring(y1)] = self:findPlantDefinition(block.name).name
                    print((((("(" .. tostring(x)) .. ",") .. tostring(y1)) .. "): ") .. farm[(tostring(x) .. "_") .. tostring(y1)])
                end
            end
            if x % 2 == 1 then
                do
                    local y = self.farmMaxY - 1
                    while y >= 0 do
                        walkToCheck(nil, x, y)
                        y = y - 1
                    end
                end
            else
                do
                    local y = 0
                    while y < self.farmMaxY do
                        walkToCheck(nil, x, y)
                        y = y + 1
                    end
                end
            end
            x = x + 1
        end
    end
    return farm
end
function Farmer.prototype.getOpenSlots(self)
    local openCount = 0
    do
        local i = 0
        while i < 16 do
            local inventoryItem = turtle.getItemDetail(i + 1)
            if not inventoryItem then
                openCount = openCount + 1
            end
            i = i + 1
        end
    end
    return openCount
end
function Farmer.prototype.walkToPoint(self, point)
    return self:walkTo(vector.new(point[1], point[2], NO_Z))
end
function Farmer.prototype.replacePlant(self, plant)
    local seedItem = self:findItem(plant.seed)
    if seedItem then
        turtle.select(seedItem + 1)
    end
    turtle.digDown()
    seedItem = self:findItem(plant.seed)
    if seedItem == nil then
        return
    end
    turtle.select(seedItem + 1)
    turtle.placeDown()
end
function Farmer.prototype.findItem(self, itemName)
    do
        local i = 0
        while i < 16 do
            local inventoryItem = turtle.getItemDetail(i + 1)
            if inventoryItem and inventoryItem.name == itemName then
                return i
            end
            i = i + 1
        end
    end
    return nil
end
function Farmer.prototype.fileExists(self, filename)
    local file, ____error = io.open(filename, "r")
    local exists = file ~= nil
    if exists then
        io.close(file)
    end
    return exists
end
function Farmer.prototype.optimiseInventory(self)
    do
        local i = 0
        while i < 16 do
            local inventoryItem = turtle.getItemDetail(i + 1)
            if inventoryItem then
                do
                    local j = i
                    while j < 16 do
                        local otherItem = turtle.getItemDetail(j + 1)
                        if otherItem and otherItem.name == inventoryItem.name then
                            turtle.select(j + 1)
                            turtle.transferTo(i + 1)
                        end
                        j = j + 1
                    end
                end
            end
            i = i + 1
        end
    end
    return self:getOpenSlots()
end
function Farmer.prototype.getFileData(self, filename)
    local file, ____error = io.open(filename, "r")
    if file then
        local line = file:read()
        local content = ""
        while line do
            content = (content .. "\n") .. line
            line = file:read()
        end
        return content
    end
    return nil
end
function Farmer.prototype.writeState(self)
    if self.state == FARMER_STATE.INIT then
        return
    end
    local file, ____error = io.open("farmstate.json", "w")
    file:write(textutils.serialiseJSON({
        farmMaxX = self.farmMaxX,
        farmMaxY = self.farmMaxY,
        faceDirection = self.faceDirection,
        currentLocation = {self.currentLocation.x, self.currentLocation.y},
        nextPlant = self.nextPlant,
        state = self.state,
        farm = self.farm,
        inventories = self.inventories,
        priorityStorage = self.priorityStorage
    }))
    io.close(file)
end
function Farmer.prototype.maintenanceNeeded(self)
    if self:getOpenSlots() <= 3 then
        self.state = FARMER_STATE.INVENTORY
        return true
    end
    if turtle.getFuelLevel() - 3450 <= self.farmMaxY + 1 + self.farmMaxX + 1 then
        self.state = FARMER_STATE.REFUEL
        return true
    end
    return false
end
return ____exports
 end,
["main"] = function(...) 
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

-- End of Lua Library inline imports
local ____exports = {}
local ____farmer = require("farmer")
local Farmer = ____farmer.Farmer
xpcall(
    function()
        local farmer = __TS__New(Farmer)
        local running = true
        while running do
            running = farmer:loop()
        end
    end,
    function(err) return print(textutils.serialise(err)) end
)
return ____exports
 end,
}
return require("main", ...)
