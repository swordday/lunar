local class = require("rtti").class

local dictionary = class("dictionary")


function dictionary:ctor()
	local this = self.__pdatas

	this.m_size = 0
end

function dictionary:Find(k)
	local this = self.__pdatas

	local values = this[k]
	if not values then
		return nil
	end

	local _, value = next(values)
	return value
end

function dictionary:FindAll(k)
	local this = self.__pdatas

	return this[k]
end

function dictionary:Insert(k, v)
	local this = self.__pdatas

	local values = this[k] or {}
	table.insert(values, v)
	this[k] = values

	this.m_size = this.m_size + 1
end

function dictionary:Remove(k, v)
	local this = self.__pdatas

	local values = this[k]
	if values then
		for k, value in pairs(values) do
			if value == v then
				values[k] = nil
				this.m_size = this.m_size - 1
			end	
		end
	end

	if not next(values) then
		this[k] = nil
	end
end

function dictionary:Size()
	local this = self.__pdatas

	return this.m_size
end

function dictionary:Keys()
	local this = self.__pdatas

	local keys = {}
	for k, _ in pairs(this) do
		if k ~= "m_size" then
			table.insert(keys, k)
		end
	end

	return keys
end



return dictionary