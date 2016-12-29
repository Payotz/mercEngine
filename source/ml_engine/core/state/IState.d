module ml_engine.core.state.IState;
import derelict.sdl2.sdl;

interface IState{
	void onEnter(); 

	void update();

	void handleEvents(ref bool gameLoop);

	void render(SDL_Renderer *renderTarget);

	void setEventHandler(string value);

	string getScriptFile(string name);

	void setScriptFile(string name,string text);

	void onExit(); 
}