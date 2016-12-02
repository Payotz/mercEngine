module ml_engine.core.manager.eventhandler;

import ml_engine.core.event.eventfunc;
import derelict.sdl2.sdl;
import std.variant;
import std.stdio;

class EventHandler{

    static EventHandler getInstance(){
        if(!instantiated_){
            synchronized(EventHandler.classinfo){
                if(!instance_){
                    instance_ = new EventHandler();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void init(){
        registerCallback("MoveUP",SDL_SCANCODE_UP,&movePlayerUp);
        registerCallback("MoveDown",SDL_SCANCODE_DOWN,&movePlayerDown);
        registerCallback("MoveRight",SDL_SCANCODE_RIGHT,&movePlayerRight);
        registerCallback("MoveLeft",SDL_SCANCODE_LEFT,&movePlayerLeft);
        registerCallback("Quit",SDL_SCANCODE_ESCAPE,&quitGame);
        registerCallback("Reset",SDL_SCANCODE_SPACE,&reset);
    }

    void initEventHandling(){
        SDL_PumpEvents();
        auto keystate = SDL_GetKeyboardState(null);
        foreach(action; command){
            if(keystate[action])
                fireEvent(action);
        }
    }


    void registerCallback(string action,Uint8 code, void function() value){
        command[action] = code;
        event[command[action]] = value;
    }

    void fireEvent(Uint8 code){
        event[code]();
    }

    private:
    alias Func = void function ();
    Func[ubyte] event;
    Uint8[string] command;
    __gshared EventHandler instance_;
    static bool instantiated_;
    this(){}
}