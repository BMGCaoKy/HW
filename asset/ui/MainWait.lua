print("startup ui")
local room=nil

function self:onOpen(packet)
    PackageHandlers:SendToServer("GET_ROOM_INFORM",{},function (p)
        room=p
        self.Menu.ListBtn.watchMode.Button.onMouseClick=function ()
            if room.roomStatus>=3 then
                UI:openWindow("ui/watch_mode")
            end
        end
    end)
    
end