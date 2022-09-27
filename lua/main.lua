if World.IsClient then
require "script_client.main"
else
require "script_server.main"
end
require "script_common.main"
---------------------------------
require "modules.base.common.define_base"
require "modules.base.common.global_base"
---------------------------------
-------required các modules------
require "modules.debugSystem.debugSystem"
require "modules.match.match"
require "modules.player.player"







-----end-----------------------
require "modules.base.main"
