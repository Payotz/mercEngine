local Camera = {};
Camera._index = Camera

function Camera:createCamera()
    self.maxPos_x = 0
    self.maxPos_y = 0
    self.offset_x = 0
    self.offset_y = 0
    self.player = ""
    self.object = ""
    self.freeRoam = false
end

function Camera:setFocusOnPlayer(name)
    self.freeRoam = false
    self.object = ""
    self.player = name
end

function Camera:setFocusOnObject(name)
    self.freeRoam = false
    self.object = name
    self.player = ""
end

function Camera:setFreeRoam(value)
    self.freeRoam = true
    self.object = ""
    self.player = ""
end

function Camera:getPositionX()
    --print("Camera")
    --print(self.offset_x);
    return self.offset_x;
end

function Camera:getPositionY()
    return self.offset_y;
end

function Camera:update()
    --print("Updating Camera")
    --print(getWindowsHeight());
    self.offset_x = playerManager:getPositionX("Player_1") - 800 / 2;
    self.offset_y = playerManager:getPositionY("Player_1") - 600 / 2;

    if self.offset_x < 0 then
        self.offset_x = 0;
    end

    if self.offset_y < 0 then
        self.offset_y = 0;
    end
end

return Camera;