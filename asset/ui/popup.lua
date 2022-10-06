print("startup ui")

function self:onOpen(packet)
    World.Timer(1,function ()
        if UI:isOpenWindow("ui/popup")==nil then
            return false
        end
        PackageHandlers:SendToServer("GET_ROOM_INFORM",{},function (p)
            if p.roomStatus==0 then
                self.ListText.MainLabel.Text="Waiting player..."
            elseif p.roomStatus==1 then
                self.ListText.MainLabel.Text="Starts in "..tostring(p.timeWaitingToStart)
                print(p.timeWaitingToStart)
            else
                UI:closeWindow("ui/popup")
            end
        end)
        
        return true
    end)
end