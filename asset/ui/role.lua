print("startup ui")
local function AnimationUI()
    self.probability.Visible=false
    World.Timer(1,function ()
            local rot=self.win.Rotation
            local size=self.win.Size
            self.win.Rotation=rot-Lib.v3(0,0,3)
            size[1][2]=size[1][2]-20
            size[2][2]=size[2][2]-20
            self.win.Size=size
            if size[1][2]<=0 or size[2][2]<=0 then
                UI:closeWindow(self)
                return false
            end
        return true
    end)
end
function self:onOpen(packet)
    local time = 0
    self.probability.Text="+"..packet.changeRoles.."% Get a special role"
    World.Timer(
        1,
        function()
            PackageHandlers:SendToServer(
                "GET_ROOM_INFORM",
                {},
                function(p)
                    if p.uid then
                        for k, v in pairs(p.userMurder) do
                            if v == Me.platformUserId then
                                self.win.bg.role_murder.Visible = true
                                self.win.bg.role_innocent.Visible = false
                                break
                            end
                        end
                        for k, v in pairs(p.userPolice) do
                            if v == Me.platformUserId then
                                self.win.bg.role_sheriff.Visible = true
                                self.win.bg.role_innocent.Visible = false
                                break
                            end
                        end
                    end
                end
            )
            
        end
    )
    World.Timer(
        20,
        function()
            time = time + 1
            if time >= 2 then
                --UI:closeWindow(self)
                AnimationUI()
                return false
            end
            return true
        end
    )
end

