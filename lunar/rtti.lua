local rtti = rtti or {}


local _class = _class or {}

function rtti.class(class_name, super)
	if _class[class_name] then
		print(class_name .. 'exist in _class table, please redefine the class name')
		return 
	end	

	if super and type(super) ~= 'table' then
		super = nil
		print(class_name .. ' (' .. type(super) .. ') cant inherit from non-table type')
	end

	local class_type = {}
	class_type.ctor = false
	class_type.new = function (...)
						local instance = {}
						setmetatable(instance, {__index = _class[class_name]})

						do 
							local create
							create = function(c, ...)
										if c.super then
											create(c.super, ...)
										end

										if c.ctor then
											c.ctor(instance, ...)
										end
									end											
						end

						return instance
					end


	local vtbl = {}				
	vtbl.__class_name = class_name
	vtbl.super = super

	_class[class_name] = vtbl

	local class_type_mt = {__index = vtbl, 
							__newindex = function(t, k, v)
											vtbl[k] = v
										end 
						}

	setmetatable(class_type, class_type_mt)

	if super then
		local super_mt = {__index = function (t, k)
 										local super_class = _class[super]
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
	return _class[class_name]
end

function rtti.is_kind(object, class_name)
	while object do
		if object.__class_name == class_name and
			return true
		end

		object = object.super
	end

	return false
end



return rtti