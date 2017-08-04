module ml_engine.core.script.texture_binding;
import ml_engine.core.manager.texturemanager;
import derelict.lua.lua;
import derelict.sdl2.sdl;
import std.conv;
import std.stdio;

extern(C) nothrow int addSprite(lua_State *L){
    try{
        string path = to!string(lua_tostring(L,1));
        string name = to!string(lua_tostring(L,2));
        TextureManager.getInstance().addSprite(path,name);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int addSpriteSheet(lua_State *L){
    try{
        string path = to!string(lua_tostring(L,1));
        string name = to!string(lua_tostring(L,2));
        TextureManager.getInstance().addSpriteSheet(path,name);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int setSpriteAlpha(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        ubyte alpha = to!ubyte(lua_tonumber(L,2));
        //TextureManager.getInstance().setSpriteAlpha(name,alpha);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int addFont(lua_State *L){
    try{
        string path = to!string(lua_tostring(L,1));
        string name = to!string(lua_tostring(L,2));
        int size = to!int(lua_tointeger(L,3));
        TextureManager.getInstance().addFont(path,name,size);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int Texture_checkSpriteInList(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int data = TextureManager.getInstance().checkSpriteInList(name);
        lua_pushnumber(L,data);
    }catch(Exception e){
    }
    return 1;
}

extern(C) nothrow int getSprite(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        //auto data = TextureManager.getInstance().getSprite(name);
        //lua_pushlightuserdata(L,data);
    }catch(Exception e){
    }
    return 1;
}

extern(C) nothrow int renderSprite(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int posX = to!int(lua_tonumber(L,2));
        int posY = to!int(lua_tonumber(L,3));
        TextureManager.getInstance().renderSprite(name,posX,posY);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int renderSpriteSheet(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int posX = to!int(lua_tonumber(L,2));
        int posY = to!int(lua_tonumber(L,3));
        TextureManager.getInstance().renderSpriteSheet(name,posX,posY);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int renderFont(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string message = to!string(lua_tostring(L,2));
        int posX = to!int(lua_tonumber(L,3));
        int posY = to!int(lua_tonumber(L,4));
        TextureManager.getInstance().renderFont(name,message,posX,posY);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int changeSpriteLayer(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        int layerNumber = to!int(lua_tonumber(L,2));
        //TextureManager.getInstance().changeSpriteLayer(name,layerNumber);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int Texture_setSpriteAlpha(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        ubyte value = to!ubyte (lua_tonumber(L,2));
        //TextureManager.getInstance().setSpriteAlpha(name,value);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int setAnimated(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        bool value = to!bool(lua_toboolean(L,2));
        //TextureManager.getInstance().setAnimated(name,value);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int Texture_setDirectory(lua_State *L){
    try{
        string value = to!string(lua_tostring(L,1));
        TextureManager.getInstance().setDirectory(value);
    }catch(Exception e){
    }
    return 0;
}