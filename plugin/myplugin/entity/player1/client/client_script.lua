print('sandbox:hello word')
UI:openWindow("ui/over_shortcutBar")
TdAudioEngine.Instance():play2dSound("asset/bg.mp3", true)

PackageHandlers:Revive("RESET_BAG",function (player,packet)
    Lib.emitEvent("resetSelect")
end)