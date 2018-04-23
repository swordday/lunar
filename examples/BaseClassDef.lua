local class = require("rtti").class

BaseClass = BaseClass or class("BaseClass")

function BaseClass:ctor()
    -- public variable initialized
    self.m_value = 1

    -- private variable initialized    
    -- variable x read/write
    self.__pdatas.m_x = 0
    -- variable y only read
    self.__pdatas.m_y = 0
end

function BaseClass:get_x()
    return self.__pdatas.m_x
end

function BaseClass:set_x(value)
    self.__pdatas.m_x = value
end

function BaseClass:get_y()
    return self.__pdatas.m_y
end
