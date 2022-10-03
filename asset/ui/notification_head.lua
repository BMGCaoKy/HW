print("startup ui")
function self:onOpen(packet)
    World.Timer(10,function ()
        self.bg.Visible=not(self.bg.Visible)
        if UI:isOpenWindow("ui/notification_head")==nil then
            return false
        end
        return true
    end)
    World.Timer(60,function ()
        UI:closeWindow("ui/notification_head")
    end)
end