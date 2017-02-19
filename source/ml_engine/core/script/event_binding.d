module ml_engine.core.script.event_binding;

import ml_engine.game;
import derelict.lua.lua;
import derelict.sdl2.sdl;
import std.conv;

extern(C) nothrow int getScanCode(lua_State *L){
    try{
        Uint8* keystate = SDL_GetKeyboardState(null);
        int value = to!int(lua_tonumber(L,1));
        if(keystate[value])
        lua_pushboolean(L,true);
        else
        lua_pushboolean(L,false);
    }catch(Exception e){
    }
    return 1;
}

extern(C) nothrow int checkKeyUp(lua_State *L){
    try{
        int value = to!int(lua_tonumber(L,1));
        SDL_Event event;
        SDL_PollEvent(&event);
        if(event.type == SDL_KEYUP)
            return true;
        if(event.type == SDL_QUIT)
            Game.getInstance.quit();
    }catch(Exception e){
    }
    return 0;
}
