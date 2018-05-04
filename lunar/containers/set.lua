local class = require("rtti").class

local set = class("set")

function set:ctor()
	local this = self.__pdatas

	this.m_size = 0
end

function set:Add(elem)
	local this = self.__pdatas

	local result = this[elem]
	this[elem] = true

	if not result then
		this.m_size = this.m_size + 1
	end
end

function set:Remove(elem)
	local this = self.__pdatas

	local result = this[elem]
	this[elem] = nil

	if result then
		this.m_size = this.m_size - 1
	end
end

function set:Member(elem)
	local this = self.__pdatas

	return (this[elem] or false)
end

function set:Size()
	local this = self.__pdatas

	return this.m_size
end



return set

-- function set:Union(s)
-- 	local this = self.__pdatas
-- 	local s_datas = s.__pdatas

-- 	for k, _ in pairs(s_datas) do
-- 		if k ~= "m_size" then
-- 			if not this[k] then
-- 				this[k] = true
-- 				this.m_size = this.m_size + 1
-- 			end
-- 		end
-- 	end
-- end

-- function set:Intersect(s)
-- 	local this = self.__pdatas
-- 	local s_datas = s.__pdatas

-- 	for k, _ in pairs(this)	do
-- 		if k ~= "m_size" then
-- 			if not s_datas[k] then
-- 				this[k] = nil
-- 				this.m_size = thsi.m_size - 1
-- 			end
-- 		end
-- 	end
-- end

-- function set:Difference(s)
-- 	local this = self.__pdatas
-- 	local s_datas = s.__pdatas

-- 	for k, _ in pairs(s_datas) do
-- 		if k ~= "m_size" then
-- 			if this[k] then
-- 				this[k] = nil
-- 				this.m_size = this.m_size - 1
-- 			end
-- 		end
-- 	end
-- end