module ml_engine.core.graphic.sprite;

import ml_engine.core.graphic.texture;

import derelict.sdl2.sdl;
import derelict.sdl2.image;
import derelict.opengl;
import std.stdio;

class Sprite{

	public:
		this(string _path, SDL_Renderer* _renderTarget){
			texture = new Texture();
			loadSprite(_path, _renderTarget);
		}

		void loadSprite(string path){
			GLuint VBO;
			
			glGenVertexArrays(1, &ID);
			glGenBuffers(1,&VBO);
			glBindVertexArray(ID);
				glBindBuffer(GL_ARRAY_BUFFER,VBO);
				glBufferData(GL_ARRAY_BUFFER,vertices.sizeof,vertices,GL_STATIC_DRAW);
				glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 4 * GL_FLOAT.sizeof, cast(GLuint*)0);
				glBindBuffer(GL_ARRAY_BUFFER, 0);
				glEnableVertexAttribPointer(0);
			glBindVertexArray(0);

			texture.loadTexture(path);

		}

		void render(int posX, int posY,SDL_Renderer* renderTarget){
			texture.Use();
			glBindVertexArray(ID);
			glDrawArrays(GL_TRIANGLES,0,6);
			glBindVertexArray(0);
		}

	private:
		GLuint ID;
		auto vertices[] = [
			0.0f, 1.0f, 0.0f, 1.0f,
			1.0f, 0.0f, 1.0f, 0.0f,
			0.0f, 0.0f, 0.0f, 0.0f, 
		
			0.0f, 1.0f, 0.0f, 1.0f,
			1.0f, 1.0f, 1.0f, 1.0f,
			1.0f, 0.0f, 1.0f, 0.0f
		];
		Texture texture;

}