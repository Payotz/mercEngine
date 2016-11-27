module ml_engine.core.camera;

import std.conv;
import ml_engine.game;

import ml_engine.manager.playermanager;
import ml_engine.manager.gameobjectmanager;
import derelict.sdl2.sdl;

import std.stdio;

class Camera {

    static Camera getInstance(){
        if(!instantiated_){
            synchronized (Camera.classinfo){
                if(!instance_){
                    instance_ = new Camera();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

	void setFocusOnPlayer(string name){
		freeRoam = false;
		object = null;
		player = name;
	}

	void setFocusOnObject(string name){
		freeRoam = false;
		player = null;
		object = name;
	}

	void setFreeRoam(bool value){
		freeRoam = value;
		player = null;
		object = null;
	}

	void move(int x, int y){
		writeln("Camera is in Free Roam");
	}

	auto getPositionX(){
		return offset_x;
	}
	
	auto getPositionY(){
		return offset_y;
	}

	void update() {
		if(player){
			offset_x = (PlayerManager.getInstance().getPosition("Player_1").x) - Game.getInstance().getWidth() / 2;
			offset_y = (PlayerManager.getInstance().getPosition("Player_1").y) - Game.getInstance().getHeight() / 2;
		}
		if(freeRoam){
			move(3,3);
		}
		if(offset_x < 0)
			offset_x = 0;
		if (offset_y < 0)
			offset_y = 0;
		//this.offset_x =(gameman.getObject("Player_1").getX() + 16) - 400 ;
		//this.offset_y =(gameman.getObject("Player_1").getY() + 16) - 300;
		//this.offset_x = (this.offset_x + gameman.getObject("Player_1").getX() / 2).fmax(0).fmin(maxPos_x);
		//this.offset_y = (this.offset_y).fmax(0).fmin(maxPos_y);
		/*SDL_Rect camera;
		camera.x = to!int(offset_x);
        camera.y = to!int(offset_y);
        camera.w = 640;
        camera.h = 320;
		SDL_RenderSetViewport(Game.getInstance().getRenderer(), &camera);
		*/
	}

	private :
	int maxPos_x;
	int maxPos_y;
    float offset_x = 0;
	float offset_y = 0;

	string player = null;
	string object = null;
	bool freeRoam = false;
	this(){
	}

	__gshared Camera instance_;
    static bool instantiated_;

}