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
        string onEnter = to!string(lua_tostring(L,2));
        string update = to!string(lua_tostring(L,3));
        string events = to!string(lua_tostring(L,4));
        string render = to!string(lua_tostring(L,5));
        string exit = to!string(lua_tostring(L,5));
        StateManager.getInstance().addNewTownState(name,onEnter,update,events,render,exit);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int addNewMenuState(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string onEnter = to!string(lua_tostring(L,2));
        string update = to!string(lua_tostring(L,3));
        string events = to!string(lua_tostring(L,4));
        string render = to!string(lua_tostring(L,5));
        string exit = to!string(lua_tostring(L,5));
        StateManager.getInstance().addNewMenuState(name,onEnter,update,events,render,exit);
    }catch(Exception e){
    }
    return 0;
}