print("startup ui")
local room=nil

function self:onOpen(packet)
    local seen=UI:openWindow("ui/watch_mode")
    
    seen.Visible=false
    PackageHandlers:SendToServer("GET_ROOM_INFORM",{},function (p)
        room=p
        self.Menu.ListBtn.watchMode.Button.onMouseClick=function ()
            if room.roomStatus>=3 then
                seen.Visible=true
                Global.soundID = TdAudioEngine.Instance():play2dSound("asset/ui/img/bg.mp3", true)
            end
        end
    end)
    World.Timer(1,function ()
        local ui=UI:isOpenWindow("ui/watch_mode") 
        PackageHandlers:SendToServer("GET_PLAYER_DATA",{},function (p)
            self.Menu.ListBtn.candyWin.count.Text=p.candy
        end)
        if ui then
            return true
        end
    end)
end