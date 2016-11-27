module ml_engine.core.script.gameobject_binding;

import ml_engine.manager.gameobjectmanager;
import derelict.lua.lua;
import derelict.sdl2.sdl;
import std.conv;

extern(C) nothrow int addObject(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        GameObjectManager.getInstance().addGameObject(name);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int setObjectSprite(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string value = to!string(lua_tostring(L,2));
        GameObjectManager.getInstance().setSprite(name,value);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int setObjectDetails(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string detail_name = to!string(lua_tostring(L,2));
        string value = to!string(lua_tostring(L,3));
        GameObjectManager.getInstance().setDetails(name,detail_name,value);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int setObjectPosition(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int x = to!int(lua_tonumber(L,2));
        int y = to!int(lua_tonumber(L,3));
        auto pos = SDL_Point(x,y);
        GameObjectManager.getInstance().setPosition(name,pos);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int moveObject(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int x = to!int(lua_tonumber(L,2));
        int y = to!int(lua_tonumber(L,3));
        auto pos = SDL_Point(x,y);
        GameObjectManager.getInstance().move(name,pos);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int changeObjectSpriteLayer(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int value = to!int(lua_tonumber(L,2));
        GameObjectManager.getInstance().changeSpriteLayer(name,value);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int cleanObjectList(lua_State *L){
    try{
        GameObjectManager.getInstance().cleanList();
    }catch(Exception e){
    }
    return 0;
}