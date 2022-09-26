local function RECEIVE_LOG_IN_SERVER(player,packet)
    print("["..packet.date_time.."][SERVER]: "..packet.logs)
end
PackageHandlers:Receive("RECEIVE_LOG_IN_SERVER",RECEIVE_LOG_IN_SERVER)