local class = require("rtti").class

local array = class("array")

-- Basic
function array:ctor()
    local this = self.__pdatas
    this.m_size = 0
    this.m_buffer = {}
end

-- Functional
function array:Add(index, value)
    local this = self.__pdatas

    this.m_buffer[index] = value
    table.insert(this.m_buffer, index, value)
    this.m_size = this.m_size + 1
end

function array:Remove(index)
    local this = self.__pdatas

    table.remove(this.m_buffer, index)
    this.m_size = this.m_size - 1
end

function array:PushBack(value)
    local this = self.__pdatas

    this.m_size = this.m_size + 1
    this.m_buffer[this.m_size] = value
end

function array:PopBack()
    local this = self.__pdatas

    local value = this.m_buffer[this.m_size]
    
    this.m_buffer[this.m_size] = nil
    this.m_size = this.m_size - 1

    return value
end

function array:Empty()
    return self:Size() == 0
end

function array:Size()
    return self.__pdatas.m_size
end

-- Getter and Setter
function array:get(index)
    return self.__pdatas.m_buffer[index]
end

function array:set(index, value)
    self.__pdatas.m_buffer[index] = value
end

return array