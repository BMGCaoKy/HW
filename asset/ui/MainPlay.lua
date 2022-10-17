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
    self.role.Text=packet.role
    self.role.Text=packet.role
        if packet.role=="Murder" then
            self.help_win.frame.murder.Visible=true
            self.help_win.frame.police.Visible=false
            self.help_win.frame.human.Visible=false
            self.help_win.label.Text=Lang:toText("MainPlay.role.murder")
        elseif packet.role=="Sheriff" then
            self.help_win.frame.police.Visible=true
            self.help_win.frame.murder.Visible=false
            self.help_win.frame.human.Visible=false
            self.help_win.label.Text=Lang:toText("MainPlay.role.police")
        else
            self.help_win.frame.human.Visible=true
            self.help_win.frame.murder.Visible=false
            self.help_win.frame.police.Visible=false
            self.help_win.label.Text=Lang:toText("MainPlay.role.human")
        end
end
PackageHandlers:Receive("UPDATE_ROOM",function (player,packet)
    if packet.role then
        self.role.Text=packet.role
        if packet.role=="Murder" then
            self.help_win.frame.murder.Visible=true
            self.help_win.frame.police.Visible=false
            self.help_win.frame.human.Visible=false
            self.help_win.label.Text=Lang:toText("MainPlay.role.murder")
        elseif packet.role=="Sheriff" then
            self.help_win.frame.police.Visible=true
            self.help_win.frame.murder.Visible=false
            self.help_win.frame.human.Visible=false
            self.help_win.label.Text=Lang:toText("MainPlay.role.police")
        else
            self.help_win.frame.human.Visible=true
            self.help_win.frame.murder.Visible=false
            self.help_win.frame.police.Visible=false
            self.help_win.label.Text=Lang:toText("MainPlay.role.human")
        end
    end
   
end)
self.role.Help.onMouseClick=function ()
    self.help_win.Visible=not(self.help_win.Visible)
end
self.help_win.CloseBtn1.onMouseClick=function ()
    self.help_win.Visible=not(self.help_win.Visible)
end
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

World.Timer(1,function ()
 
        PackageHandlers:SendToServer("GET_temporary",{},function (p)
            local candy=p.candyInRoom
            self.candy_layout.count.Text=candy
        end)

    if UI:isOpenWindow("ui/MainPlay")==nil then
        return false
    end
    return true
end)