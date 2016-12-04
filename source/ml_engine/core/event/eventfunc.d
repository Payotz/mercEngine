module ml_engine.core.event.eventfunc;
import ml_engine.manager.playermanager;
import ml_engine.manager.gameobjectmanager;
import ml_engine.manager.roommanager;
import ml_engine.core.manager.statemanager;
import ml_engine.core.manager.texturemanager;
import std.stdio;
import ml_engine.game;

import std.conv;

int movement_static = 1;

void movePlayerUp(){
    auto player_pos = PlayerManager.getInstance().getPosition("Player_1");
    auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x,player_pos.y-movement_static);
    if(GameObjectManager.getInstance().checkCollision("Player_1")){
        PlayerManager.getInstance().move(0,0);
        }else if(a[0]){
            auto obj_args = a[1];
            if(obj_args["type"] == "obstacle"){
                PlayerManager.getInstance().move(0,0);
            }
            if(obj_args["type"] == "warp"){
                PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
                RoomManager.getInstance().changeRoom(obj_args["target_name"]);
                }
            }
            else{
                PlayerManager.getInstance().move(0,movement_static * -1);
            }
            PlayerManager.getInstance().changeSpriteLayer("Player_1",4);
}

void movePlayerDown(){
    auto player_pos = PlayerManager.getInstance().getPosition("Player_1");
    auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x,player_pos.y+movement_static);
    if(GameObjectManager.getInstance().checkCollision("Player_1")){
        PlayerManager.getInstance().move(0,0);
    }
    if(a[0]){
        auto obj_args = a[1];
        if(obj_args["type"] == "obstacle"){
            PlayerManager.getInstance().move(0,0);
        }
        if(obj_args["type"] == "warp"){
            PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
            RoomManager.getInstance().changeRoom(obj_args["target_name"]);
        }
        }else{
            PlayerManager.getInstance().move(0,movement_static);
        }
    PlayerManager.getInstance().changeSpriteLayer("Player_1",1);
}

void movePlayerLeft(){
    auto player_pos = PlayerManager.getInstance().getPosition("Player_1");
    auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x-movement_static,player_pos.y);
        if(GameObjectManager.getInstance().checkCollision("Player_1")){
            PlayerManager.getInstance().move(0,0);
        }
        else if(a[0]){
            auto obj_args = a[1];
            if(obj_args["type"] == "obstacle"){
                PlayerManager.getInstance().move(0,0);
            }
            if(obj_args["type"] == "warp"){
                PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
                RoomManager.getInstance().changeRoom(obj_args["target_name"]);
            }
            }else{
                PlayerManager.getInstance().move(movement_static * -1, 0);
            }
    PlayerManager.getInstance().changeSpriteLayer("Player_1",2);
}

void movePlayerRight(){
    auto player_pos = PlayerManager.getInstance().getPosition("Player_1");
    auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x+movement_static,player_pos.y);
        if(GameObjectManager.getInstance().checkCollision("Player_1")){
            PlayerManager.getInstance().move(0,0);
        }
        else if(a[0]){
            auto obj_args = a[1];
            if(obj_args["type"] == "obstacle"){
                PlayerManager.getInstance().move(0,0);
            }
            if(obj_args["type"] == "warp"){
                PlayerManager.getInstance().setPosition("Player_1",to!int(obj_args["target_x"]),to!int(obj_args["target_y"]));
                RoomManager.getInstance().changeRoom(obj_args["target_name"]);
            }
        }
        else{
            PlayerManager.getInstance().move(movement_static,0);
        }
        PlayerManager.getInstance().changeSpriteLayer("Player_1",3);
}

void stopAnimation(string name){
    PlayerManager.getInstance().stopMove(name);
}

void quitGame(){
    Game.getInstance().quit();
}

void reset(){
    StateManager.getInstance().reset();
}

void talk(){
    auto player_pos = PlayerManager.getInstance().getPosition("Player_1");
    auto a = RoomManager.getInstance().pointInWarpObject(player_pos.x,player_pos.y-movement_static);
    if(GameObjectManager.getInstance().checkCollision("Player_1")){
        writeln("Talking to NPC");
    }
}