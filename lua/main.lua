if World.IsClient then
require "script_client.main"
else
require "script_server.main"
end
require "script_common.main"
--
require "modules.base.common.define_base"
require "modules.base.common.global_base"


require "modules.debugSystem.debugSystem"
print("--1--")
require "modules.match.match"
print("--2--")
require "modules.player.player"

print("--3--")
require "modules.connection.connection"


