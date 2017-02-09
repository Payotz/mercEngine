local Player = {};
Player._index = Player
function Player:create(name,spriteName,x,y)
    local this =
    {
        name = name,
        posX = x,
        posY = y,
        sprite = spriteName
    }
    setmetatable(this,self);
    print("Creating Player")
    return this
end

function Player:move(x,y)
    self.x = self.x + x
    self.y = self.y + y
end

function Player:setPosition(x,y)
    self.x = self.x + x
    self.y = self.y + y
end

function Player:setSprite(value)
    print("Setting Sprite")
    local results = Texture_checkSpriteInList(value)
    if results == 0 then
        self.spriteExists = false
    else
        self.spriteExists = true
        if results == 1 then
            self.isSpriteSheet = false
        else
            self.isSpriteSheet = true
        end
        self.spriteName = value
    end
end

function Player:render()
    if self.spriteExists == false then
        return
    else
        if self.isSpriteSheet == false then
            Texture_renderSprite(self.sprite,self.posX,self.posY)
        else 
            Texture_setAnimated(self.sprite,self.isAnimated)
            Texture_renderSpriteSheet(self.sprite,self.posX,self.posY)
        end
    end
end

return Player;