GUI_prepare();
local width = getWindowWidth();
local height = getWindowHeight();
writeWord(width/3, height/3, "Merchant Life","Black");
if (GUI_button(1,(width/2),(height/2),width * 0.10,50,"New Game")) == 1 then State_changeState("Town"); Audio_stopMusic("Sample"); end;
if (GUI_button(2,(width/2),(height/2) + 100,width * 0.10,height * 0.07,"Multiplayer")) == 1 then State_changeState("Server"); end;
if (GUI_button(3,(width/2),(height/2) + 200,width * 0.10,height * 0.07,"End Game")) == 1 then Quit(); end;
GUI_dialogueBox(4,(width/2),(height/2)+ 300,width * 0.10,height * 0.07,"Sample");
GUI_finish();