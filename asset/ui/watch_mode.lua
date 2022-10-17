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
        if self.Visible then
         
        else
          
        end
        if viewBy==nil then
            return true
        else
          local index=1
           World.Timer(2,function()
               local key=index
               if index<10 then
                key="0"..index
              end
               local imageName="00"..key..".jpg"
               self.Image.Image = "asset/ui/img/"..imageName
               index=index+1
               if index>80 then
                 index=1
              end
              return true
          end)
          return false
        end
        
    end)
    
end
self.head.CloseBtn.onMouseClick=function ()
    self.Visible=false
    TdAudioEngine.Instance():stopSound(Global.soundID)
end
