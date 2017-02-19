module ml_engine.core.state.townstate;

import ml_engine.core.state.IState;
import ml_engine.core.manager.texturemanager;
import ml_engine.core.manager.audiomanager;
import ml_engine.core.manager.eventmanager;
import ml_engine.core.manager.guimanager;
import ml_engine.core.manager.tilemapmanager;
import ml_engine.core.manager.statemanager;
import ml_engine.core.manager.scriptmanager;
import ml_engine.manager.gameobjectmanager;
import ml_engine.manager.playermanager;
import ml_engine.manager.roommanager;
import ml_engine.room.roomfunc;
import ml_engine.core.camera;
import ml_engine.game;
import derelict.sdl2.sdl;
import std.conv;
import std.stdio;
class TownState : IState{

    this(string onEnter_script, string update_script,string handleEvents_script, string render_script,string onExit_script){
        script["onEnter"] = onEnter_script;
        script["update"] = update_script;
        script["handleEvents"] = handleEvents_script;
        script["render"] = render_script;
        script["onExit"] = onExit_script;
        EventManager.getInstance().init();
        setEventHandler("Sample");
    }

	void onEnter(){
        if("onEnter" in script)
            ScriptManager.getInstance().loadScript(script["onEnter"]);
        else
            writeln("On Enter script not existing");
    }

	void update(){
        //Camera.getInstance().update();  
        //GameObjectManager.getInstance().checkCollision("Player_1");
        if("update" in script)
            ScriptManager.getInstance().loadScript(script["update"]);
        else
            writeln("Update Script does not exist");
    }

	void handleEvents(ref bool gameLoop){     
        //EventManager.getInstance().handleEvent(eventhandler);
        if("handleEvents" in script)
            ScriptManager.getInstance().loadScript(script["handleEvents"]);
        else
            writeln("Handle Events Script does not exist");
    }

    void setEventHandler(string name){
        eventhandler = name;
    }

    void setScriptFile(string name,string text){
        script[name] = text;
    }

    string getScriptFile(string name){
        return script[name];
    }

	void render(SDL_Renderer *renderTarget){
        //RoomManager.getInstance().renderRoom(renderTarget);
        //PlayerManager.getInstance().render(renderTarget);
        if("render" in script)
            ScriptManager.getInstance().loadScript(script["render"]);
        else
            writeln("Render Script does not exist");
        //GameObjectManager.getInstance().render(renderTarget);
    }

	void onExit(){
        
    }

    private Camera camera;
    private string[string] script;
    private string eventhandler;
    private bool wasMinimized;
} 