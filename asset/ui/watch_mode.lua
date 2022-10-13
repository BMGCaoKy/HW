print("startup ui")
local room=nil
local viewBy=nil

local function getPlayerList(room)
    local list = {}
    local isPlaying = true
    for k, v in pairs(room.userList) do
      for kk, vv in pairs(room.userDeath[1]) do
        if vv == v then
          isPlaying = false
          break
        end
      end
      for kk, vv in pairs(room.userDeath[2]) do
        if vv == v then
          isPlaying = false
          break
        end
      end
      for kk, vv in pairs(room.userDeath[3]) do
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
  World.Timer(1,function ()
    if UI:isOpenWindow("ui/watch_mode")==nil then
        return false
    end
    PackageHandlers:SendToServer("GET_ROOM_INFORM",{},function (p)
            room=p
            if viewBy==nil then
                local list=getPlayerList(room)
                viewBy=list[math.random(1,#list)]
            end
    end)
    return true
end)
function self:onOpen(packet)
    World.Timer(1,function ()
        if viewBy==nil then
            return true
        else
            print("PLYAER: ",viewBy)
            local player=Game.GetPlayerByUserId(viewBy)
            print(Global.mapNameId)
            local worldMap=World:GetMapByID(Global.mapNameId)
            print("ID Map: ",worldMap)
            local data=worldMap:getObject(player.objID)
            Blockman.Instance():setViewEntity(data)
            return false
        end
        
    end)
    
end
self.head.CloseBtn.onMouseClick=function ()
    UI:closeWindow(self)
end
