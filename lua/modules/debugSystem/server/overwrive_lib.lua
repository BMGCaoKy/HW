function Lib.logs(logs)
    if type(logs)=="table" then
        logs=Lib.v2s(logs)
    end
    local packet={
        logs=tostring(logs),
        date_time=os.date("%X")
    }
    print("["..packet.date_time.."][SERVER]: "..packet.logs)
    PackageHandlers:SendToAllClients("RECEIVE_LOG_IN_SERVER",packet)
end