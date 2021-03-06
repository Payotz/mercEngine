module ml_engine.core.manager.tilemapmanager;

import ml_engine.core.manager.texturemanager;
import ml_engine.manager.playermanager;
import ml_engine.core.camera;

import dtiled.algorithm;
import dtiled.coords;
import dtiled.data;
import dtiled.grid;
import dtiled.map;

import std.range;
import std.conv;
import std.array;
import std.algorithm;
import std.stdio;
import std.typecons;

import derelict.sdl2.sdl;
import std.stdio;

struct TileMap {
    OrthoMap!Tile Map;
    MapData data;
}

struct Tile {
  //Color4f tint; /// color to shade tile with when drawing

    string terrainName; /// name of terrain from map data
    string featureName; /// name of feature (tree/wall/ect.) from map data. null if no feature.
    string sideFeatureName;
    SDL_Rect terrainRect; /// section of sprite atlas used to draw tile
    SDL_Rect featureRect; /// section of sprite atlas used to draw tile
    SDL_Rect sideFeatureRect;
    bool isObstruction; /// a custom property set in Tiled

    //@property bool hasFeature() { return featureRect.w > 0; }

  this(TiledGid terrainGid, TiledGid featureGid,TiledGid sideFeatureGid, TilesetData tileset) {
    Tile tile;
    //tint = Color4f(1f,1f,1f,1f);

    if (terrainGid) {
      terrainName = tileset.tileProperties(terrainGid).get("name", null);

      terrainRect.x = tileset.tileOffsetX(terrainGid);
      terrainRect.y = tileset.tileOffsetY(terrainGid);
      terrainRect.w = tileset.tileWidth;
      terrainRect.h = tileset.tileHeight;

      //isObstruction = tileset.tileProperties(terrainGid).get("obstruction", "false").to!bool;
    }

    if (featureGid) {
      featureName = tileset.tileProperties(featureGid).get("name", null);

      featureRect.x = tileset.tileOffsetX(featureGid);
      featureRect.y = tileset.tileOffsetY(featureGid);
      featureRect.w = tileset.tileWidth;
      featureRect.h = tileset.tileHeight;
    }

    if (sideFeatureGid){
        sideFeatureName = tileset.tileProperties(sideFeatureGid).get("name",null);

        sideFeatureRect.x = tileset.tileOffsetX(sideFeatureGid);
        sideFeatureRect.y = tileset.tileOffsetY(sideFeatureGid);
        sideFeatureRect.w = tileset.tileWidth;
        sideFeatureRect.h = tileset.tileHeight;
    }
  }
}

class TileMapManager{

    static TileMapManager getInstance(){
        if(!instantiated_){
            synchronized (TileMapManager.classinfo){
                if(!instance_){
                    instance_ = new TileMapManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void init(SDL_Renderer* renderer){
        renderTarget = renderer;
    }

    void loadMap(string map_Name, string dataPath) {
        writeln("Loading Map :", map_Name);
        auto data = MapData.load(directory ~ dataPath);
        // the layers determine which tiles go where
        auto groundLayer = data.getLayer("ground");
        auto featureLayer = data.getLayer("main_feature");
        auto sideFeatureLayer = data.getLayer("side_feature");
        
        // the tileset contains data about the tiles
        auto tileset = data.getTileset("art");

        auto tiles = groundLayer.data
        .zip(featureLayer.data,sideFeatureLayer.data)          // pair together terrain and feature gids
        .chunks(data.numCols)            // group together rows
        .map!(chunk => chunk
            .map!(gids => Tile(gids[0], gids[1],gids[2], tileset)) // generate a tile from each GID pair
            .array)
        .array;                          // create an array of all the rows
        
        map_list[map_Name] = TileMap(OrthoMap!Tile(tiles, data.tileWidth, data.tileHeight), MapData.load(directory ~ dataPath));
    }

    int getMapHeight(string roomName){
        auto data = map_list[roomName].data;
        return (data.tileHeight * data.numRows) - data.tileHeight;
    }

    int getMapWidth(string roomName){
        auto data = map_list[roomName].data;
        return (data.tileWidth * data.numCols) - data.tileWidth;
    }

    Tuple!(bool,string[string]) pointInWarpObject(int x,int y,string mapName){
        warpObjects = map_list[mapName].data.getLayer("object").objects;
        SDL_Rect dummyRect;
        SDL_Point point;
        foreach(object; warpObjects){
            point.x = x;
            point.y = y;
            dummyRect.x = object.x;
            dummyRect.y = object.y;
            dummyRect.w = object.width;
            dummyRect.h = object.height;

            if(SDL_PointInRect(&point,&dummyRect)){
                return tuple(true,object.properties);
            }
        }
        string[string] dummy;
        return tuple(false,dummy);
    }

    void drawMap(string name,string spriteAtlas,int camera_x,int camera_y ) {
        auto tileAtlas = TextureManager.getInstance().getSprite(spriteAtlas);
        if(name !in map_list){
            writeln("Map not found : ", name);
            return;
        }
        auto tileMap = map_list[name].Map;
        foreach(coord, tile ; tileMap) {
            // you could use tileCenter to get the offset of the tile's center instead
            auto topLeft = tileMap.tileOffset(coord).as!(SDL_Point);
            //topLeft.x += 32;
            //topLeft.y += 32;
            drawBitmap(tileAtlas,topLeft,tile.terrainRect,camera_x,camera_y);
            drawBitmap(tileAtlas,topLeft,tile.featureRect,camera_x,camera_y);
            drawBitmap(tileAtlas,topLeft,tile.sideFeatureRect,camera_x,camera_y);
        }
    }

    void drawBitmap(SDL_Texture* tileAtlas,SDL_Point pos, SDL_Rect rect,int camera_x,int camera_y){
        SDL_Rect dummy;
        dummy.x = to!int(pos.x - camera_x);
        dummy.y = to!int(pos.y - camera_y);
        dummy.w = dummy.h = 32;
        SDL_RenderCopy(renderTarget,tileAtlas,&rect,&dummy);
    }

    void setDirectory(string value){
        directory = value;
    }

    private:
        __gshared TileMapManager instance_;
        static bool instantiated_;
        ObjectData[] warpObjects;
        TileMap[string] map_list;
        string directory;
        SDL_Renderer* renderTarget;
}