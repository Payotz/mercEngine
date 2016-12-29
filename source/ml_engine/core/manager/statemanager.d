module ml_engine.core.manager.statemanager;

import ml_engine.core.state.IState;
import ml_engine.core.state.menustate;
import ml_engine.core.state.townstate;
import ml_engine.core.manager.scriptmanager;
import derelict.sdl2.sdl;

class StateManager{

    static StateManager getInstance(){
        if(!instantiated_){
            synchronized(StateManager.classinfo){
                if(!instance_){
                    instance_ = new StateManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }  

    void init(){
        
    }

    void addNewMenuState(string name, string update_script,string render_script){
        addState(name,new MenuState(update_script,render_script));
    }

    void addNewTownState(string name, string update_script, string render_script){
        addState(name,new TownState(update_script,render_script));
    }

    void addState(string name, IState state){
        state_list[name] = state;
    }

    void setEventHandler(string name,string value){
        state_list[name].setEventHandler(value);
    }

    void changeState(string name){
        if(!currentState){
            currentState = state_list[name];
            currentState.onEnter();
        }else{
            currentState.onExit();
            currentState = state_list[name];
            currentState.onEnter();
        }
    }
    
    void render(SDL_Renderer *renderTarget){
        if(!currentState){
            return;
        }
        currentState.render(renderTarget);
    }

    void reset(){
        ScriptManager.getInstance().reset();
        currentState.onExit();
        currentState.onEnter();
    }

    void setScriptFile(string name,string script_name, string value){
        state_list[name].setScriptFile(script_name,value);
    }

    void update(){
        if(!currentState){
            return;
        }
        currentState.update();
    }

    void handleEvents(ref bool gameLoop){
        if(!currentState){
            return;
        }
        currentState.handleEvents(gameLoop);
    }

    private:
    
    this(){
    }
    
    static bool instantiated_;
    __gshared StateManager instance_;
    IState[string] state_list;
    IState currentState = null;

}