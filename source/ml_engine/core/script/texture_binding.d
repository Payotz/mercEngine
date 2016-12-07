module ml_engine.core.script.texture_binding;
import ml_engine.core.manager.texturemanager;
import derelict.lua.lua;
import derelict.sdl2.sdl;
import std.conv;

protected SDL_Renderer* renderTarget;

void textureInit(SDL_Renderer* renderer){
    renderTarget = renderer;
}

extern(C) nothrow int addSprite(lua_State *L){
    try{
        string path = to!string(lua_tostring(L,1));
        string name = to!string(lua_tostring(L,2));
        TextureManager.getInstance().addSprite(path,name,renderTarget);
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

extern(C) nothrow int addSpriteSheet(lua_State *L){
    try{
        string path = to!string(lua_tostring(L,1));
        string name = to!string(lua_tostring(L,2));
        TextureManager.getInstance().addSpriteSheet(path,name,renderTarget);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int setSpriteAlpha(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        ubyte alpha = to!ubyte(lua_tonumber(L,2));
        TextureManager.getInstance().setSpriteAlpha(name,alpha);
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