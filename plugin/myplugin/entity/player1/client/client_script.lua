print('sandbox:hello word')
UI:openWindow("ui/over_shortcutBar")


PackageHandlers:Revive("RESET_BAG",function (player,packet)
    Lib.emitEvent("resetSelect")
end)