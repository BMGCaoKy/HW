local MatchRoom = class("MatchRoom")
function MatchRoom:ctor() --contructor
end

function MatchRoom:create()
  local base = MatchRoom.new()
  return base
end
function MatchRoom:init(uid, map)
  self.uid = uid --id phòng                          type: number
  self.userList = {} --danh sách người chơi              type: table playerId
  self.userDeath = {[1] = {}, [2] = {}, [3] = {}} --danh sách người chơi bị loại      type: table playerId  1: Inno, 2: Police  3: Mureder
  self.userMurder = {} --danh sách người chơi là murder    type: table playerId
  self.userPolice = {} --danh sách người chơi là police    type: table playerId
  self.userStatus = {} --trạng thái người chơi             type: table {offline=true}
  self.roomStatus = 0 --trạng thái phòng (0: đã khởi tạo)(1: du nguoi choi)(2: phân vai xong)(3: đang chơi)
  self.timeWaitingToStart = Define.MATCH.TIME_WAITING_TO_START
  self.map = {}
  self.timeGameRun = Define.MATCH.TIME_GAME_RUN
  self.lastNameMurder = ""
  self.lastNamePolice = ""
  self.mapLobby = map
  self.waitingUser = {}
end
function MatchRoom:resetRoom()
  self.uid = self.uid --id phòng                          type: number
  self.userList = self.userList --danh sách người chơi              type: table playerId
  self.userDeath = {[1] = {}, [2] = {}, [3] = {}} --danh sách người chơi bị loại      type: table playerId  1: Inno, 2: Police  3: Mureder
  self.userMurder = {} --danh sách người chơi là murder    type: table playerId
  self.userPolice = {} --danh sách người chơi là police    type: table playerId
  self.userStatus = {} --trạng thái người chơi             type: table {offline=true}
  self.roomStatus = 0 --trạng thái phòng (0: đã khởi tạo)(1: du nguoi choi)(2: phân vai xong)(3: đang chơi)
  self.timeWaitingToStart = Define.MATCH.TIME_WAITING_TO_START
  self.map = {}
  self.timeGameRun = Define.MATCH.TIME_GAME_RUN
  self.lastNameMurder = ""
  self.lastNamePolice = ""
  self.mapLobby = self.mapLobby
  for k, v in pairs(self.waitingUser) do
    table.insert(self.userList, v)
  end
  self.waitingUser = {}
  Lib.emitEvent("resetRoom", {keyId = self.uid})
  Global.closeListUI({"ui/MainPlay"}, self.userList)
  Global.ui2List("ui/popup", self.userList, {})
  print("reset Data", Lib.pv(self))
end
--get
function MatchRoom:addWaiting(userId)
  table.insert(self.waitingUser, userId)
end
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
  local player = Game.GetPlayerByUserId(userId)
  self.lastNameMurder = player.name
  table.insert(self.userMurder, userId)

  local baseInform = player:getValue("baseInform")
  if baseInform then
    local itemId = "myplugin/knife_01"
    -- if Lib.getTableSize(baseInform.item.weapon.knife)>=0 then
    -- end
    player:addItem(itemId, 1, nil, "enter")
  end
end
function MatchRoom:setPolice(userId)
  --self.userPolice = userIdList
  local player = Game.GetPlayerByUserId(userId)
  self.lastNamePolice = player.name
  table.insert(self.userPolice, userId)

  local baseInform = player:getValue("baseInform")
  if baseInform then
    local itemId = "myplugin/gun_01"
    
    -- if Lib.getTableSize(baseInform.item.weapon.knife)>=0 then
    -- end
    player:addItem(itemId, 1, nil, "enter")
  end
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
    table.insert(
      item,
      {
        probability = playerBase.changeRoles + 5,
        uid = v
      }
    )
  end
  while Lib.getTableSize(self.userMurder) < Define.MATCH.MIN_MURDER do
    local key, idUser = getRandomItem(item)
    self:setMurder(idUser)
    table.remove(item, key)
  end
  while Lib.getTableSize(self.userPolice) < Define.MATCH.MIN_POLICE do
    local key, idUser, probability = getRandomItem(item)
    self:setPolice(idUser)
    table.remove(item, key)
  end
  self.roomStatus = 2
end

function MatchRoom:getPlayerList()
  local list = {}
  local isPlaying = true
  for k, v in pairs(self.userList) do
    for kk, vv in pairs(self.userDeath[1]) do
      if vv == v then
        isPlaying = false
        break
      end
    end
    for kk, vv in pairs(self.userDeath[2]) do
      if vv == v then
        isPlaying = false
        break
      end
    end
    for kk, vv in pairs(self.userDeath[3]) do
      if vv == v then
        isPlaying = false
        break
      end
    end
    if isPlaying then
      table.insert(list, v)
    end
  end
  return list
end
function MatchRoom:randomPolice()
  local item = {}
  local list = self:getPlayerList()
  for k, v in pairs(list) do
    if not (self:isMurder(v)) and not (self:isPolice(v)) then
      local player = Game.GetPlayerByUserId(v)
      local playerBase = player:getValue("temporary")
      table.insert(
        item,
        {
          probability = playerBase.changeRoles + 5,
          uid = v
        }
      )
    end
  end
  if Lib.getTableSize(item) > 0 then
    local key, idUser, probability = getRandomItem(item)

    local player = Game.GetPlayerByUserId(idUser)
    Global.ui("ui/notification_head", player)
    World.Timer(
      60,
      function()
        local packet = player:getValue("temporary")
        self:setPolice(idUser)
        Global.ui("ui/role", player, packet)

        PackageHandlers:SendToClient(player, "UPDATE_ROOM", {role = "Sheriff"})
      end
    )
  end
end
--function
function MatchRoom:kill(userId, isChange)
  if self:isMurder(userId) then
    self:removeMurder(userId)
    table.insert(self.userDeath[3], userId)
  elseif self:isPolice(userId) then
    self:removePolice(userId, isChange)
    table.insert(self.userDeath[2], userId)
  else
    table.insert(self.userDeath[1], userId)
  end
end
function MatchRoom:addPlayer(playerId)
  table.insert(self.userList, playerId)
  self.timeWaitingToStart = Define.MATCH.TIME_WAITING_TO_START
end
function MatchRoom:removeMurder(playerId)
  for k, v in pairs(self.userMurder) do
    if v == playerId then
      table.remove(self.userMurder, k)
      local player = Game.GetPlayerByUserId(playerId)
      self.lastNameMurder = player.name
    end
  end
end
function MatchRoom:removePolice(playerId, isChange)
  for k, v in pairs(self.userPolice) do
    if v == playerId then
      table.remove(self.userPolice, k)
      local player = Game.GetPlayerByUserId(playerId)
      self.lastNamePolice = player.name
      if isChange then
        if Lib.getTableSize(self.userList) > Lib.getTableSize(self.userMurder) + Lib.getTableSize(self.userPolice) then
          World.Timer(
            30,
            function()
              self:randomPolice()
            end
          )
        end
      end
    end
  end
end
function MatchRoom:removePlayer(playerId)
  for k, v in pairs(self.userList) do
    if v == playerId then
      table.remove(self.userList, k)
      if self.roomStatus >= 2 then
        if self:isMurder(playerId) then
          self:removeMurder(playerId)
        elseif self:isPolice(playerId) then
         
          if Lib.getTableSize(self:getPlayerList())>Lib.getTableSize(self.userMurder) then
            self:removePolice(playerId,true)
          else
            self:removePolice(playerId)
          end
        end
      end
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
  local time = 0
  local isGameStart = false
  World.Timer(
    1,
    function()
      time = time + 1
      --if not (isGameStart) then
      isGameStart = (Define.MATCH.MIN_PLAYER <= Lib.getTableSize(self.userList)) and (self.timeWaitingToStart == 0)
      --Lib.logs("waiting")
      --end
      if Define.MATCH.MIN_PLAYER > Lib.getTableSize(self.userList) then
        self.roomStatus = 0
      end
      if Define.MATCH.MIN_PLAYER <= Lib.getTableSize(self.userList) then
        self.roomStatus = 1
        if time % 20 == 0 then
          self.timeWaitingToStart = self.timeWaitingToStart - 1
          print("waiting: " .. self.timeWaitingToStart)
        end
      end
      if isGameStart then
        self.roomStatus = 2
        for k, v in pairs(self.userList) do
          local player = Game.GetPlayerByUserId(v)
          Global.ui("ui/loading", player)
        end

        --phan vai
        World.Timer(
          20,
          function()
            self:setRoles()
            self:startGame()
          end
        )
      end
      return not (isGameStart)
    end
  )
end
function MatchRoom:EndGameCondition()
  World.Timer(
    1,
    function()
      if Lib.getTableSize(self.userMurder) == 0 then
        Global.ui2List("ui/result", self.userList, {room = self})
        self.roomStatus = -1
      elseif Lib.getTableSize(self:getPlayerList()) == Lib.getTableSize(self.userMurder) then
        Global.ui2List("ui/result", self.userList, {room = self})
        self.roomStatus = -1
      end
      if self.roomStatus == -1 then
        -- self:resetRoom()
        for k, v in pairs(self.userList) do
          local player = Game.GetPlayerByUserId(v)
          Lib.emitEvent("resetTray")
          player:setMapPos(self.mapLobby, Define.MATCH.MAP_POS[Define.MATCH.LOBBY])
        end
      end
      if self.roomStatus == -1 then
        World.Timer(
          70,
          function()
            self:resetRoom()
          end
        )

        return false
      end
      return true
    end
  )
end
function MatchRoom:startGame()
  local start = (self.roomStatus >= 2)

  self.roomStatus = 3
  local get_map = math.random(1, #Define.MATCH.MAP)
  local map_name = Define.MATCH.MAP[get_map].mapId
  local map = World:CreateDynamicMap(map_name, true)

  for k, v in pairs(self.userList) do
    local player = Game.GetPlayerByUserId(v)
    local pos = Define.MATCH.MAP_POS[map_name][math.random(1, #Define.MATCH.MAP_POS[map_name])]
    player:setMapPos(map, pos)
    local packet = player:getValue("temporary")
    Global.ui("ui/role", player, packet)
  end
  World.Timer(
    40,
    function()
      for k, v in pairs(self.userList) do
        local player = Game.GetPlayerByUserId(v)
        if self:isMurder(v) then
          Global.ui("ui/MainPlay", player, {role = "Murder"})
        elseif self:isPolice(v) then
          Global.ui("ui/MainPlay", player, {role = "Sheriff"})
        else
          Global.ui("ui/MainPlay", player, {role = "Innocent"})
        end
      end
    end
  )
  World.Timer(
    20,
    function()
      self.timeGameRun = self.timeGameRun - 1
      return start
    end
  )
  self:EndGameCondition()
end
return MatchRoom
