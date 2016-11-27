module ml_engine.game;
import derelict.sdl2.sdl;
import derelict.sdl2.image;
import derelict.sdl2.gfx.gfx;
import derelict.sdl2.mixer;
import derelict.sdl2.ttf;
import derelict.sdl2.net;
import derelict.lua.lua;

import ml_engine.core.manager.texturemanager;
import ml_engine.core.manager.audiomanager;
import ml_engine.core.manager.statemanager;
import ml_engine.core.manager.guimanager;
import ml_engine.core.manager.scriptmanager;
import ml_engine.manager.playermanager;
import ml_engine.manager.gameobjectmanager;
import ml_engine.core.camera;

import std.stdio;

///TODO: Implement GameObject collisions
///TODO: Implement Tilemap functions

class Game{
    
    public:

    static Game getInstance(){
        if(!instantiated_){
            synchronized(Game.classinfo){
                if(!instance_){
                    instance_ = new Game();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void init() {
        DerelictSDL2.load();
        DerelictSDL2Image.load();
        DerelictSDL2Mixer.load();
        DerelictSDL2ttf.load();
        DerelictSDL2Net.load();
        DerelictLua.load();
        DerelictSDL2Gfx.load();

        if(SDL_Init(SDL_INIT_EVERYTHING) < 0)
			writeln(SDL_GetError());
		if(IMG_Init(IMG_INIT_PNG) < 0 )
			writeln(IMG_GetError());
		if(Mix_OpenAudio(22050,MIX_DEFAULT_FORMAT,2,4096) < 0)
			writeln(Mix_GetError());
		if(TTF_Init() < 0)
			writeln(TTF_GetError());
		if(SDLNet_Init() < 0)
			writeln(SDLNet_GetError());
        
        window = SDL_CreateWindow("Hello World",SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,screen_width,screen_height,SDL_WINDOW_SHOWN | SDL_WINDOW_OPENGL) ;
        renderTarget = SDL_CreateRenderer(window,-1,SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
        StateManager.getInstance().init();
        GUIManager.getInstance().init(screen_width,screen_height);
        ScriptManager.getInstance().init(renderTarget);

    }

    void update(){
        StateManager.getInstance().update();
    }

    void handleEvents(){
        StateManager.getInstance().handleEvents(running);
    }

    void render(){
        SDL_SetRenderDrawColor(renderTarget,255,255,255,255);
        SDL_RenderClear(renderTarget);
        StateManager.getInstance().render(renderTarget);
        SDL_RenderPresent(renderTarget);
    }

    SDL_Renderer* getRenderer(){
        return renderTarget;
    }

    int getWidth(){
        return screen_width;
    }

    int getHeight(){
        return screen_height;
    }

    void quit(){
        running = false;
    }

    void exit(){
        SDL_DestroyWindow(window);
        SDL_DestroyRenderer(renderTarget);
        SDL_Quit();
    }

    bool isRunning() {
        return running;
    }
    
    private:
    static Game instance;
    bool running = true;
    SDL_Window *window;
    SDL_Renderer *renderTarget;

    int screen_width = 800;
    int screen_height = 600;

    __gshared Game instance_;
    static bool instantiated_;

    this() {
    }
}