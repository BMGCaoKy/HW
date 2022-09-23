local match_event_function=require "modules.match.server.match_event_function"
Define.MATCH={}

Define.MATCH.EVENT={
    ["ENTITY_ENTER"]=match_event_function["ENTITY_ENTER"]
}
Define.MATCH.CFG={
    PLAYER=Entity.GetCfg("myplugin/player1"),
}