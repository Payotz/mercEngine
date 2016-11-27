module ml_engine.core.graphic.font;
import derelict.sdl2.ttf;
import derelict.sdl2.sdl;
import std.stdio;
import std.string;
import std.conv;
import core.stdc.string;
class Font{
	private TTF_Font* font;
	private SDL_Rect fontPosition;

	this(string path, int _size){
		loadFont(path,_size);
		font_size = _size;
	}

	void loadFont(string path, int size){
		font = TTF_OpenFont(cast(char*)path,size);
		if(!font)
			writeln("Error!");

	}
    
	auto getFont(){
		return font;
	}

	void render(string _message,int x, int y,SDL_Renderer* renderTarget){
		fontPosition.x = x;
		fontPosition.y = y;
		SDL_Surface* dummy;
		dummy = TTF_RenderText_Solid(font,toStringz(_message),SDL_Color(0,0,0));
		SDL_Texture* message = SDL_CreateTextureFromSurface(renderTarget, dummy);
		TTF_SizeText(font,toStringz(_message),&fontPosition.w,&fontPosition.h);		
		if(!message){
			writeln("Error writing message");
			writeln(TTF_GetError());
		}
		SDL_RenderCopy(renderTarget,message,null,&fontPosition);
	}

	private int font_size;
}