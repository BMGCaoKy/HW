print("startup ui")
print("startup ui")
--packet.room
local function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
  
    if seconds <= 0 then
      return "00:00";
    else
      local hours = string.format("%02.f", math.floor(seconds/3600));
      local mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      local secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      return mins..":"..secs
    end
  end
local char = self.bg
local function MurderWin(win, lose)
    
    char.murder_win.name.Text = win
    char.police_win.lose.Visible = true
    char.police_win.name.Text = lose
end
local function PoliceWin(win, lose)
    char.murder_win.name.Text = lose
    char.murder_win.lose.Visible = true
    char.police_win.name.Text = win
end
function self:onOpen(packet)
    local room = packet.room

    if Lib.getTableSize(room.userMurder) == 0 then
        PoliceWin(room.lastNamePolice, room.lastNameMurder)
    else
        MurderWin(room.lastNameMurder, room.lastNamePolice)
    end
    local data=packet.playerData
    Lib.pv(room.timeDeath)
    local max_exp=Define.PLAYER.LV_TO_EXP(data.exp.lv+1)
    
    self.bg.exp_layout.ProgressBar:AddProgress(data.exp.point/max_exp)
    local bonus=Define.MATCH.TIME_GAME_RUN
    for k,v in pairs(room.timeDeath) do
        if v.id==Me.platformUserId then
            bonus=v.time
            
            break
        end
    end
    self.bg.exp_layout.num_win.text_layout.add.Text="+"..bonus
            self.bg.survial_point_win.layout.text_layout.add.Text=SecondsToClock(bonus)
end


self.bg.Exit.onMouseClick=function ()
    UI:closeWindow(self)
end