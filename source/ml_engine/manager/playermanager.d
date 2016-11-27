module ml_engine.manager.playermanager;

import ml_engine.core.manager.texturemanager;
import ml_engine.manager.roommanager;
import ml_engine.core.camera;
import ml_engine.manager.gameobjectmanager;
import ml_engine.object.player;
import ml_engine.core.camera;
import derelict.sdl2.sdl;

import std.stdio;
import std.conv;

class PlayerManager{

    static PlayerManager getInstance(){
        if(!instantiated_){
            synchronized(PlayerManager.classinfo){
                if(!instance_){
                    instance_ = new PlayerManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void addPlayer(string name){
        player_list[name] = new Player();
    }

    void changeSpriteLayer(string name,int value){
        TextureManager.getInstance().changeSpriteLayer(player_list[name].getSpriteName(),value);
    }

    SDL_Point getPosition(string name){
        return player_list[name].getPosition();
    }

    Player getPlayer(string name){
        return player_list[name];
    }

    void setPosition(string name, int x, int y){
        SDL_Point dummy;
        dummy.x = x;
        dummy.y = y;
        player_list[name].setPosition(dummy);
    }

    void move(string name, int x, int y){
        auto dummy = player_list[name].getPosition();
        auto xpos = dummy.x;
        auto ypos = dummy.y;
        xpos += x;
        ypos += y;
        dummy.x = xpos;
        dummy.y = ypos;
        player_list[name].setPosition(dummy);
        writeln(dummy.x," - ", dummy.y);
        player_list[name].isMoving(true);
    }

    void stopMove(string name){
        player_list[name].isMoving(false);
    }

    void render(SDL_Renderer *renderTarget){
        player_list["Player_1"].render(renderTarget);
        TextureManager.getInstance().renderFont("chat_text","Player_1",to!int((player_list["Player_1"].getPosition().x) - Camera.getInstance().getPositionX()) , to!int((player_list["Player_1"].getPosition().y -10) - Camera.getInstance().getPositionY()) ,renderTarget);
        /*foreach(player; player_list){
            if(player !is null){
                player.render(renderTarget);
            }
        }*/
    }

    void setSprite(string name, string value){
        player_list[name].setSprite(value);
    }

    private:
    static PlayerManager instance;
    private Player[string] player_list;
    __gshared PlayerManager instance_;
    static bool instantiated_;
    this(){
    }
}