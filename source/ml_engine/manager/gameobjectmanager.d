module ml_engine.manager.gameobjectmanager;

import ml_engine.object.gameobject;
import ml_engine.object.player;
import ml_engine.manager.playermanager;
import ml_engine.core.camera;
import ml_engine.core.manager.texturemanager;

import derelict.sdl2.sdl;

class GameObjectManager{

    public:
    static GameObjectManager getInstance(){
        if(!instantiated_){
            synchronized(GameObjectManager.classinfo){
                if(!instance_){
                    instance_ = new GameObjectManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void addGameObject(string name){
        gameobject_list[name] = new GameObject();
    }

    void setSprite(string name, string value){
        gameobject_list[name].setSprite(value);
    }

    void setDetails(string name, string detail_name, string value){
        gameobject_list[name].setDetails(detail_name,value);
    }

    void move(string name, SDL_Point value){
        auto dummy = gameobject_list[name].getPosition();
        dummy.x += value.x;
        dummy.y += value.y;
        gameobject_list[name].setPosition(dummy);
    }

    bool checkCollision(string name){
        auto player_pos = PlayerManager.getInstance().getPosition(name);
        foreach(gameobject; gameobject_list){
            auto dummy = gameobject.getRect();
            dummy.x -=16;
            dummy.y -=16;
            dummy.h +=10;
            if(SDL_PointInRect(&player_pos,dummy)){
                return true;
            }
        }
        return false;
    }


    void setPosition(string name, SDL_Point value){
        gameobject_list[name].setPosition(value);
    }

    void changeSpriteLayer(string name,int value){
        TextureManager.getInstance().changeSpriteLayer(gameobject_list[name].getSpriteName(),value);
    }

    void cleanList(){
        foreach(gameobject; gameobject_list){
            gameobject = null;
        }
    }

    void render(SDL_Renderer *renderTarget){
        foreach(gameobject; gameobject_list){
            if(gameobject !is null){
                gameobject.render(renderTarget);
            }
        }
    }

    private:
    static GameObjectManager instance;
    GameObject[string] gameobject_list;
    __gshared GameObjectManager instance_;
    static bool instantiated_;
    this(){
    }
}