local class = require("rtti").class

local deque = class("deque")


function deque:ctor()
	local this = self.__pdatas

	this.m_first = 0
	this.m_last = -1
end

function deque:AddFirst(elem)
	local this = self.__pdatas

	this.m_first = this.m_first - 1
	this[this.m_first] = elem
end

function deque:AddLast(elem)
	local this = self.__pdatas

	this.m_last = this.m_last + 1

	this[this.m_last] = elem
end

function deque:First()
	local this = self.__pdatas

	return this[this.m_first]
end

function deque:Last()
	local this = self.__pdatas

	return this[this.m_last]
end

function deque:GetFirst()
	local this = self.__pdatas

	if this.m_first > this.m_last then
		return nil
	end

	local result = this[this.m_first]
	this.m_first = this.m_first + 1 

	return result
end

function deque:GetLast()
	local this = self.__pdatas

	if this.m_first > this.m_last then
		return nil
	end

	local result = this[this.m_last]	
	this.m_last = this.m_last - 1

	return result
end

function deque:Size()
	local this = self.__pdatas

	return (this.m_last - this.m_first + 1)
end



return deque