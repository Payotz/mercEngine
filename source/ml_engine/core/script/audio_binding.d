module ml_engine.core.script.audio_binding;

import ml_engine.core.manager.audiomanager;
import derelict.lua.lua;
import std.conv;
import std.stdio;

extern(C) nothrow int loadSound(lua_State *L){
    try{
        string path = to!string(lua_tostring(L,1));
        string name = to!string(lua_tostring(L,2));
        AudioManager.getInstance().loadSound(path,name);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int playSound(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        AudioManager.getInstance().playSound(name);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int loadMusic(lua_State *L){
    try{
        string path = to!string(lua_tostring(L,1));
        string name = to!string(lua_tostring(L,2));
        AudioManager.getInstance().loadMusic(path,name);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int stopMusic(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        AudioManager.getInstance().stopMusic(name);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int cleanMusic(lua_State *L){
    try{
        AudioManager.getInstance().cleanMusic();
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int cleanSound(lua_State *L){
    try{
        AudioManager.getInstance().cleanSound();
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int playMusic(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        AudioManager.getInstance().playMusic(name);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int Audio_setDirectory(lua_State *L){
    try{
        string value = to!string(lua_tostring(L,1));
        writeln("Audio loading complete!");
        writeln(value);
        AudioManager.getInstance().setDirectory(value);
    }catch(Exception e){
    }
    return 0;
}