module ml_engine.core.audio.music;

import derelict.sdl2.mixer;

class Music{
	Mix_Music *music = null;
	this(string path){
		loadMusic(path);
	}

	nothrow void loadMusic(string path){
		music = Mix_LoadMUS(cast(char*)path);
	}

	nothrow auto getMusic(){
		return music;
	}

	nothrow void playMusic(bool isLoop = true){	
        if(isLoop){
			Mix_PlayMusic(music,-1);
			isPlaying = true;
        }else{ 
			Mix_PlayMusic(music, 0);
			isPlaying = true;
        }
	}

	nothrow void stopMusic(){
		Mix_HaltMusic();
		isPlaying = false;
	}

	private bool isPlaying = false;
}