require "modules.match.common.define_match"
require "modules.match.common.global_match"
print("Load MATCH at",os.clock())
if World.isClient then
else
    Lib.logs("Đang tải modules match!!!")
    for event_name, v in pairs(Define.MATCH.EVENT) do
        if Global.connection[event_name] == nil then
            Global.connection[event_name] = {}
        end
        table.insert(
            Global.connection[event_name],
            {
                cfg =v.cfg,
                func = v.func
            }
        )
    end
end
