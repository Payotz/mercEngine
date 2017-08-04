module ml_engine.core.manager.texturemanager;

import derelict.sdl2.sdl;
import ml_engine.core.graphic.font;
import ml_engine.core.graphic.sprite;
import ml_engine.core.graphic.spritesheet;

import std.stdio;

enum SPRITE_TYPE{
    NONE = 0,
    SPRITE = 1,
    SPRITE_SHEET = 2
}

class TextureManager{

    static TextureManager getInstance(){
        if(!instantiated_){
            synchronized(TextureManager.classinfo){
                if(!instance_){
                    instance_ = new TextureManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void addSprite(string path,string name){
        //sprite_list[name] = new Sprite(directory ~ path,this.renderTarget);
    }

    void addSpriteSheet(string path, string name){
        //spriteSheet_list[name] = new SpriteSheet(directory ~ path,60,this.renderTarget);
    }
    
    void addFont(string path,string name, int size) {
		font_list[name] = new Font(directory ~ path,size);
	}

    int checkSpriteInList(string name){
        if((name in sprite_list) !is null){
            return 1;
        }if((name in spriteSheet_list) !is null){
            return 2;
        }else{
            return 0;
        }
    }

    void renderSprite(string name,int posX,int posY){
		sprite_list[name].render(posX,posY);
	}

	void renderSpriteSheet(string name,int posX, int posY){
        if((name in spriteSheet_list) !is null)
		spriteSheet_list[name].render(posX,posY);
	}

	void renderFont(string name,string message,int posX, int posY){
		font_list[name].render(message,posX,posY,this.renderTarget);
	}

    void setDirectory(string value){
        directory = value;
    }
    
    private:
    this(){
    }
    Font[string] font_list;
	Sprite[string] sprite_list;
	SpriteSheet[string] spriteSheet_list;
    string directory;
    SDL_Renderer* renderTarget;

    __gshared TextureManager instance_;
    static bool instantiated_;
}