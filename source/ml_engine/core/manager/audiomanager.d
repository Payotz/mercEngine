module ml_engine.core.manager.audiomanager;

import derelict.sdl2.mixer;
import ml_engine.core.audio.music;
import ml_engine.core.audio.sound;

class AudioManager{
	
    static AudioManager getInstance(){
        if(!instantiated_){
            synchronized(AudioManager.classinfo){
                if(!instance_){
                    instance_ = new AudioManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

	void loadSound(string path, string name){
		sound_list[name] = new Sound(path);
	}

	void playSound(string name){
		sound_list[name].playSound();
	}

	void loadMusic(string path, string name){
		music_list[name] = new Music(path);
	}

	void stopMusic(string name){
		music_list[name].stopMusic();
	}

	void cleanMusic(){
		foreach(Xmusic; music_list){
			Xmusic = null;
		}
	}

	void cleanSound(){
		foreach(Xsound;sound_list){
			Xsound = null;
		}
	}

	void playMusic(string name){	
        if(Mix_PlayingMusic() == 0){
			music_list[name].playMusic();
        }else{
			music_list[name].stopMusic();
			music_list[name].playMusic();
		}
	}
    private:
    Music[string] music_list;
	Sound[string] sound_list;
    __gshared AudioManager instance_;
    static bool instantiated_;
	
	this(){
	}

}