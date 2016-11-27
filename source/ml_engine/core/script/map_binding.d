module ml_engine.core.script.map_binding;
import ml_engine.core.manager.tilemapmanager;
import derelict.sdl2.sdl;
import derelict.lua.lua;
import std.conv;

protected SDL_Renderer* renderTarget;

void initMapScript(SDL_Renderer *renderer){
    renderTarget = renderer;
}

extern(C) nothrow int loadMap(lua_State *L){
    try{        
        string mapName = to!string(lua_tostring(L,1));
        string dataPath = to!string(lua_tostring(L,2));
        TileMapManager.getInstance().loadMap(mapName,dataPath);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int getMapHeight(lua_State *L){
    try{
        string mapName = to!string(lua_tostring(L,1));
        return TileMapManager.getInstance().getMapHeight(mapName);
    }catch(Exception e){
    }
    return 0;
    
}

extern(C) nothrow int getMapWidth(lua_State *L){
    try{
        string mapName = to!string(lua_tostring(L,1));
        return TileMapManager.getInstance().getMapWidth(mapName);
    }catch(Exception e){
    }
    return 0;
    
}

extern(C) nothrow int drawMap(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string spriteAtlas = to!string(lua_tostring(L,2));
        TileMapManager.getInstance().drawMap(name,spriteAtlas,renderTarget);
    }catch(Exception e){

    }
    return 0;
}