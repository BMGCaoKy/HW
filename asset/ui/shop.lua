print("startup ui asdfghkl")
function self:onOpen()
  
end
local function isHave(equip_current_id,list_equip)
    for k,v in pairs(list_equip) do
        if v.itemId==equip_current_id then
            return true
        end
    end

  return false
end

local function id2item(id,type)
  for k,v in pairs(Global.weapon[type]) do
      if v.itemId==id then
          return v
      end
  end

  return {}
end
local function refreshUI()
--
end
World.Timer(1,function()
    local wp=self.weapon
  PackageHandlers.sendClientHandler("GET_PLAYER_DATA",{},function(p)
    self.List.candy.count.Text=p.candy
      for k,v in pairs(Global.shop) do
        for kk,vv in pairs(v) do
          local data=id2item(vv,k)
          local new_wp=wp:Clone()
          new_wp.Visible=true
          new_wp.Type.Text=k
          new_wp.bg.icon.Image=data.img
          new_wp.isBuy.Visible=isHave(vv,p.item.weapon[k].list)

          new_wp.price.Visible=not(isHave(vv,p.item.weapon[k].list))
          self.List:child(k).ScrollableView.List:AddChild(new_wp)
          new_wp.price.Price.Text=data.price
          new_wp.Button.onMouseClick=function ()
            if not(isHave(vv,p.item.weapon[k].list)) then
              UI:openWindow("ui/buyConfim","ui/buyConfim","layouts",{itemId=vv,type=k})
            end
          end
        end
      end
  end)
  if UI:isOpenWindow("ui/shop")~=nil then
    return false
  end
  return true
end)
self.CloseBtn.onMouseClick=function ()
  UI:closeWindow("ui/shop")
end