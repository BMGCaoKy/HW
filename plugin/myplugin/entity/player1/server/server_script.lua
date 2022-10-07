print("sandbox:hello word")
Lib.subscribeEvent(
    "resetTray",
    function(p)
        local entityTrays = this:tray()
        local trayTb =
            entityTrays:query_trays(
            function(tray)
                return true
            end
        )
        for _, _tray in pairs(trayTb) do
            --print(_tray.tid,_tray.tray:capacity())
            _tray.tray:remove_item(1) 
            _tray.tray:remove_item(2) 
        end
    end
)

-- function MatchRoom:removeWapon(playerid, id)
--     local player = Game.GetPlayerByUserId(playerid)
--     local tray = player:tray()["_trays"]
--     local itemData =
--       tray:query_items(
--       function(item)
--         if item:cfg().fullName == "myplugin/" .. id then
--           return true
--         end
--         return false
--       end
--     )
--     itemData:consume(1)
--   end
