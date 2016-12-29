module ml_engine.core.manager.eventmanager;
import ml_engine.core.event.eventhandler;
import ml_engine.core.event.eventfunc;
import derelict.sdl2.sdl;
import std.stdio;

class EventManager
{
    static EventManager getInstance(){
        synchronized(EventManager.classinfo){
        if(!_instantiated){
            instance = new EventManager();
        }
        _instantiated = true;
        }
        return instance;
    }

    void init(){
        addEventHandler("Sample");
        setRegisterCallback("Sample",SDL_SCANCODE_UP,&movePlayerUp);
        setRegisterCallback("Sample",SDL_SCANCODE_DOWN,&movePlayerDown);
        setRegisterCallback("Sample",SDL_SCANCODE_RIGHT,&movePlayerRight);
        setRegisterCallback("Sample",SDL_SCANCODE_LEFT,&movePlayerLeft);
        setRegisterCallback("Sample",SDL_SCANCODE_Z,&talk);
        setRegisterCallback("Sample",SDL_SCANCODE_ESCAPE,&quitGame);
        setRegisterCallback("Sample",SDL_SCANCODE_SPACE,&reset);
    }

    void handleEvent(string name){
        if(name in event_list)
            event_list[name].update();
        else
            writeln(name, " is not defined!");
    }

    void addEventHandler(string name){
        writeln("Adding ",name," to Event List");
        event_list[name] = new EventHandler();
    }

    void setRegisterCallback(string name, ubyte keycode, void function() func){
        event_list[name].registerCallback(keycode,func);
    }

        private static bool _instantiated;
        private __gshared EventManager instance;
        private EventHandler[string] event_list;
        private this(){}
}