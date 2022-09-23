local event={}
local MatchRoom=require("modules.match.server.room.match_room")
event["ENTITY_ENTER"]=function (p)
    local game_id = Server.CurServer:getGameId()
    if Global.listRoom[game_id]==nil then
        print("open",game_id)
        
        local a=MatchRoom:create()
        a:init(game_id)
        Lib.pv(a:getUid())
    end
    --Global.listRoom[game_id]:addPlayer(p.obj1.platformUserId)
    print("qwerty")
    
end
return event