local class = require("rtti").class

BaseClass = BaseClass or class("BaseClass")

function BaseClass:ctor()
    -- public variable initialized
    self.value = 1

    -- private variable initialized    
    -- variable x read/write
    self.__pdatas.x = 0
    -- variable y only read
    self.__pdatas.y = 0
end

function BaseClass:GetX()
    return self.__pdatas.x
end

function BaseClass:SetX(value)
    self.__pdatas.x = value
end

function BaseClass:GetY()
    return self.__pdatas.y
end
