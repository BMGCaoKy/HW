local MatchRoom = require("modules.match.server.room.match_room")
PackageHandlers:Receive("GET_ROOM_INFORM",function (player,packet)
    for k,v in pairs(Global.listRoom) do
        if v:isInRoom(player.platformUserId) then
            return v
        end
    end
end)

PackageHandlers:Receive("UPDATE_TIME_GAME_RUN",function (player,packet)
    for k,v in pairs(Global.listRoom) do
        if v:isInRoom(player.platformUserId) then
            return v.timeGameRun
        end
    end
end)
Lib.subscribeEvent("resetRoom",function (p)
    Global.listRoom[p.keyId]:roomListenning()
end)


