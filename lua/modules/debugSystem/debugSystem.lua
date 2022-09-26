if World.isClient then
    require "modules.debugSystem.client.system_in_client"
else
    require "modules.debugSystem.server.overwrive_lib"
end