print("startup ui")
function self:onOpen(packet)
    World.Timer(
        1,
        function()
            PackageHandlers:SendToServer(
                "GET_ROOM_INFORM",
                {},
                function(p)
                    if p.uid then
                        if p.roomStatus>=3 then
                            UI:closeWindow("ui/loading")
                        end
                    end
                end
            )
            if UI:isOpenWindow("ui/loading")==nil then
                return false
            end
            return true
        end
    )
    World.Timer(10,function ()
        if UI:isOpenWindow("ui/loading")==nil then
            return false
        end
        if self.Container then
            local current_text=self.Container.Dot.Text
            local new_text=current_text
            if #current_text==5 then
                new_text=""
            else
            new_text=new_text.."."
            end
            self.Container.Dot.Text=new_text
            
            return true
        end
    end)
end