local event = {}
local MatchRoom = require("modules.match.server.room.match_room")
local function CompareTwoTable(t1, t2)
    for k, v in pairs(t2) do
        if t1[k] == nil then
            t1[k] = v
        end
        if type(v)=="table" then
            t1[k]=CompareTwoTable(t1[k], v)
        end
    end
    return t1
end


event["ENTITY_ENTER"] = function(p)
    local player=p.obj1
    local format_player_data=require "modules.player.common.define_player_data"
    for k,v in pairs(format_player_data) do
        local current_data=player:getValue(tostring(k))
        if current_data==nil then
            --player:setValue(tostring(k),v)
            Entity.addValueDef(tostring(k), v, true, true, true, false)
        else
            local update_data=CompareTwoTable(current_data,v)
            player:setValue(tostring(k),update_data)
        end
    end
    local playerClass = require "lua.modules.player.server.player"
    local playerBase = playerClass:create()
    
    playerBase:init()
    Entity.addValueDef("temporary", playerBase, true, true, false, false)

end
event["ENTITY_TOUCHDOWN"]=function (p)
    for k, v in pairs(Global.listRoom) do
        if v:isInRoom(p.obj1.platformUserId) then
            v:removePlayer(p.obj1.platformUserId)
            break
        end
    end
end
return event
