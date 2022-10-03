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