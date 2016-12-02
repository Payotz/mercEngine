module ml_engine.core.state.townstate;

import ml_engine.core.state.IState;
import ml_engine.core.manager.texturemanager;
import ml_engine.core.manager.audiomanager;
import ml_engine.core.manager.eventhandler;
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

class TownState : IState{

    this(string update_file,string render_file){
        script["update"] = update_file;
        script["render"] = render_file;
    }

	void onEnter(){
        //ScriptManager.getInstance().loadScript("TownMain");
        RoomManager.getInstance().addRoom("Sample","resources/tilemap/town.json","Town");
        //RoomManager.getInstance().setRoomFunction("Sample",&basicRoom_Process);
        //RoomManager.getInstance().setRoomFunction("Sample2",&basicRoom_Process);
        //RoomManager.getInstance().addRoom("Sample2","Basic_2","resources/tilemap/sample2.json","Ground");
        ///PlayerManager.getInstance().setPosition("Player_1",200,200);
        ///Camera.getInstance().setFocusOnPlayer("Player_1");   
        ///GameObjectManager.getInstance().addGameObject("Random", new NPC());
        ///GameObjectManager.getInstance().setSprite("Random", "Hero");
        ///GameObjectManager.getInstance().setPosition("Random", SDL_Point(3,3));
    }

	void update(){
        Camera.getInstance().update();
        GameObjectManager.getInstance().checkCollision("Player_1");
    }

	void handleEvents(ref bool gameLoop){        
        EventHandler.getInstance().initEventHandling();
    }

    void setScriptFile(string name,string text){
        script[name] = text;
    }

    string getScriptFile(string name){
        return script[name];
    }

	void render(SDL_Renderer *renderTarget){
        RoomManager.getInstance().renderRoom(renderTarget);
        PlayerManager.getInstance().render(renderTarget);
        GameObjectManager.getInstance().render(renderTarget);
    }

	void onExit(){
        
    }

    private Camera camera;
    private string[string] script;
    private bool wasMinimized;
} 