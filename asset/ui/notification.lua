print("startup ui")
function self:onOpen(packet)
    self.bg.label.Text=packet.name..""..Lang:toText(packet.lang)
    World.Timer(10,function ()
        self.bg.Visible=not(self.bg.Visible)
        if UI:isOpenWindow("ui/notification")==nil then
            return false
        end
        return true
    end)
    World.Timer(60,function ()
        UI:closeWindow("ui/notification")
    end)
end