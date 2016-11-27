module ml_engine.manager.roommanager;
import ml_engine.room.room;
import ml_engine.core.camera;
import derelict.sdl2.sdl;
import std.stdio;
import std.conv;
class RoomManager{

    static RoomManager getInstance(){
        if(!instantiated_){
            synchronized (RoomManager.classinfo){
                if(!instance_){
                    instance_ = new RoomManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void addRoom(string name,string path,string spriteAtlas){
        room_list[name] = new Room(name, path,spriteAtlas);
        if(!currentRoom){
            currentRoom = room_list[name];
        }
    }

    int getRoomWidth(){
        return currentRoom.getRoomWidth();
    }
    
    int getRoomHeight(){
        return currentRoom.getRoomHeight();
    }

    void changeRoom(string name){
        currentRoom = room_list[name];
    }

    void processPlayer(string name,ref int x,ref int y){
        return; 
    }

    auto pointInWarpObject(int x, int y){
        return currentRoom.pointInWarpObject(x, y);
    }

    void renderRoom(SDL_Renderer *renderTarget){
        if(currentRoom){
            currentRoom.render(renderTarget);
        }
    }

    void setRoomFunction(string name, void function(string name, ref int x, ref int y) value){
        room_list[name].setRoomFunction(value);
    }

    private:
    __gshared RoomManager instance_;
    static bool instantiated_;
    Room[string] room_list;
    Room currentRoom;
}