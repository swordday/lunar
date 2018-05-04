local class = require("rtti").class

local list = class("list")


function list:ctor()
	local this = self.__pdatas

	this.m_head = {}	
	this.m_tail = {}
	this.m_size = 0

	this.m_head.m_next = this.m_tail
	this.m_tail.m_prev = this.m_head
end

function list:First()
	local this = self.__pdatas

	if this.m_size > 0 then
		return this.m_head.m_next
	else
		return nil
	end		
end

function list:Last()
	local this = self.__pdatas

	if this.m_size > 0 then
		return this.m_tail.m_prev
	else
		return nil
	end
end

function list:Size()
	local this = self.__pdatas

	return this.m_size
end

function list:Set(node, elem)
	node.m_value = elem
end

function list:Prev(node)
	local this = self.__pdatas
	if node.m_prev ~= this.m_head then
		return node.m_prev
	else
		return nil
	end
end

function list:Next(node)
	local this = self.__pdatas

	if node.m_next ~= this.m_tail then
		return node.m_next
	else
		return nil
	end
end


function list:AddFirst(elem)
	local this = self.__pdatas
	
	local node = {m_prev = this.m_head, m_next = this.m_head.m_next, m_value = elem}

	node.m_next.m_prev = node
	this.m_head.m_next = node

	this.m_size = this.m_size + 1
end

function list:AddLast(elem)
	local this = self.__pdatas

	local node = {m_prev = this.m_tail.m_prev, m_next = this.m_tail, m_value = elem}

	node.m_prev.m_next = node
	this.m_tail.m_prev = node

	this.m_size = this.m_size + 1
end

function list:AddBefore(node, elem)
	local this = self.__pdatas

	local new_node = {m_prev = node.m_prev, m_next = node.m_next, m_value = elem}

	new_node.m_prev.m_next = new_node
	node.m_prev = new_node

	this.m_size = this.m_size + 1
end

function list:AddAfter(node, elem)
	local this = self.__pdatas

	local new_node = {m_prev = node, m_next = node.m_next, m_value = elem}

	node.m_next = new_node
	node.m_next.m_prev = new_node

	this.m_size = this.m_size + 1
end

function list:Remove(node)
	local this = self.__pdatas

	node.m_prev.m_next = node.m_next
	node.m_next.m_prev = node.m_prev

	this.m_size = this.m_size - 1
end