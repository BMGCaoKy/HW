local event={}
local MatchRoom=require("modules.match.server.room.match_room")
event["ENTITY_ENTER"]=function (p)
    local game_id = Server.CurServer:getGameId()
    if Global.listRoom[game_id]==nil then
        Global.listRoom[game_id]=MatchRoom:create()
        Global.listRoom[game_id]:init(game_id)
    end
    Global.listRoom[game_id]:addPlayer(p.obj1.platformUserId)
    
end
return event