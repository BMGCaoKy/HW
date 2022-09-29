PackageHandlers:Receive("GET_ROOM_INFORM",function (player,packet)
    for k,v in pairs(Global.listRoom) do
        if v:isInRoom(player.platformUserId) then
            return v
        end
    end
end)