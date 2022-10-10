print("startup ui")
print("startup ui")
--packet.room
local char = self.win_result.character
local function MurderWin(win, lose)
    char.Murder.cell.win.Visible = true
    char.Murder.cell.win.name.Text = win
    char.Sheriff.cell.lose.Visible = true
    char.Sheriff.cell.lose.name.Text = lose
end
local function PoliceWin(win, lose)
    char.Murder.cell.lose.Visible = true
    char.Sheriff.cell.win.Visible = true
    char.Murder.cell.lose.name.Text = lose
    char.Sheriff.cell.win.name.Text = win
end
function self:onOpen(packet)
    local room = packet.room

    if Lib.getTableSize(room.userMurder) == 0 then
        PoliceWin(room.lastNamePolice, room.lastNameMurder)
    else
        MurderWin(room.lastNameMurder, room.lastNamePolice)
    end
end

local time = 100
World.Timer(
    10,
    function()
        self.closeBtn.Text = "Close after " .. tostring(math.ceil(time / 20)-1) .. " seconds"
        self.closeBtn.Visible = not (self.closeBtn.Visible)
        time = time - 10
        if time <= 0 then
            UI:closeWindow("ui/result")
            return false
        end
        return true
    end
)
