local Room = {}

Room._index = Room

function Room:createRoom(room_name,path,spriteAtlas_)
    Map_loadMap(room_name,path)
    self.room_name = room_name
    self.roomWidth = Map_getMapWidth(room_name)
    self.roomHeight = Map_getMapHeight(room_name)
    self.spriteAtlas = spriteAtlas_
end

function Room:getRoomWidth()
    return self.roomWidth

function Room:getRoomName()
    return self.room_name
end

function Room:pointInWarpObject(x,y)
    return Map_pointInWarpObject(x,y,self.room_name)
end

function Room:getRoomHeight()
    return self.roomHeight
end

function Room:render(camera_x,camera_y)
    Map_drawMap(self.room_name,self.spriteAtlas,camera_x,camera_y)
end

return Room