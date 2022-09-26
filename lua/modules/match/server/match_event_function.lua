local event = {}
local MatchRoom = require("modules.match.server.room.match_room")
event["ENTITY_ENTER"] = function(p)
    print("HÀM THỨ 1")
    local keyId = nil
    for k, v in pairs(Global.listRoom) do
        if v:getRoomStatus() == 0 then
            keyId = k
            break
        end
    end
    if keyId == nil then
        keyId = Server.CurServer:getGameId() .."_".. tostring(os.time(os.date("!*t")))
        Global.listRoom[keyId] = MatchRoom:create()
        Global.listRoom[keyId]:init(keyId)
        Global.listRoom[keyId]:roomListenning()
    end
    Global.listRoom[keyId]:addPlayer(p.obj1.platformUserId)
    Lib.logs("Add player: "..p.obj1.name)
    Lib.logs(Global.listRoom[keyId])
end
event["ENTITY_LEAVE"] = function(p)
    for k,v in pairs(Global.listRoom) do
        if v:isInRoom(p.obj1.platformUserId) then
            v:removePlayer(p.obj1.platformUserId)
            Lib.logs("Remove player: "..p.obj1.name)
            Lib.logs(Global.listRoom[k])
            break
        end
    end
end
return event
