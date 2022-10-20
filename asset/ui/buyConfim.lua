print("startup ui")
function self:onOpen(packet)
    self.win.No.onMouseClick=function ()
        UI:closeWindow(self)
    end
    self.win.Yes.onMouseClick=function ()
        Lib.pv(packet)
        PackageHandlers:SendToServer("BUY_WEAPON",packet,function (stt)
            self.stt_win.Visible=true
            if stt==0 then
                self.stt_win.label.Text=Lang:toText("ui.muathanhcong")
            else
                self.stt_win.label.Text=Lang:toText("ui.muathatbai")
            end
            World.Timer(40,function ()
                UI:closeWindow(self)
                UI:closeWindow("ui/shop")
                UI:openWindow("ui/shop")
            end)
        end)
    end
end
