print("startup ui")

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
            if time >= 3 then
                UI:closeWindow(self)
                return false
            end
            return true
        end
    )
end
