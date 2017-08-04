module ml_engine.object.gameobject;

import ml_engine.core.manager.texturemanager;
import ml_engine.core.camera;
import derelict.sdl2.sdl;
import std.stdio;
import std.conv;

class GameObject{
    public:

    this(string value){
        object_name = value;
    }

    SDL_Point getPosition() {
        return position; 
    }

    SDL_Rect* getRect(){
        spriteRect.x = position.x;
        spriteRect.y = position.y;
        spriteRect.w = 32;
        spriteRect.h = 32;

        return &spriteRect;
    }

    void setDetails(string name, string detail){
        detail_list[name] = detail;
    }

    void isMoving(bool value){
        isAnimated = value;
    }
    
    void setPosition(SDL_Point value) {
        position = value;
    }

    string getDialogue(){
        return detail_list["dialogue"];
    }
    string getSpriteName(){
        return sprite_name;
    }
    string getObjectName(){
        return object_name;
    }

    void setSprite(string value){
        int results = TextureManager.getInstance().checkSpriteInList(value);
        if(results == SPRITE_TYPE.NONE){
            spriteExists = false;
        }else{
            spriteExists = true;
            if(results == SPRITE_TYPE.SPRITE){
                isSpriteSheet = false;
            }else{
                isSpriteSheet = true;
            }
        }
        sprite_name = value;
    }

    void render(SDL_Renderer *renderTarget){
        if(!spriteExists){
            return;
        }else{
            if(!isSpriteSheet){
                //TextureManager.getInstance().renderSprite(sprite_name,to!int(position.x - Camera.getInstance().getPositionX()),to!int(position.y - Camera.getInstance().getPositionY()));
            }else{
                //TextureManager.getInstance().setAnimated(sprite_name,isAnimated);
                //TextureManager.getInstance().renderSpriteSheet(sprite_name,to!int(position.x - Camera.getInstance().getPositionX()),to!int(position.y - Camera.getInstance().getPositionY()));
            }
        }
    }

    protected:
    string[string] detail_list;
    SDL_Point position;
    string sprite_name;
    string object_name;
    SDL_Rect spriteRect;
    bool isSpriteSheet = false;
    bool spriteExists = false;
    bool isAnimated = false;
}