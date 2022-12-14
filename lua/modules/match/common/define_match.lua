local match_event_function=require "modules.match.server.match_event_function"
Define.MATCH={}
Define.MATCH.MIN_PLAYER=3
Define.MATCH.MIN_MURDER=1
Define.MATCH.MIN_POLICE=1
Define.MATCH.TIME_WAITING_TO_START=10
Define.MATCH.TIME_GAME_RUN=300
Define.MATCH.EVENT={
    ["ENTITY_ENTER"]={
        cfg="PLAYER",
        func=match_event_function["ENTITY_ENTER"],
    },
    ["ENTITY_LEAVE"]={
        cfg="PLAYER",
        func=match_event_function["ENTITY_LEAVE"],
    },
    ["ENTITY_DIE"]={
        cfg="PLAYER",
        func=match_event_function["ENTITY_DIE"],
    },
}

Define.MATCH.MAP={

    [1]={
        mapId="Halloween_Village_ID",
    }
}

Define.MATCH.LOBBY="map001"
