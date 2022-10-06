local event = {}
local MatchRoom = require("modules.match.server.room.match_room")
event["ENTITY_ENTER"] = function(p)
    Global.ui("ui/popup", p.obj1, {})
    local keyId = nil
    -- for k, v in pairs(Global.listRoom) do
    --     if v:getRoomStatus() <= 2 then
    --         keyId = k
    --         break
    --     end
    -- end
    if Lib.getTableSize(Global.listRoom) > 0 then
        for k, v in pairs(Global.listRoom) do
            keyId = k
            break
        end
    end
    if keyId == nil then
        keyId = Server.CurServer:getGameId() .. "_" .. tostring(os.time(os.date("!*t")))
        Global.listRoom[keyId] = MatchRoom:create()
        local map = World:GetMapByID(Define.MATCH.LOBBY)
        Global.listRoom[keyId]:init(keyId, map)
        Global.listRoom[keyId]:roomListenning()
    end
    if Global.listRoom[keyId]:getRoomStatus()>=2 or Global.listRoom[keyId]:getRoomStatus()==-1 then
        Global.listRoom[keyId]:addWaiting(p.obj1.platformUserId)
    else
        Global.listRoom[keyId]:addPlayer(p.obj1.platformUserId)
    end
    Lib.logs("Add player: " .. p.obj1.name)
    Lib.logs(Global.listRoom[keyId])
    local tray = p.obj1:tray()
    Lib.pv(tray)
end
event["ENTITY_LEAVE"] = function(p)
    for k, v in pairs(Global.listRoom) do
        if v:isInRoom(p.obj1.platformUserId) then
            v:removePlayer(p.obj1.platformUserId)
            Lib.logs("Remove player: " .. p.obj1.name)
            Lib.logs(Global.listRoom[k])
            break
        end
    end
end
event["ENTITY_DIE"] = function(p)
    local victim = p.obj1
    local killer = p.obj2
    if killer then
        for k, v in pairs(Global.listRoom) do
            if v:isInRoom(victim.platformUserId) then
                if v:isPolice(killer.platformUserId) then
                    if not (v:isMurder(victim.platformUserId)) and not (v:isPolice(victim.platformUserId)) then
                        v:kill(killer.platformUserId,true)
                        killer:kill()
                    end
                end
                v:kill(victim.platformUserId)
                print(Lib.pv(v))
                break
            end
        end
    end
end
return event
