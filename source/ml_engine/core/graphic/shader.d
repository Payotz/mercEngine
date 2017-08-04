module ml_engine.core.graphic.shader;

import derelict.opengl;

import std.stdio;
import std.range;
import std.string;

class Shader{
    public:
        void loadShader(string name){
            auto file = File(name ~ ".vs");
            auto range = file.byLine();
            string content = "";
            foreach(line; range){
                content ~= line ~ "\n";
            }
            file.close();

            auto vertexSource = content.toStringz();
            
            content = "";
            file.open(name ~ ".fs");
            range = file.byLine();

            foreach(line; range){
                content ~= line ~ "\n:";
            }
            file.close();

            auto fragmentSource = content.toStringz();

            GLuint vertexShader;
            GLuint fragmentShader;

            vertexShader = glCreateShader(GL_VERTEX_SHADER);
            fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);

            glShaderSource(vertexShader ,1 ,&vertexSource , null);
            glShaderSource(fragmentShader,1 ,&fragmentSource, null);

            glCompileShader(vertexShader);
            checkShaderStatus(vertexShader);
            glCompileShader(fragmentShader);
            checkShaderStatus(fragmentShader);

            this.ID = glCreateProgram();
            glAttachShader(ID,vertexShader);
            glAttachShader(ID,fragmentShader);
            glLinkProgram(ID);
            checkProgramStatus(ID);

            glDeleteShader(vertexShader);
            glDeleteShader(fragmentShader);

        }

        void Use(){
            glUseProgram(this.ID);

        }

    private:
        GLuint ID;
}

void checkShaderStatus(GLuint shader){
    int success;
    char* infoLog[1024];
    glGetShaderiv(shader,GL_COMPILE_STATUS,&success);
    if(!success){
        glGetShaderInfoLog(shader,1024,cast(int*)null,cast(char*)infoLog);
        writeln(infoLog);
    }
}

void checkProgramStatus(GLuint program){
    int success;
    char* infoLog[1024];
    glGetProgramiv(program,GL_LINK_STATUS,&success);
    if(!success){
        glGetProgramInfoLog(program,1024,cast(int*)null,cast(char*)infoLog);
        writeln(infoLog);
    }
}