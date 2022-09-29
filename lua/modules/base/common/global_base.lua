Global.connection={
    
}

Global.ui=function (ui,player,packet)
    if World.isClient then

    else
        PackageHandlers:SendToClient(player,"UI_CONTROLLER",{ui=ui,params=packet})
    end
end