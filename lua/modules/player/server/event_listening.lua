PackageHandlers:Receive("GET_temporary",function (player,packet)
    local data=player:getValue("temporary")
    return data
end)