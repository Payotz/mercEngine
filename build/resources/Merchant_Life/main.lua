Audio_setDirectory("resources/Merchant_Life");
Texture_setDirectory("resources/Merchant_Life");
Script_setDirectory("resources/Merchant_Life");
Map_setDirectory("resources/Merchant_Life");
Script_addScript("TownMain","/script/town/townmain.lua");
Script_addScript("MainMenuGUI","/script/gui/mainMenuScreen.lua");
Script_addScript("MainMenuUpdate","/script/update/mainMenuUpdate.lua");
Script_addScript("ServerSelect","/script/gui/serverselect.lua");
Script_addScript("dummy","/script/dummy.lua");
Script_addScript("DummyState","/script/dummystate.lua");

Audio_loadMusic("/bgm/plac_neg.ogg", "Sample");

Texture_addSpriteSheet("/image/image.png","Hero");
Texture_addSpriteSheet("/image/image.png","NPC");
Texture_addSpriteSheet("/image/spr_zero.png","Zero");

Texture_addSprite("/image/smiley.png","Tagged");
Texture_addSprite("/image/menuBG.jpg","Menu");
Texture_addSprite("/image/ground.png","Ground");
Texture_addSprite("/image/woodTable.jpg","Negotiation");
Texture_addSprite("/image/art.png","Town");

Texture_addFont("/font/BLKCHCRY.TTF","Black",72);
Texture_addFont("/font/BLKCHCRY.TTF","button_text",24);
Texture_addFont("/font/BLKCHCRY.TTF","chat_text",20);
Texture_addFont("/font/arial.ttf","arial",18);

State_addNewMenuState("Dummy","dummy","DummyState");
State_addNewMenuState("MainMenu","MainMenuUpdate","MainMenuGUI");
State_addNewTownState("Town","dummy","TownMain");
State_addNewMenuState("Server","dummy","ServerSelect");

State_changeState("MainMenu");

Player_addPlayer("Player_1");
Player_setSprite("Player_1","Hero");

Object_addObject("NPC");
Object_addObject("NPC_2");

Room_addRoom("Sample","/tilemap/town.json","Town");
Player_setPlayerPosition("Player_1",573,578);
Camera_setFocusOnPlayer("Player_1");
Object_setObjectSprite("NPC","NPC");
Object_setObjectSprite("NPC_2","NPC");
Object_setObjectPosition("NPC_2",378,589);
Object_setObjectPosition("NPC",378,600);


