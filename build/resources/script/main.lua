Script_addScript("TownMain","resources/script/town/townmain.lua");
Script_addScript("MainMenuGUI","resources/script/gui/mainMenuScreen.lua");
Script_addScript("MainMenuUpdate","resources/script/update/mainMenuUpdate.lua");
Script_addScript("ServerSelect","resources/script/gui/serverselect.lua");
Script_addScript("dummy","resources/script/dummy.lua");
Script_addScript("DummyState","resources/script/dummystate.lua");

Audio_loadMusic("resources/bgm/plac_neg.ogg", "Sample");

Texture_addSpriteSheet("resources/image/image.png","Hero");
Texture_addSpriteSheet("resources/image/image.png","NPC");
Texture_addSpriteSheet("resources/image/spr_zero.png","Zero");

Texture_addSprite("resources/image/smiley.png","Tagged");
Texture_addSprite("resources/image/menuBG.jpg","Menu");
Texture_addSprite("resources/image/ground.png","Ground");
Texture_addSprite("resources/image/woodTable.jpg","Negotiation");
Texture_addSprite("resources/image/art.png","Town");

Texture_addFont("resources/font/BLKCHCRY.TTF","Black",72);
Texture_addFont("resources/font/BLKCHCRY.TTF","button_text",24);
Texture_addFont("resources/font/BLKCHCRY.TTF","chat_text",20);
Texture_addFont("resources/font/arial.ttf","arial",18);

State_addNewMenuState("Dummy","dummy","DummyState");
State_addNewMenuState("MainMenu","MainMenuUpdate","MainMenuGUI");
State_addNewTownState("Town","dummy","TownMain");
State_addNewMenuState("Server","dummy","ServerSelect");

State_changeState("MainMenu");

Player_addPlayer("Player_1");
Player_setSprite("Player_1","Hero");

Object_addObject("NPC");
Object_addObject("NPC_2");

Room_addRoom("Sample","resources/tilemap/town.json","Town");
Player_setPlayerPosition("Player_1",573,578);
Camera_setFocusOnPlayer("Player_1");
Object_setObjectSprite("NPC","NPC");
Object_setObjectSprite("NPC_2","NPC");
Object_setObjectPosition("NPC_2",378,589);
Object_setObjectPosition("NPC",378,600);


