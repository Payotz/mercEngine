module ml_engine.core.script.room_binding;
import ml_engine.manager.roommanager;
import derelict.lua.lua;
import std.conv;

extern(C) nothrow int addRoom(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string path = to!string(lua_tostring(L,2));
        string spriteAtlas = to!string(lua_tostring(L,3));
        RoomManager.getInstance().addRoom(name,path,spriteAtlas);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int getCurrentRoomWidth(lua_State *L){
    try{
        return RoomManager.getInstance().getRoomWidth();
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int getCurrentRoomHeight(lua_State *L){
    try{
        return RoomManager.getInstance().getRoomHeight();
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int changeCurrentRoom(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        RoomManager.getInstance().changeRoom(name);
    }catch(Exception e){
    }
    return 0;
}