module ml_engine.core.audio.sound;

import derelict.sdl2.mixer;

class Sound{
	private Mix_Chunk *sound;
	this(string path){
		addSound(path);
	}

	nothrow void addSound(string path){
		sound = Mix_LoadWAV(cast(char*)path);
	}

	nothrow auto getSound(){
		return sound;
	}

	nothrow void playSound(){
		Mix_PlayChannel(-1,sound,0);
	}
}