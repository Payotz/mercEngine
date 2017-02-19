local playerManager = {};
playerManager._index = playerManager

local _instance;

function playerManager.getInstance()
    if not _instance then
        _instance = playerManager
    end
    return _instance
end

function playerManager:createPlayer(name,spriteName,x,y)
    local person = loadfile(assert("rsc/Merchant_Life/script/object/player.lua"))()
    person:create(name,spriteName,x,y)
    self[name] = person
    return this
end

function playerManager:changeSpriteLayer(name, value)
    Texture_changeSpriteLayer(self[name]:getSprite(),value)
end

function playerManager:getPositionX(value)
    return self[value]:getPositionX()
end

function playerManager:getPositionY(value)
    return self[value]:getPositionY()
end

function playerManager:getPlayer(name)
    return self[name]
end

function playerManager:setPosition(name,x,y)
    self[name]:setPosition(x,y)
end

function playerManager:debug()
    print(self.current_player)
end

function playerManager:move(x,y)
    self["Player_1"]:move(x,y)
    self["Player_1"]:isMoving(true)
    --print(self["Player_1"].x)
    --local dummy_y = self[current_player].y 
    --dummy_x = dummy_x + x 
    --dummy_y = dummy_y + x 
    --self["Player_1"].x = self["Player_1"]x + x 
    --self["Player_1"].y = self["Player_1"].x + y
end

function playerManager:stopMove(value)
    self[value]:isMoving(false)
end

function playerManager:setCurrentPlayer(name)
    self.current_player = tableName
end

function playerManager:render()
    self["Player_1"]:render()
end

function playerManager:setSprite(name,value)
    self[name]:setSprite(value)
end

return playerManager;