Global.connection={
    
}

Global.ui=function (ui,player,packet)
    if World.isClient then

    else
        PackageHandlers:SendToClient(player,"UI_CONTROLLER",{ui=ui,params=packet})
    end
end

Global.ui2List=function (ui,playerList,packet)
    if World.isClient then

    else
        for k,v in pairs(playerList) do
            local player=Game.GetPlayerByUserId(v)
            PackageHandlers:SendToClient(player,"UI_CONTROLLER",{ui=ui,params=packet})
        end
    end
end
Global.closeListUI=function (uiList,playerList)
    if World.isClient then

    else
        for k,v in pairs(playerList) do
            local player=Game.GetPlayerByUserId(v)
            PackageHandlers:SendToClient(player,"UI_CONTROLLER_CLOSE_LIST",{ui=uiList})
        end
    end
end