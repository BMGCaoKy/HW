local player_event_function=require "modules.player.server.player"
Define.PLAYER={}
Define.PLAYER.EVENT={
    ["ENTITY_ENTER"]={
        cfg="PLAYER",
        func=player_event_function["ENTITY_ENTER"],
    }
}
