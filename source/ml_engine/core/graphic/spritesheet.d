module ml_engine.core.graphic.spritesheet;

import derelict.sdl2.sdl;
import derelict.sdl2.image;
import std.stdio;

class SpriteSheet{
	SDL_Texture* sprite_texture;
	private int FPS = 0;
	private int frameTime = 0;
	private SDL_Rect playerRect;
	private SDL_Rect playerPosition;
	private int frameWidth, frameHeight;
	private int textureWidth, textureHeight;
	private bool animated = false;

	this(string _path,int _FPS, SDL_Renderer* _renderTarget){
		loadSprite(_path, _renderTarget);
		FPS = _FPS;
	}

	void loadSprite(string path, SDL_Renderer* renderTarget){
		sprite_texture = SDL_CreateTextureFromSurface(renderTarget, IMG_Load(cast (char*)path));
		if(!sprite_texture){
			write("Error : ");
			writeln("Spritesheet Not Found : " ~ path);
			return ;
		}
		SDL_QueryTexture(sprite_texture,null,null,&textureWidth,&textureHeight);
		frameWidth = textureWidth / 3;
		frameHeight = textureHeight / 4;
		playerRect.x = frameWidth; 
		playerRect.y = 0;
		playerRect.w = frameWidth;
		playerRect.h = frameHeight;
		playerPosition.x = playerPosition.y = 0;
		playerPosition.w = playerPosition.h = 32;
	}

	SDL_Texture* getSprite(){
		return sprite_texture;
	}

	void render(int posX,int posY,SDL_Renderer* renderTarget){
		if(animated){
			frameTime++;
			if(FPS / frameTime == 4 ){
				frameTime = 0;
				playerRect.x += frameWidth;
				if(playerRect.x >= textureWidth)
					playerRect.x = 0;
			}
			playerPosition.x = posX  + 16;
			playerPosition.y = posY  + 16;
			SDL_RenderCopyEx(renderTarget,sprite_texture,&playerRect,&playerPosition,0,null,0);
		}else{
			playerRect.x = frameWidth;
			playerPosition.x = posX + 16;
			playerPosition.y = posY + 16;
			SDL_RenderCopyEx(renderTarget,sprite_texture,&playerRect,&playerPosition,0,null,0);
		}
	}

	void setAnimated(bool isAnimated){
		animated = isAnimated;
	}

	void changeSprite(int layer_number){
		switch(layer_number){
			case 1:
				playerRect.y = 0;
				break;
			case 2:
				playerRect.y = frameHeight;
				break;
			case 3:
				playerRect.y = (frameHeight *2);
				break;
			case 4:
				playerRect.y = (frameHeight *3);
				break;
			default : break;
		}
	}
}