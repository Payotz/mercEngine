
if Event_getKeyState(82) then --SDL_SCANCODE_UP = 82
    print(playerManager:move(0,-1))
    playerManager:changeSpriteLayer("Player_1",4)
end

if Event_getKeyState(81) then --SDL_SCANCODE_DOWN = 81
    playerManager:move(0,1)
    playerManager:changeSpriteLayer("Player_1",1)
end

if Event_getKeyState(79) then --SDL_SCANCODE_RIGHT = 79
    playerManager:move(1,0)
    playerManager:changeSpriteLayer("Player_1",3)
end

if Event_getKeyState(80) then --SDL_SCANCODE_LEFT = 80
    playerManager:move(-1,0)
    playerManager:changeSpriteLayer("Player_1",2)
end

if Event_checkKeyUp() then 
    playerManager:stopMove("Player_1")
end