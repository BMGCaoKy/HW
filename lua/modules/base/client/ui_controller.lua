PackageHandlers:Receive("UI_CONTROLLER",function (player,packet)
    UI:openWindow(packet.ui,packet.ui,"layouts",packet.params)
end)

PackageHandlers:Receive("UI_CONTROLLER_CLOSE_LIST",function (player,packet)
    for k,v in pairs(packet.ui) do
        UI:closeWindow(v)
    end
end)