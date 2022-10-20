print("startup ui")
local room=nil

function self:onOpen(packet)
    
    PackageHandlers:SendToServer("GET_ROOM_INFORM",{},function (p)
        room=p
        
    end)
    World.Timer(1,function ()
        PackageHandlers:SendToServer("GET_PLAYER_DATA",{},function (p)
            self.Menu.ListBtn.candyWin.count.Text=p.candy
        end)
        return true
    end)
    self.Menu.ListBtn.watchMode.Button.onMouseClick=function ()
      if UI:isOpenWindow("ui/bag") then
        UI:closeWindow("ui/bag")
      else
        UI:openWindow("ui/bag")
      end

    end

    self.Menu.ListBtn.shop.Button.onMouseClick=function ()

        UI:openWindow("ui/shop")
  

    end
end