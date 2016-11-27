module ml_engine.core.graphic.sprite;

import derelict.sdl2.sdl;
import derelict.sdl2.image;
import std.stdio;

class Sprite{
	private SDL_Texture* sprite_texture;
	private SDL_Rect spriteRect;
	private SDL_Rect spritePosition;
	private int textureWidth;
	private int textureHeight;

	this(string _path, SDL_Renderer* _renderTarget){
		loadSprite(_path, _renderTarget);
	}

	void loadSprite(string path, SDL_Renderer* renderTarget){
		sprite_texture = SDL_CreateTextureFromSurface(renderTarget, IMG_Load(cast (char*)path));
		if(!sprite_texture){
			write("Error : ");
			writeln("Sprite Not Found : " ~ path);
			write("Error Details IMG : ");
			writeln(IMG_GetError());
			return ;
		}
		SDL_QueryTexture(sprite_texture,null,null,&textureWidth,&textureHeight);
		spriteRect.w = spritePosition.w = textureWidth;
		spriteRect.h = spritePosition.h = textureHeight;
	}

	SDL_Texture* getSprite(){
		return sprite_texture;
	}

	void render(int posX, int posY,SDL_Renderer* renderTarget){
		spritePosition.x = posX;
		spritePosition.y = posY;
		SDL_RenderCopyEx(renderTarget, sprite_texture,&spriteRect,&spritePosition,0,null,0);
	}
}