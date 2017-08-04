Texture_addSpriteSheet("/image/image.png","Hero");
Texture_addSpriteSheet("/image/image.png","NPC");
Texture_addSpriteSheet("/image/spr_zero.png","Zero");
Texture_addSpriteSheet("/image/image.png","LUA");
playerManager:createPlayer("Player_1","Hero",573,578) --573,578
playerManager:setSprite("Player_1","Hero");
Camera:setFocusOnPlayer("Player_1");
--Player_addPlayer("Player_1");
--Player_setSprite("Player_1","Hero");

--Object_addObject("NPC");
--Object_addObject("NPC_2");
--roomManager:addRoom("Sample","tilemap/town.json","Town")
Map_loadMap("Sample","/tilemap/town.json")
--Room_addRoom("Sample","/tilemap/town.json","Town");
--Player_setPlayerPosition("Player_1",573,578);
--Camera_setFocusOnPlayer("Player_1");
--Object_setObjectSprite("NPC","NPC");
--Object_setObjectSprite("NPC_2","NPC");
--Object_setObjectPosition("NPC_2",378,589);
--Object_setObjectPosition("NPC",378,600);