module ml_engine.core.script.network_binding;
import ml_engine.core.manager.networkmanager;
import derelict.lua.lua;
import std.conv;

extern(C) nothrow int connectTCPTo(lua_State *L){
    try{
        string address = to!string(lua_tostring(L,1));
        int port = to!int(lua_tointeger(L,2));
        NetworkManager.getInstance().connectTCPTo(address,port);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int sendTCPData(lua_State *L){
    try{
        auto data = lua_touserdata(L, 1);
        int len = to!int(lua_tointeger(L,2));
        NetworkManager.getInstance().sendTCPData(data,len);        
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int recvTCPData(lua_State *L){
    try{
        auto data = lua_touserdata(L,1);
        int len = to!int(lua_tointeger(L,2));
        NetworkManager.getInstance().recvTCPData(data,len);
        lua_pushlightuserdata(L,data);
    }catch(Exception e){
    }
    return 1;
}

