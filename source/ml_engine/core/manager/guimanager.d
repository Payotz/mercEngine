module ml_engine.core.manager.guimanager;

import derelict.sdl2.sdl;
import ml_engine.core.manager.statemanager;
import ml_engine.core.manager.texturemanager;
import ml_engine.core.manager.scriptmanager;
import derelict.lua.lua;

import std.stdio;
import std.conv;
import core.stdc.string;

import ml_engine.game;

///TODO: Arrange Structs,and Group widgets. Make it clean
///TODO: Implement new Widgets
///TODO: Implement Relative positioning
///TODO: Implement Color Switching for Fonts
class GUIManager{
    nothrow static GUIManager getInstance(){
        try{
            if(!instantiated_){
                synchronized(GUIManager.classinfo){
                    if(!instance_){
                        instance_ = new GUIManager();
                    }
                    instantiated_ = true;
                }
            }
        }catch(Exception e){
        }
        return instance_;
    }

    void init(int w, int h){
        screen_width = w;
        screen_height = h;
    }

    void drawRect(int x, int y, int w, int h,ubyte r,ubyte g, ubyte b, ubyte a,SDL_Renderer* renderTarget,SDL_BlendMode blendMode = SDL_BLENDMODE_NONE,bool fill = true, ubyte alpha = 255){
        SDL_Rect rect;
        rect.x = x;
        rect.y = y;
        rect.w = w;
        rect.h = h;
        SDL_SetRenderDrawBlendMode(renderTarget,blendMode);
        SDL_SetRenderDrawColor(renderTarget,r,g,b,a);
        if(fill)
            SDL_RenderFillRect(renderTarget,&rect);
        SDL_RenderDrawRect(renderTarget,&rect);
    }

    int regionhit(int x, int y, int w, int h){
        if(state.mousex < x ||
           state.mousey < y ||
           state.mousex >= x + w ||
           state.mousey >= y + h)
           return 0;
        return 1;
    }

    void imgui_prepare(){
        state.hotitem = 0;
    }

    void imgui_finish(){
        if(state.mousedown == 0){
            state.activeitem = 0;
        }else{
            if(state.activeitem == 0){
                state.activeitem = -1;
            }
        }
    }

    nothrow int button(int id, int x, int y,int w, int h,string text, SDL_Renderer* renderTarget){
    try{
        if(regionhit(x,y,w,h)){
            state.hotitem = id;
            if(state.activeitem == 0 && state.mousedown){
                state.activeitem = id;
            }
        }
        //drawRect(x+8,y+8,64,48,actionStates.renderTarget);
        if(state.hotitem == id){
            if(state.activeitem == id){
                drawRect(x+2,y+2,w,h,100,255,255,255,renderTarget);
            }else{
                drawRect(x+2,y+2,w,h,0,255,255,255,renderTarget);
            }
        }else{
            drawRect(x+2,y+2,w,h,128,128,128,255,renderTarget);
        }

        TextureManager.getInstance().renderFont("button_text",text,x,y,renderTarget);
        if(state.mousedown == 0 && state.hotitem == id && state.activeitem == id)
            return 1;
        }catch(Exception e){

        }
        return 0;
    }

    string textbox(int id, int x, int y, int w, int h, SDL_Renderer* renderTarget){
        if(regionhit(x,y,w,h)){
            state.hotitem = id;
        if(state.activeitem == 0 && state.mousedown){
            state.activeitem = id;
            }
        }
        if(state.mousedown == 0 && state.hotitem == id && state.activeitem == id){
            state.kbditem = id;
            if(state.textinput == 1 && state.hotitem == id){
                state.textinput = 0;
            }else{
                state.textinput = 1;
            }
        }

        if(state.kbditem == id)
            drawRect(x+2,y+2,w,h,100,255,255,255,renderTarget);
        else
            drawRect(x+2,y+2,w,h,to!ubyte(128),to!ubyte(128),to!ubyte(128),to!ubyte(255),renderTarget);
        string *ps = to!string(id) in state.text;
        
        if (ps){
            TextureManager.getInstance().renderFont("chat_text",state.text[to!string(id)],x,y,renderTarget);
            return state.text[to!string(id)];
        }

            return "none";
    }

    void dialogueBox(int id, int x, int y, int width, int height, string text, SDL_Renderer* renderTarget){
        if(regionhit(x,y,width,height)){
            state.hotitem = id;
            if(state.activeitem == 0 && state.mousedown){
                state.activeitem = id;
            }
        }
        drawRect(x,y,width,height,0,0,0,255,renderTarget,SDL_BLENDMODE_NONE,false);
        drawRect(x,y,width,height,60,79,188,45,renderTarget,SDL_BLENDMODE_BLEND,true,50);
        TextureManager.getInstance().renderFont("chat_text",text,x+10,y+10,renderTarget);
    }

    //GUI Funcs

    void renderNegotiationScreen(SDL_Renderer* renderTarget){
        SDL_SetRenderDrawColor(renderTarget,255,255,255,255);
        imgui_prepare();
        ScriptManager.getInstance().loadScript("NegotiationGUI");
        imgui_finish();
        SDL_SetRenderDrawColor(renderTarget,0,0,0,0);
    }

    void renderMainMenu(SDL_Renderer* renderTarget){
        
        //ScriptManager.getInstance().loadScript("MainMenuGUI");
        imgui_prepare();
        GUIManager.getInstance().textbox(100,200,200,500,50,renderTarget);
        imgui_finish();
        //TextureManager.getInstance().renderFont("Black","Merchant Life",screen_width / 3,screen_height/3,renderTarget);
    }

    private:

        this(){

        }

        GUIManager instance;
        SDL_Window*  window;
        const auto GEN_ID = __LINE__;

        enum buttonID{
            NORMAL_BUTTON
        }

        enum actionStates{
            ISNORMAL = 0,
            ISACTIVE = 1,
            ISHOT = 2,
            ISUNKNOWN = 3,
            HPBAR = 4
        }

        int screen_height;
        int screen_width;

        __gshared GUIManager instance_;
        static bool instantiated_;
}

struct UIState{
        int mousex = 0;
        int mousey = 0;
        int mousedown = 0;
        int rightmousedown = 0;

        int hotitem = 0;
        int activeitem = 0;

        int kbditem = 0;
        int keyentered = 0;
        int keymod = 0;

        int lastwidget = 0;

        int textinput = 0;
        
        int cursor= 0;

        static string[string] text;
};
UIState state;