module ml_engine.core.script.camera_binding;
import ml_engine.core.camera;
import derelict.lua.lua;
import std.conv;

extern(C) nothrow int camera_setFocusOnPlayer(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        Camera.getInstance().setFocusOnPlayer(name);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int camera_setFocusOnObject(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        Camera.getInstance().setFocusOnObject(name);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int camera_setFreeRoam(lua_State *L){
    try{
        bool value = to!bool(lua_toboolean(L,1));
        Camera.getInstance().setFreeRoam(value);
    }catch(Exception e){
    }
    return 0;
}