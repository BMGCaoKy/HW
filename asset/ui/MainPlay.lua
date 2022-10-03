print("startup ui")
local time=Define.MATCH.TIME_GAME_RUN
function self:onOpen(packet)
    Lib.pv(packet)
    self.role.Text=packet.role
end
PackageHandlers:Receive("UPDATE_ROOM",function (player,packet)
    if packet.role then
        self.role.Text=packet.role
    end    
end)

World.Timer(20,function ()
    time=time-1
    self.time.Text=time
    if time%10==0 then
        PackageHandlers:SendToServer("UPDATE_TIME_GAME_RUN",{},function (p)
            if tonumber(p) then
                time=p
            end
        end)
    end
    if UI:isOpenWindow("ui/MainPlay")==nil then
        return false
    end
    return true
end)