require "modules.match.common.define_match"
require "modules.match.common.global_match"
if World.isClient then

else
    for event_name,v in pairs (Define.MATCH.EVENT) do
        Trigger.addHandler(Define.MATCH.CFG.PLAYER,event_name,v)
    end
end