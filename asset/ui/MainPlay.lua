print("startup ui")
local time=Define.MATCH.TIME_GAME_RUN
local function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
  
    if seconds <= 0 then
      return "00:00:00";
    else
      local hours = string.format("%02.f", math.floor(seconds/3600));
      local mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      local secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      return mins..":"..secs
    end
  end
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
    self.time.Text=SecondsToClock(time)
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