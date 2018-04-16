-------------------------------------------------------------------------------
--
-- lua rtti impl
--
-- @author Blue Yang (swordday2008@gmail.com)
--
-- Created by Blue Yang on 7/12/2016.
--
-- @copyright 2015-2016 Blue Yang. All rights reserved.
--
-------------------------------------------------------------------------------


local rtti = rtti or {}


local _classifier = _classifier or {}

function rtti.class(class_name, super)
	if _classifier[class_name] then
		print("LUNAR ERROR: " .. class_name .. 'already exist in _classifier table, please redefine the class name')
		return 
	end	

	if super and type(super) ~= 'table' then
		super = nil
		print("LUNAR ERROR: " .. class_name .. ' (' .. type(super) .. ') cant inherit from non-table type')
	end

	local vtbl = {}				
	vtbl.__class_name = class_name
	vtbl.super = super

	local class_type = {}
	class_type.ctor = false
	class_type.new = function (...)
						local instance = {}
						setmetatable(instance, {__index = vtbl, 
												__gc = function(instance)
														if instance.dtor then
															instance:dtor()
														end
													end 
											})

						do 
							local ctor
							ctor = function(c, ...)
										if c.super then
											ctor(c.super, ...)
										end

										if c.ctor then
											c.ctor(instance, ...)
										end
									end			

							ctor(class_type, ...)																	
						end

						return instance
					end


	_classifier[class_name] = class_type

	local class_type_mt = {__index = vtbl, 
							__newindex = function(t, k, v)
											vtbl[k] = v
										end 
						}

	setmetatable(class_type, class_type_mt)


	if super then
		local super_mt = {__index = function (t, k)
 										local super_class = _classifier[super]
 										local ret = super_class[k]
 										vtbl[k] = ret
 										return ret 
 									end		
						}

		setmetatable(vtbl, super_mt)
	end


	return class_type
end

function rtti.get_class(class_name)
	return _classifier[class_name]
end

function rtti.get_function(class_name, func_name)
	local class_type = _classifier[class_name]
	if class_type then
		local fn = class_type[func_name]
		if type(fn) == "function" then
			return fn
		end
	end

	return nil
end

function rtti.is_kind(object, class_name)
	while object do
		if object.__class_name == class_name then
			return true
		end

		object = object.super
	end

	return false
end



return rtti