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


PackageHandlers:Receive("GET_PLAYER_DATA",function (player,packet)
    local data=player:getValue("baseInform")
    return data
end)


PackageHandlers:Receive("EQUIP_WEAPON",function (player,packet)
    local data=player:getValue("baseInform")
    for k,v in pairs(Global.weapon[packet.type]) do
        if v.itemId==packet.itemId then
            data.item.weapon[packet.type].equip=v
            player:setValue("baseInform",data)
            break
        end
    end
end)


PackageHandlers:Receive("BUY_WEAPON",function (player,packet)
    Lib.pv(packet)
    local data=player:getValue("baseInform")
    for k,v in pairs(Global.weapon[packet.type]) do
        Lib.pv(v)
        if v.itemId==packet.itemId then
            print("--------------find----------------")
            if data.candy>=v.price then
                data.candy=data.candy-v.price
                table.insert(data.item.weapon[packet.type].list,v)
                
                player:setValue("baseInform",data)
                return 1
            end
            break
        end
    end
    return 0
end)