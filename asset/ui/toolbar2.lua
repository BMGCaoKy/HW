print("startup ui")

self.SystemBtnLayout.settingBtn.onMouseClick= function()
    local settingWnd = UI:isOpenWindow("setting")
    -- TODO:打开窗口
    if settingWnd then
        settingWnd:setVisible(not settingWnd:isVisible())
    else
        settingWnd = UI:openSystemWindow("setting")
    end
    Lib.emitEvent(Event.EVENT_ONLINE_ROOM_SHOW, not settingWnd:isVisible())

    --if settingWnd then
    --    settingWnd:setVisible(not settingWnd:isVisible())
    --    Lib.emitEvent(Event.EVENT_ONLINE_ROOM_SHOW, not settingWnd:isVisible())
    --else
    --    UI:openSystemWindowAsync(function(window) Lib.emitEvent(Event.EVENT_ONLINE_ROOM_SHOW, not window:isVisible()) end,"setting")
    --end

end