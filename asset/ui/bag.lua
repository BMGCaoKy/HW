print("startup ui asdfghkl")
function self:onOpen()
  
end
local function isEquip(equip_current,equip)
    if equip_current.itemId==equip.itemId then
      return true
    end

  return false
end
local function refreshUI()
  self.bag_win.ScrollableView.GridView:DestroyAllChildren()
  local wp=self.weapon
  PackageHandlers.sendClientHandler("GET_PLAYER_DATA",{},function(p)
      for k,v in pairs(p.item.weapon) do
        for kk,vv in pairs(v.list) do
          Lib.pv(vv)
          local new_wp=wp:Clone()
          new_wp.Visible=true
          new_wp.Type.Text=k
          new_wp.bg.icon.Image=vv.img
          new_wp.isEquip.Visible=isEquip(vv,v.equip)
          self.bag_win.ScrollableView.GridView:AddChild(new_wp)
          new_wp.Button.onMouseClick=function ()
            print("click")
            PackageHandlers:SendToServer("EQUIP_WEAPON",{itemId=vv.itemId,type=k},function ()
              refreshUI()
            end)
          end
        end
      end
  end)
end
World.Timer(1,function()
    local wp=self.weapon
  PackageHandlers.sendClientHandler("GET_PLAYER_DATA",{},function(p)
      for k,v in pairs(p.item.weapon) do
        for kk,vv in pairs(v.list) do
          Lib.pv(vv)
          local new_wp=wp:Clone()
          new_wp.Visible=true
          new_wp.Type.Text=k
          new_wp.bg.icon.Image=vv.img
          new_wp.isEquip.Visible=isEquip(vv,v.equip)
          self.bag_win.ScrollableView.GridView:AddChild(new_wp)
          new_wp.Button.onMouseClick=function ()
            print("click")
            PackageHandlers:SendToServer("EQUIP_WEAPON",{itemId=vv.itemId,type=k},function ()
              refreshUI()
            end)
          end
        end
      end
  end)
  if UI:isOpenWindow("ui/bag")~=nil then
    return false
  end
  return true
end)
self.bag_win.CloseBtn.onMouseClick=function ()
  UI:closeWindow("ui/bag")
end