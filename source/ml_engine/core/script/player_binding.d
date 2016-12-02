module ml_engine.core.script.player_binding;
import ml_engine.manager.playermanager;
import derelict.lua.lua;
import std.conv;

extern(C) nothrow int addPlayer(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        PlayerManager.getInstance().addPlayer(name);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int changePlayerSpriteLayer(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int value = to!int(lua_tointeger(L,2));
        PlayerManager.getInstance().changeSpriteLayer(name,value);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int getPlayerPositionX(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        return PlayerManager.getInstance().getPosition(name).x;
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int getPlayerPositionY(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        return PlayerManager.getInstance().getPosition(name).y;
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int setPlayerPosition(lua_State*L){
    try{
        string name = to!string(lua_tostring(L,1));
        int x = to!int(lua_tointeger(L,2));
        int y = to!int(lua_tointeger(L,3));
        PlayerManager.getInstance().setPosition(name,x,y);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int movePlayer(lua_State *L){
    try{
        int x = to!int(lua_tointeger(L,1));
        int y = to!int(lua_tointeger(L,2));
        PlayerManager.getInstance().move(x,y);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int stopPlayer(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        PlayerManager.getInstance().stopMove(name);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int setSprite(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string value = to!string(lua_tostring(L,2));
        PlayerManager.getInstance().setSprite(name,value);
    }catch(Exception e){
    }
    return 0;
}