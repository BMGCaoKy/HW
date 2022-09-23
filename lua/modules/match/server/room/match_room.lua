local MatchRoom = class("MatchRoom")
function MatchRoom:ctor() --contructor
end

function MatchRoom:create()
  local base=MatchRoom.new()
  return base
end
function MatchRoom:init(uid)
  self.uid = uid                        --id phòng                          type: number
  self.userList = {}                     --danh sách người chơi              type: table playerId
  self.userDeath={}                     --danh sách người chơi bị loại      type: table playerId
  self.userMurder={}                    --danh sách người chơi là murder    type: table playerId
  self.userPolice={}                    --danh sách người chơi là police    type: table playerId
  self.userStatus={}                    --trạng thái người chơi             type: table {offline=true}
  self.roomStatus=0                     --trạng thái phòng (0: đã khởi tạo)(2: đang chờ)(3: đang chơi)
end

--get
function MatchRoom:getUid()
  return self.uid
end
function MatchRoom:getUserList()
  return self:getOnlineUserList()
end
function MatchRoom:getUserDeath()
    return self.userDeath
end
function MatchRoom:getUserPolice()
    return self.userPolice
end
function MatchRoom:getUserMurder()
    return self.userMurder
end
function MatchRoom:getAllUserList()
    return self.userList
end
function MatchRoom:getOnlineUserList()
  local userList = {}
  for i, userId in ipairs(self.userList) do
    if not self.userStatus[userId] or not self.userStatus[userId].offline then
      table.insert(userList, userId)
    end
  end
  return userList
end
function MatchRoom:getRoomStatus()
    return self.roomStatus
end

--set
function MatchRoom:setRoomStatus(codeStatus)
  self.roomStatus=codeStatus
end
function MatchRoom:setMurder(userIdList)
  self.userMurder=userIdList  
end
function MatchRoom:setPolice(userIdList)
    self.userPolice=userIdList
end

--function
function MatchRoom:addPlayer(playerId)
  table.insert( self.userList,playerId)
end
function MatchRoom:removePlayer(playerId)
  for k,v in pairs(self.userList) do
    if v==playerId then
      table.remove(self.userList,k)
    end
  end
end
function MatchRoom:isInRoom(userId)
  for i, roomUserId in ipairs(self.userList) do
    if roomUserId == userId then
      return true
    end
  end
  return false
end

return MatchRoom
