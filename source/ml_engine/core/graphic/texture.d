module ml_engine.core.graphic.texture;

import derelict.opengl;
import derelict.sdl2.mixer;
import derelict.sdl2.image;
import std.string;

class Texture{
    public:
        this(string _path){
            return;
        }

        void loadTexture(string path){
            auto surf = IMG_Load(path.toStringz());
            glGenTextures(1, &ID);
            glBindTexture(GL_TEXTURE_2D,ID);
                glTexImage2D(GL_TEXTURE_2D,0,GL_RGB,surf.w,surf.h,0,GL_RGB,GL_UNSIGNED_BYTE,surf.pixels);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP_TO_EDGE);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP_TO_EDGE);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
            glBindTexture(GL_TEXTURE_2D,ID);
        }

        void Use(){
            glBindTexture(GL_TEXTURE_2D,ID);
        }

    private:
        GLuint ID;
}