Audio_setDirectory("rsc/Merchant_Life");
Texture_setDirectory("rsc/Merchant_Life");
Script_setDirectory("rsc/Merchant_Life");
Map_setDirectory("rsc/Merchant_Life");

playerManager = loadfile(assert("rsc/Merchant_Life/script/manager/playermanager.lua"))()
    if playerManager == nil then
        print(loadfile("rsc/Merchant_Life/script/manager/playermanager.lua"))
    end
Camera = loadfile(assert("rsc/Merchant_Life/script/system/core/camera.lua"))()
Camera:createCamera()
Script_addScript("TownMainOnEnter","/script/system/town/onEnter.lua");
Script_addScript("TownMainUpdate","/script/system/town/update.lua");
Script_addScript("TownMainEvents","/script/system/town/handleEvents.lua");
Script_addScript("TownMainRender","/script/system/town/render.lua");
Script_addScript("TownMainExit","/script/system/town/onExit.lua");

Script_addScript("MainMenuOnEnter","/script/system/mainmenu/onEnter.lua");
Script_addScript("MainMenuUpdate","/script/system/mainmenu/update.lua");
Script_addScript("MainMenuEvents","/script/system/mainmenu/handleEvents.lua");
Script_addScript("MainMenuRender","/script/system/mainmenu/render.lua");
Script_addScript("MainMenuExit","/script/system/mainmenu/onExit.lua");

Script_addScript("ServerSelect","/script/system/serverselect/render.lua");

Script_addScript("dummy","/script/dummy.lua");
Script_addScript("DummyState","/script/dummystate.lua");

Texture_addSprite("/image/smiley.png","Tagged");
Texture_addSprite("/image/menuBG.jpg","Menu");
Texture_addSprite("/image/ground.png","Ground");
Texture_addSprite("/image/woodTable.jpg","Negotiation");
Texture_addSprite("/image/town.png","Town");

Texture_addFont("/font/BLKCHCRY.TTF","Black",72);
Texture_addFont("/font/BLKCHCRY.TTF","button_text",24);
Texture_addFont("/font/BLKCHCRY.TTF","chat_text",20);
Texture_addFont("/font/arial.ttf","arial",18);

State_addNewMenuState("MainMenu","MainMenuOnEnter","MainMenuUpdate","MainMenuEvents","MainMenuRender","MainMenuExit");
State_addNewTownState("Town","TownMainOnEnter","TownMainUpdate","TownMainEvents","TownMainRender","TownMainExit");
State_addNewMenuState("Server","dummy","dummy","dummy","ServerSelect","dummy");

State_changeState("MainMenu");