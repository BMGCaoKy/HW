local MatchRoom = class("MatchRoom")
function MatchRoom:ctor() --contructor
end

function MatchRoom:create()
  local base = MatchRoom.new()
  return base
end
function MatchRoom:init(uid)
  self.uid = uid --id phòng                          type: number
  self.userList = {} --danh sách người chơi              type: table playerId
  self.userDeath = {} --danh sách người chơi bị loại      type: table playerId
  self.userMurder = {} --danh sách người chơi là murder    type: table playerId
  self.userPolice = {} --danh sách người chơi là police    type: table playerId
  self.userStatus = {} --trạng thái người chơi             type: table {offline=true}
  self.roomStatus = 0 --trạng thái phòng (0: đã khởi tạo)(1: du nguoi choi)(2: phân vai xong)(3: đang chơi)
  self.timeWaitingToStart=Define.MATCH.TIME_WAITING_TO_START
  self.map={}
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
  self.roomStatus = codeStatus
end
function MatchRoom:setMurder(userId)
  --self.userMurder = userIdList
  table.insert(self.userMurder,userId)
end
function MatchRoom:setPolice(userId)
  --self.userPolice = userIdList
  table.insert(self.userPolice,userId)
end
---local function ---------------------------------
local function getRandomItem(items)
  local p = math.random()
  local cumulativeProbability = 0
  for name, item in pairs(items) do
    cumulativeProbability = cumulativeProbability + item.probability
    if p <= cumulativeProbability then
      return name, item.uid
    end
  end
end
function MatchRoom:setRoles()
  local item = {}
  for k, v in pairs(self.userList) do
    local player = Game.GetPlayerByUserId(v)
    local playerBase = player:getValue("temporary")
    table.insert(item,{
      probability = playerBase.changeRoles + 5,
      uid=v
    })
  end
  while Lib.getTableSize(self.userMurder)<Define.MATCH.MIN_MURDER do
    local key,idUser=getRandomItem(item)
    self:setMurder(idUser)
    table.remove(item,key)
  end
  while Lib.getTableSize(self.userPolice)<Define.MATCH.MIN_POLICE do
    local key,idUser,probability=getRandomItem(item)
    self:setPolice(idUser)
    table.remove(item,key)
  end
  self.roomStatus = 2
end
--function
function MatchRoom:addPlayer(playerId)
  table.insert(self.userList, playerId)
  self.timeWaitingToStart=Define.MATCH.TIME_WAITING_TO_START
end
function MatchRoom:removePlayer(playerId)
  for k, v in pairs(self.userList) do
    if v == playerId then
      table.remove(self.userList, k)
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
function MatchRoom:isMurder(userId)
  for i, roomUserId in ipairs(self.userMurder) do
    if roomUserId == userId then
      return true
    end
  end
  return false
end
function MatchRoom:isPolice(userId)
  for i, roomUserId in ipairs(self.userPolice) do
    if roomUserId == userId then
      return true
    end
  end
  return false
end
function MatchRoom:roomListenning()
  local time=0
  local isGameStart = false
  World.Timer(
    1,
    function()
      time=time+1
      --if not (isGameStart) then
        isGameStart = (Define.MATCH.MIN_PLAYER <= Lib.getTableSize(self.userList))and(self.timeWaitingToStart==0)
        --Lib.logs("waiting")
      --end
      if Define.MATCH.MIN_PLAYER > Lib.getTableSize(self.userList) then
        self.roomStatus = 0
      end
      if Define.MATCH.MIN_PLAYER <= Lib.getTableSize(self.userList) then
        self.roomStatus = 1
        if time%20==0 then
          self.timeWaitingToStart=self.timeWaitingToStart-1
          print("waiting: "..self.timeWaitingToStart)
        end
      end
      if isGameStart then
        self.roomStatus = 2
        --phan vai
        self:setRoles()
        Lib.pv(self.userMurder)
        Lib.pv(self.userPolice)
        for k,v in pairs(self.userList) do
          local player=Game.GetPlayerByUserId(v)
          Global.ui("ui/role",player,player:getValue("temporary"))
        end
        World.Timer(40,
      function ()
        self:startGame()
      end)
        
      end
      return not (isGameStart)
    end
  )
end
function MatchRoom:startGame()
  local start=true
  for k,v in pairs(self.userList) do
    local player=Game.GetPlayerByUserId(v)
    if self:isMurder(v) then
      Global.ui("ui/MainPlay",player,{role="Murder"})
    elseif self:isPolice(v) then
      Global.ui("ui/MainPlay",player,{role="Sheriff"})
    else
      Global.ui("ui/MainPlay",player,{role="Innocent"})
    end
  end
  World.Timer(1,function ()
    return start
  end)
end
return MatchRoom
