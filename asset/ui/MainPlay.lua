print("startup ui")
function self:onOpen(packet)
    Lib.pv(packet)
    self.role.Text=packet.role
end