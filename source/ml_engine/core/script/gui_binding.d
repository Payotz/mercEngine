module ml_engine.core.script.gui_binding;

import ml_engine.core.manager.guimanager;
import ml_engine.core.manager.scriptmanager;
import ml_engine.core.manager.texturemanager;
import derelict.lua.lua;
import std.stdio;
import std.string;
import std.conv;
import derelict.sdl2.sdl;


protected SDL_Renderer *renderTarget;

void initGuiScript(SDL_Renderer *renderer){
    renderTarget = renderer;
}

    // Lua functions that interface with game
extern(C) nothrow int button(lua_State * L ){
    try{
        int id = to!int(lua_tonumber(L, 1));
        int xpos = to!int(lua_tonumber(L, 2));
        int ypos = to!int(lua_tonumber(L, 3));
        int width = to!int(lua_tonumber(L, 4));
        int height = to!int(lua_tonumber(L, 5));
        string txt = to!string(lua_tostring(L, 6));
        lua_pushnumber(L,GUIManager.getInstance().button(id,xpos,ypos,width,height,txt,renderTarget));
    }catch(Exception e){
    }
    return 1;
}

extern(C) nothrow int imgui_prepare(lua_State *L){
    try{
        GUIManager.getInstance().imgui_prepare();
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int imgui_finish(lua_State *L){
    try{
        GUIManager.getInstance().imgui_finish();
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int GUI_textbox(lua_State*L){
    try{
        int id = to!int(lua_tonumber(L, 1));
        int xpos = to!int(lua_tonumber(L, 2));
        int ypos = to!int(lua_tonumber(L, 3));
        int width = to!int(lua_tonumber(L, 4));
        int height = to!int(lua_tonumber(L, 5));
        auto dummy = toStringz(GUIManager.getInstance().textbox(id,xpos,ypos,width,height));
        if(dummy)
            lua_pushstring(L,dummy);
    }catch(Exception e){
         
    }
    return 1;
}

extern(C) nothrow int GUI_dialogueBox(lua_State*L){
    try{
        int id = to!int(lua_tonumber(L, 1));
        int xpos = to!int(lua_tonumber(L, 2));
        int ypos = to!int(lua_tonumber(L, 3));
        int width = to!int(lua_tonumber(L, 4));
        int height = to!int(lua_tonumber(L, 5));
        string text = to!string(lua_tostring(L,6));
        GUIManager.getInstance().dialogueBox(id,xpos,ypos,width,height,text);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int writeWord(lua_State *L){
    try{
        int x = to!int(lua_tonumber(L,1));
        int y = to!int(lua_tonumber(L,2));
        string message = to!string(lua_tostring(L,3));
        string font_name = to!string(lua_tostring(L,4));
        TextureManager.getInstance().renderFont(font_name,message,x,y);
    }catch(Exception e){
    }
    return 0;
}

extern(C) nothrow int drawRect(lua_State *L){
    try{
        int x = to!int(lua_tonumber(L,1));
        int y = to!int(lua_tonumber(L,2));
        int w = to!int(lua_tonumber(L,3));
        int h = to!int(lua_tonumber(L,4));
        ubyte r = to!ubyte(lua_tonumber(L,5));
        ubyte g = to!ubyte(lua_tonumber(L,6));
        ubyte b = to!ubyte(lua_tonumber(L,7));
    }catch(Exception e){
    }
    return 0;
}