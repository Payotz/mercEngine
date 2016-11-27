module ml_engine.core.script.state_binding;
import ml_engine.core.manager.statemanager;
import derelict.lua.lua;
import std.conv;

extern(C) nothrow int changeState(lua_State * L){
    try{
        string stateName = to!string(lua_tostring(L,1));
        StateManager.getInstance().changeState(stateName);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int addNewTownState(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string update_script = to!string(lua_tostring(L,2));
        string render_script = to!string(lua_tostring(L,3));
        StateManager.getInstance().addNewTownState(name,update_script,render_script);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int addNewMenuState(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string update_script = to!string(lua_tostring(L,2));
        string render_script = to!string(lua_tostring(L,3));
        StateManager.getInstance().addNewMenuState(name,update_script,render_script);
    }catch(Exception e){
    }
    return 0;
}