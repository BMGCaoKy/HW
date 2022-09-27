require "modules.player.common.define_player"
print("Load PLAYER at",os.clock())
if World.isClient then
else
    Lib.logs("Đang tải modules player!!!")
    Lib.pv(Define.PLAYER.EVENT)
    for event_name, v in pairs(Define.PLAYER.EVENT) do
        if Global.connection[event_name] == nil then
           Global.connection[event_name] = {}
        end
        table.insert(
            Global.connection[event_name],
            {
                cfg =v.cfg,
                func = v.func,
            }
        )
    end
end
