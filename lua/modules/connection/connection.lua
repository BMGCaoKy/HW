if World.isClient then
else
    for k, v in pairs(Global.connection) do
        if Define.CONNECTION.EVENT[k] == nil then
            Define.CONNECTION.EVENT[k] = {}
        end
        for k1, v1 in pairs(v) do
            if Define.CONNECTION.EVENT[k][v1.cfg] == nil then
                Define.CONNECTION.EVENT[k][v1.cfg] = {}
            end
            table.insert(Define.CONNECTION.EVENT[k][v1.cfg], v1.func)
        end
    end
    for event_name,v in pairs (Define.CONNECTION.EVENT) do
        for k1, v1 in pairs(v) do
            local function run_function(p)
                for i,func in pairs(v1) do
                    func(p)
                end
            end
            Trigger.addHandler(Define.CONNECTION.CFG[k1],event_name,run_function)
        end
        
    end
end
