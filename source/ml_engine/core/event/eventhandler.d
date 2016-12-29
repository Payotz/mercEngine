module ml_engine.core.event.eventhandler;

import ml_engine.core.event.eventfunc;
import ml_engine.game;
import derelict.sdl2.sdl;
import std.range;
import std.variant;
import std.stdio;

class EventHandler{

    this(){
        
    }

    void update(){
        SDL_Event event;
        SDL_PollEvent(&event);
        auto keystate = SDL_GetKeyboardState(null);
        foreach(keycode; dummy_code){
            if(keystate[keycode])
                fireEvent(keycode);
        }
        switch(event.type){
            case SDL_QUIT:
                Game.getInstance().quit();
                break;

            case SDL_KEYUP:
                stopAnimation("Player_1");
                break;

            default:
                break;
        }
    }

    void registerCallback(Uint8 code, void function() value){
        dummy_code ~= code;
        event[code] = value;
    }

    void fireEvent(Uint8 code){
        event[code]();
    }

    private:
    alias Func = void function ();
    alias EventHandler = void function();
    Func[ubyte] event;
    ubyte[] dummy_code;
}