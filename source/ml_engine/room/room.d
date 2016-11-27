module ml_engine.room.room;

import derelict.sdl2.sdl;
import ml_engine.core.manager.tilemapmanager;
import ml_engine.manager.roommanager;
import ml_engine.manager.playermanager;
import ml_engine.core.camera;
import dtiled.algorithm;
import dtiled.coords;
import dtiled.data;
import dtiled.grid;
import dtiled.map;

import std.stdio;

class Room{
    this(string room_name,string path,string spriteAtlas_){
        TileMapManager.getInstance().loadMap(room_name,path);
        this.room_name = room_name;
        roomWidth = TileMapManager.getInstance().getMapWidth(room_name);
        roomHeight = TileMapManager.getInstance().getMapHeight(room_name);
        spriteAtlas = spriteAtlas_;
    }

    int getRoomWidth(){
        return roomWidth;
    }

    string getRoomName(){
        return room_name;
    }

    void setRoomFunction(void function(string name, ref int x, ref int y) value){
        func = value;
    }

    void processPlayer(string name,ref int x,ref int y){
        return;
    }

    auto pointInWarpObject(int x, int y){
        return TileMapManager.getInstance().pointInWarpObject(x,y,room_name);
    }

    int getRoomHeight(){
        return roomHeight;
    }
    
    void render(SDL_Renderer *renderTarget){
        TileMapManager.getInstance().drawMap(room_name,spriteAtlas,renderTarget);
    }

    private:
    string name;
    string room_name;
    string spriteAtlas;
    int roomWidth;
    int roomHeight;
    void function(string name, ref int x, ref int y) func;
}