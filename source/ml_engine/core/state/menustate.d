module ml_engine.core.state.menustate;

import derelict.sdl2.sdl;

import ml_engine.core.state.IState;
import ml_engine.core.manager.texturemanager;
import ml_engine.core.manager.audiomanager;
import ml_engine.core.manager.guimanager;
import ml_engine.manager.gameobjectmanager;
import ml_engine.manager.playermanager;
import ml_engine.core.manager.scriptmanager;
import ml_engine.game;

import std.stdio;
import std.conv;

class MenuState : IState{

    this(string update_script, string render_script){
        script["render"] = render_script;
        script["update"] = update_script;
    }

    void onEnter(){

    }

    void update(){
        ScriptManager.getInstance().loadScript(script["update"]);
        if(state.textinput == 1 )
            SDL_StartTextInput();
        if(state.textinput == 0)
            SDL_StopTextInput();
    }

    void render(SDL_Renderer *renderTarget){
        ScriptManager.getInstance().loadScript(script["render"]);
    }

    void setScriptFile(string name,string text){
        script[name] = text;
    }

    string getScriptFile(string name){
        return script[name];
    }

    void handleEvents(ref bool gameLoop){

        SDL_Event event;
        if(SDL_PollEvent(&event)){
            switch(event.type){
                case SDL_QUIT:
                    gameLoop=false;
                    break;
                case SDL_MOUSEMOTION:
                    state.mousex = event.motion.x;
                    state.mousey = event.motion.y;
                    break;
                case SDL_MOUSEBUTTONDOWN:
                    if(event.button.button == 1)
                        state.mousedown = 1;
                    break;
                case SDL_MOUSEBUTTONUP:
                    if(event.button.button == 1 )
                        state.mousedown = 0;
                    break;
                case SDL_TEXTINPUT:
                    state.text[to!string(state.kbditem)] ~= to!string(event.text.text[0]);
                    break;
                case SDL_TEXTEDITING:
                    state.text[to!string(state.kbditem)] = to!string(event.edit.text[0]);
                    state.cursor = to!int(event.edit.start);
                    break;
                case SDL_KEYDOWN:
                    if(event.key.keysym.sym == SDLK_BACKSPACE && state.text[to!string(state.kbditem)].length > 0 ){
                        state.text[to!string(state.kbditem)].length -= 1;
                    }
                    break;
                case SDL_WINDOWEVENT:
                    if(event.window.event == SDL_WINDOWEVENT_MINIMIZED)
                        wasMinimized = true;
                    if(event.window.event == SDL_WINDOWEVENT_RESTORED){
                        SDL_SetWindowSize(Game.getInstance().getMainWindow(),Game.getInstance().getWidth(),Game.getInstance().getHeight());
                        wasMinimized = false;
                    }
                    break;
                default:break;
            }
        }
    }

    void onExit(){

    }

    private string[string] script;
    private bool wasMinimized;
}