module ml_engine.core.script.map_binding;
import ml_engine.core.manager.tilemapmanager;
import derelict.sdl2.sdl;
import derelict.lua.lua;
import std.conv;
import std.stdio;
import std.string;

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

extern(C) nothrow int Map_setDirectory(lua_State *L){
    try{
        string value = to!string(lua_tostring(L,1));
        TileMapManager.getInstance().setDirectory(value);
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

extern(C) nothrow int Map_pointInWarpObject(lua_State *L){
    try{
        int x = to!int(lua_tonumber(L,1));
        int y = to!int(lua_tonumber(L,2));
        string mapName = to!string(lua_tostring(L,3));
        auto data = TileMapManager.getInstance().pointInWarpObject(x,y,mapName);
        lua_pushboolean(L,data[0]);
        lua_newtable(L);
        foreach(op;data[1].byKeyValue()){
            lua_pushstring(L,op.key.toStringz());
            lua_pushstring(L,op.value.toStringz());
        }
        lua_settable(L,-2);
    }catch(Exception e){
    }
    return 2;
}

extern(C) nothrow int Map_drawMap(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string spriteAtlas = to!string(lua_tostring(L,2));
        int camera_x = to!int(lua_tonumber(L,3));
        int camera_y = to!int(lua_tonumber(L,4));
        writeln(camera_x,camera_y);
        TileMapManager.getInstance().drawMap(name,spriteAtlas,camera_x,camera_y);
    }catch(Exception e){

    }
    return 0;
}