module ml_engine.core.state.townstate;

import ml_engine.core.state.IState;
import ml_engine.core.manager.texturemanager;
import ml_engine.core.manager.audiomanager;
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
        SDL_Event event;
        int movement_static = 1;
        SDL_PumpEvents();
        const Uint8* keystate = SDL_GetKeyboardState(null);
        auto player_pos = PlayerManager.getInstance().getPosition("Player_1");
        
        if(keystate[SDL_SCANCODE_UP]){
            auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x,player_pos.y-movement_static);
            if(GameObjectManager.getInstance().checkCollision("Player_1")){
                PlayerManager.getInstance().move("Player_1",0,0);
            }else if(a[0]){
                auto obj_args = a[1];
                if(obj_args["type"] == "obstacle"){
                    PlayerManager.getInstance().move("Player_1",0,0);
                }
                if(obj_args["type"] == "warp"){
                    PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
                    RoomManager.getInstance().changeRoom(obj_args["target_name"]);
                }
            }
            else{
                PlayerManager.getInstance().move("Player_1",0,movement_static * -1);
            }
            PlayerManager.getInstance().changeSpriteLayer("Player_1",4);
        }
        if(keystate[SDL_SCANCODE_DOWN]){
            auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x,player_pos.y+movement_static);
            if(GameObjectManager.getInstance().checkCollision("Player_1")){
                PlayerManager.getInstance().move("Player_1",0,0);
            }
            if(a[0]){
                auto obj_args = a[1];
                if(obj_args["type"] == "obstacle"){
                    PlayerManager.getInstance().move("Player_1",0,0);
                }
                if(obj_args["type"] == "warp"){
                    PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
                    RoomManager.getInstance().changeRoom(obj_args["target_name"]);
                }
            }else{
                PlayerManager.getInstance().move("Player_1",0,movement_static);
            }
            PlayerManager.getInstance().changeSpriteLayer("Player_1",1);
        }
        if(keystate[SDL_SCANCODE_RIGHT]){
            auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x+movement_static,player_pos.y);
            if(GameObjectManager.getInstance().checkCollision("Player_1")){
                PlayerManager.getInstance().move("Player_1",0,0);
            }
            else if(a[0]){
                auto obj_args = a[1];
                if(obj_args["type"] == "obstacle"){
                    PlayerManager.getInstance().move("Player_1",0,0);
                }
                if(obj_args["type"] == "warp"){
                    PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
                    RoomManager.getInstance().changeRoom(obj_args["target_name"]);
                }
            }
            else{
                PlayerManager.getInstance().move("Player_1",movement_static,0);
            }
            PlayerManager.getInstance().changeSpriteLayer("Player_1",3);
        }
        if(keystate[SDL_SCANCODE_LEFT]){
            auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x-movement_static,player_pos.y);
            if(GameObjectManager.getInstance().checkCollision("Player_1")){
                PlayerManager.getInstance().move("Player_1",0,0);
            }
            else if(a[0]){
                auto obj_args = a[1];
                if(obj_args["type"] == "obstacle"){
                    PlayerManager.getInstance().move("Player_1",0,0);
                }
                if(obj_args["type"] == "warp"){
                    PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
                    RoomManager.getInstance().changeRoom(obj_args["target_name"]);
                }
            }else{
                PlayerManager.getInstance().move("Player_1",movement_static * -1, 0);
            }
            PlayerManager.getInstance().changeSpriteLayer("Player_1",2);
        }
        if(keystate[SDL_SCANCODE_ESCAPE]){
            StateManager.getInstance().changeState("MainMenu");
        }
        if(keystate[SDL_SCANCODE_SPACE]){
            StateManager.getInstance().reset();
        }

        if(SDL_PollEvent(&event)){
            if(event.type == SDL_QUIT){
                gameLoop = false;
            }
            if(event.type == SDL_KEYUP){
                PlayerManager.getInstance().stopMove("Player_1");
            }
            if (event.type == SDL_WINDOWEVENT){
                if(event.window.event == SDL_WINDOWEVENT_MINIMIZED)
                    wasMinimized = true;
                if(event.window.event == SDL_WINDOWEVENT_RESTORED){
                    SDL_SetWindowSize(Game.getInstance().getMainWindow(),Game.getInstance().getWidth(),Game.getInstance().getHeight());
                    wasMinimized = false;
                }
            }
        }
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