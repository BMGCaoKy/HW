local player_event_function=require "modules.player.server.player_event_function"
Define.PLAYER={}
Define.PLAYER.EVENT={
    ["ENTITY_ENTER"]={
        cfg="PLAYER",
        func=player_event_function["ENTITY_ENTER"],
    },
    ["ENTITY_TOUCHDOWN"]={
        cfg="PLAYER",
        func=player_event_function["ENTITY_TOUCHDOWN"],
    }
}
