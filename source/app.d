import std.stdio;
import ml_engine.game;

void main() {
	Game.getInstance().init();
	while (Game.getInstance.isRunning()){
		Game.getInstance().handleEvents();
		Game.getInstance().update();
		Game.getInstance().render();
	}
	Game.getInstance().exit();

}