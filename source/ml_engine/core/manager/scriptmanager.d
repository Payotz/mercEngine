module ml_engine.core.manager.scriptmanager;

import derelict.lua.lua;
import std.stdio;
import std.conv;

import ml_engine.core.manager.texturemanager;
import ml_engine.core.script.gui_binding;
import ml_engine.core.script.audio_binding;
import ml_engine.core.script.camera_binding;
import ml_engine.core.script.state_binding;
import ml_engine.core.script.room_binding;
import ml_engine.core.script.gameobject_binding;
import ml_engine.core.script.map_binding;
import ml_engine.core.script.player_binding;
import ml_engine.core.script.texture_binding;

import ml_engine.game;
import derelict.sdl2.sdl;

protected SDL_Renderer *renderTarget;
private int[string] bool_list;
private int[string] hp_list;

class ScriptManager{
    
    nothrow static ScriptManager getInstance(){
        try{
            if(!instantiated_){
                synchronized(ScriptManager.classinfo){
                    if(!instance_){
                        instance_ = new ScriptManager();
                    }
                    instantiated_ = true;
                }
            }
        }catch(Exception e){
        }
        return instance_;
    }

    void init(SDL_Renderer *value){
        L = luaL_newstate();
        luaL_openlibs(L);
        lua_register(L,cast(char*)"Delay",&Delay);
        lua_register(L,cast(char*)"getWindowWidth",&getWindowWidth);
        lua_register(L,cast(char*)"getWindowHeight",&getWindowHeight);  
        lua_register(L,cast(char*)"Quit",&Quit);
        lua_register(L,cast(char*)"writeWord",&writeWord);
        
        ///Audio Bindings
        
        lua_register(L,cast(char*)"Audio_loadSound",&loadSound);
        lua_register(L,cast(char*)"Audio_playSound",&playSound);
        lua_register(L,cast(char*)"Audio_loadMusic",&loadMusic);
        lua_register(L,cast(char*)"Audio_stopMusic",&stopMusic);
        lua_register(L,cast(char*)"Audio_playMusic",&playMusic);

        ///Camera Bindings

        lua_register(L,cast(char*)"Camera_setFocusOnPlayer",&camera_setFocusOnPlayer);
        lua_register(L,cast(char*)"Camera_setFocusOnObject",&camera_setFocusOnObject);
        lua_register(L,cast(char*)"Camera_setFreeRoam",&camera_setFreeRoam);
        
        ///GameObject Bindings

        lua_register(L,cast(char*)"Object_addObject",&addObject);
        lua_register(L,cast(char*)"Object_setObjectSprite",&setObjectSprite);
        lua_register(L,cast(char*)"Object_setObjectDetails",&setObjectDetails);
        lua_register(L,cast(char*)"Object_setObjectPosition",&setObjectPosition);
        lua_register(L,cast(char*)"Object_moveObject",&moveObject);
        lua_register(L,cast(char*)"Object_changeObjectSpriteLayer",&changeObjectSpriteLayer);
        lua_register(L,cast(char*)"Object_cleanObjectList",&cleanObjectList);

        ///GUI Bindings

        lua_register(L,cast(char*)"GUI_button",&button);
        lua_register(L,cast(char*)"GUI_prepare",&imgui_prepare);
        lua_register(L,cast(char*)"GUI_finish",&imgui_finish);
        lua_register(L,cast(char*)"GUI_textbox",&GUI_textbox);
        lua_register(L,cast(char*)"GUI_dialogueBox",&GUI_dialogueBox);

        ///Room Bindings

        lua_register(L,cast(char*)"Room_addRoom",&addRoom);
        lua_register(L,cast(char*)"Room_getCurrentRoomWidth",&getCurrentRoomWidth);
        lua_register(L,cast(char*)"Room_getCurrentRoomHeight",&getCurrentRoomHeight);
        lua_register(L,cast(char*)"Room_changeCurrentRoom",&changeCurrentRoom);


        ///Player Bindings

        lua_register(L,cast(char*)"Player_addPlayer",&addPlayer);
        lua_register(L,cast(char*)"Player_changePlayerSpriteLayer",&changePlayerSpriteLayer);
        lua_register(L,cast(char*)"Player_getPlayerPositionX",&getPlayerPositionX);
        lua_register(L,cast(char*)"Player_getPlayerPositionY",&getPlayerPositionY);
        lua_register(L,cast(char*)"Player_setPlayerPosition",&setPlayerPosition);
        lua_register(L,cast(char*)"Player_movePlayer",&movePlayer);
        lua_register(L,cast(char*)"Player_stopPlayer",&stopPlayer);
        lua_register(L,cast(char*)"Player_setSprite",&setSprite);

        ///State Bindings
        lua_register(L,cast(char*)"State_changeState",&changeState);
        lua_register(L,cast(char*)"State_addNewMenuState",&addNewMenuState);
        lua_register(L,cast(char*)"State_addNewTownState",&addNewTownState);

        ///Texture Bindings 

        lua_register(L,cast(char*)"Texture_addSprite",&addSprite);
        lua_register(L,cast(char*)"Texture_addSpriteSheet",&addSpriteSheet);
        lua_register(L,cast(char*)"Texture_addFont",&addFont);
        lua_register(L,cast(char*)"Texture_setSpriteAlpha",&setSpriteAlpha);

        ///Map Bindings

        lua_register(L,cast(char*)"Map_loadMap",&loadMap);
        lua_register(L,cast(char*)"Map_getMapHeight",&getMapHeight);
        lua_register(L,cast(char*)"Map_getMapWidth",&getMapWidth);
        lua_register(L,cast(char*)"Map_drawMap",&drawMap);

        ///Script Bindings
        lua_register(L,cast(char*)"Script_addScript",&addScriptToList);

        ///Event Bindings
        

        renderTarget = value;
        initGuiScript(renderTarget);
        textureInit(renderTarget);
        addScript("main","resources/script/main.lua");
        loadScript("main");
    }

    void addScript(string name,string path){
        script_list[name] = path;
    }

    void loadScript(string name){
        int s = luaL_loadfile(L,cast(char*)script_list[name]);
        if(!s)
            s = lua_pcall(L,0,LUA_MULTRET,0);
        if(s){
            write("Error : ");
            writeln(lua_tostring(L,-1));
            lua_pop(L,1);
        }
        //lua_close(L);
    }

    void reset(){
        cleanUp();
        init(renderTarget);
    }

    void cleanUp(){
        lua_close(L);
    }

    private:
        lua_State* L;
        string[string] script_list;
        
        __gshared ScriptManager instance_;
        static bool instantiated_;
}


extern(C) nothrow int addScriptToList(lua_State *L){
    try{
        string name = to!string(lua_tostring(L,1));
        string value = to!string(lua_tostring(L,2));
        lua_settop(L,0);
        ScriptManager.getInstance().addScript(name,value);
    }catch(Exception e){
    }
    return 0;
}



extern(C) nothrow int Delay(lua_State *L){
    try{
        int ms = to!int(lua_tonumber(L,1));
        lua_settop(L,0);
        SDL_Delay(ms);
    }catch(Exception e){

    }
    return 0;
}

extern(C) nothrow int getWindowWidth(lua_State * L){
    try{
        lua_settop(L,0);
        lua_pushnumber(L,Game.getInstance().getWidth());
    }catch(Exception e){
    }
    return 1;
}

extern(C) nothrow int getWindowHeight(lua_State * L){
    try{
        lua_settop(L,0);
        lua_pushnumber(L,Game.getInstance().getHeight());
    }catch(Exception e){
    }
    return 1;
}

extern(C) nothrow int Quit(lua_State *L){
    try{
        Game.getInstance().quit();
    }catch(Exception e){

    }
    return 0;
}

