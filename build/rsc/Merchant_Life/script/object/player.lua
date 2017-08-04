local Player = {};
Player._index = Player
function Player:create(name,spriteName,x,y)
    self.name = name
    self.posX = x 
    self.posY = y 
    self.sprite = spriteName 
    self.spriteExists = false
    self.isSpriteSheet = false 
    self.isAnimated = false 
    print("Creating Player")
end

function Player:move(x,y)
    self.posX = self.posX + x
    self.posY = self.posY + y
end

function Player:setPosition(x,y)
    self.posX = x
    self.posY = y
end

function Player:getPositionX()
    return self.posX
end

function Player:getPositionY()
    return self.posY
end

function Player:setSprite(value)
    local results = 2 Texture_checkSpriteInList(value)
    if results == 0 then
        self.spriteExists = false
        print("Sprite Does not Exist : ")
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

function Player:isMoving(value)
    self.isAnimated = value
end

function Player:getSprite()
    return self.spriteName
end


function Player:render()
    if self.spriteExists == false then
        return
    else
        if self.isSpriteSheet == false then
            print(self.sprite)
            Texture_renderSprite(self.sprite,self.posX - Camera:getPosition().x,self.posY - Camera:getPosition().y)
            --Texture_renderSprite(self.sprite,self.posX,self.posY)
        else 
            Texture_setAnimated(self.sprite,self.isAnimated)
            Texture_renderSpriteSheet(self.sprite,self.posX,self.posY)
        end
    end
end

return Player;