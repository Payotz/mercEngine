local width = getWindowWidth();
local height = getWindowHeight();

local stakeState = true;
Neg_HpBar(1,width * 0.02,height * 0.10,getHPFromList("mc_hp"),20);
Neg_HpBar(2,width * 0.75,height * 0.10,getHPFromList("enemy_hp"),20);
Neg_PlayerStatus(3,width * 0.02,height *0.60,"Player");
Neg_PlayerStatus(4,width * 0.85,height *0.60,"Enemy Merchant");
if(button(5,width*0.20,height*0.20,20,20,"Test")) == 1 then setBoolFromList("StakeVisible", 0) end;

if(getBoolFromList("StakeVisible") == 0) then
    writeWord(width * 0.35,height * 0.10,"Stakes Mode")
    if(button(6,width *0.80, height * 0.80,100,125, "End Stake")) == 1 then setBoolFromList("StakeVisible",1) end;
    if(button(7,width *0.20, height * 0.80,100,125, "Offer info")) == 1 then setHPFromList("enemy_hp",getHPFromList("enemy_hp") - 50) setBoolFromList("StakeVisible",1) end;
    if(button(8,width *0.40, height * 0.80,100,125, "Offer partner")) == 1 then setHPFromList("mc_hp",getHPFromList("mc_hp") - 50) setBoolFromList("StakeVisible",1) end;
    end;

