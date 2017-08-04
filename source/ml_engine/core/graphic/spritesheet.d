module ml_engine.core.graphic.spritesheet;

import ml_engine.core.graphic.sprite;
import derelict.sdl2.sdl;
import derelict.sdl2.image;
import std.stdio;

class SpriteSheet : Sprite{
	public:

		override void render(int posX,int posY){
			return;
		}

		void setAnimated(bool isAnimated){
			animated = isAnimated;
		}

		/*void changeSprite(int layer_number){
			switch(layer_number){
				case 1:
					playerRect.y = 0;
					break;
				case 2:
					playerRect.y = frameHeight;
					break;
				case 3:
					playerRect.y = (frameHeight *2);
					break;
				case 4:
					playerRect.y = (frameHeight *3);
					break;
				default : break;
			}
		}*/
		private:
			SDL_Texture* sprite_texture;
			int FPS = 0;
			int frameTime = 0;
			int frameWidth, frameHeight;
			int textureWidth, textureHeight;
			bool animated = false;
}