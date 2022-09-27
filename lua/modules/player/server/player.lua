local PlayerBase = class("PlayerBase")
function PlayerBase:ctor() --contructor
end

function PlayerBase:create()
  local base=PlayerBase.new()
  return base
end
function PlayerBase:init()
    self.changeRoles=0
    self.statusPlayer=0
end

return PlayerBase
