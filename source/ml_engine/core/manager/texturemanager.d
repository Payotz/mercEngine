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

    void init(SDL_Renderer* value){
        renderTarget = value;
    }

    void addSprite(string path,string name){
        sprite_list[name] = new Sprite(directory ~ path,this.renderTarget);
    }

    void addSpriteSheet(string path, string name){
        spriteSheet_list[name] = new SpriteSheet(directory ~ path,60,this.renderTarget);
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

    SDL_Texture* getSprite(string name){
        if(name in sprite_list){
            writeln("Sprite Found :", name);
            return sprite_list[name].getSprite();
        }
        else{ 
            writeln("Sprite not found :", name);
            return sprite_list[name].getSprite();
        }
    }

    void renderSprite(string name,int posX,int posY){
		sprite_list[name].render(posX,posY,this.renderTarget);
	}

	void renderSpriteSheet(string name,int posX, int posY){
        if((name in spriteSheet_list) !is null)
		spriteSheet_list[name].render(posX,posY,this.renderTarget);
	}

	void renderFont(string name,string message,int posX, int posY){
		font_list[name].render(message,posX,posY,this.renderTarget);
	}

    void changeSpriteLayer(string name, int layerNumber){
		spriteSheet_list[name].changeSprite(layerNumber);
	}

    void setSpriteAlpha(string name, ubyte alpha){
        SDL_SetTextureAlphaMod(spriteSheet_list[name].getSprite(),alpha);
    }

    void setAnimated(string name,bool isAnimated){
        if((name in spriteSheet_list) !is null)
		spriteSheet_list[name].setAnimated(isAnimated);
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