local RoomManager = {}
RoomManager.current_room = nil

function RoomManager:addRoom(name,path,spriteAtlas)
    local room = loadfile(assert("rsc/Merchant_Life/script/room/room.lua")) ()
    if room == nil then
        print(loadfile("rsc/Merchant_Life/script/room/room.lua"))
    end
    room:createRoom(name,path,spriteAtlas)
    self[name] = room
    if self.current_room == nil then
        current_room = room
    end
end

function RoomManager:getRoomWidth()
    return self.current_room:getRoomWidth()
end

function RoomManager:getRoomHeight()
    return self.current_room:getRoomHeight()
end

function RoomManager:changeRoom(room)
    self.current_room = room
end

function RoomManager:pointInWarpObject(x,y)
    self.current_room:pointInWarpObject(x,y)
end

function RoomManager:renderRoom(camera_x,camera_y)
    self.current_room:render(camera_x,camera_y)
end

return RoomManager