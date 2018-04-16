-------------------------------------------------------------------------------
--
-- lua import impl
--
-- @author Blue Yang (swordday2008@gmail.com)
--
-- Created by Blue Yang on 4/16/2018.
--
-- @copyright 2015-2018 Blue Yang. All rights reserved.
--
-------------------------------------------------------------------------------


-- Module management strategy

local loaded = package.loaded
local searchpath = package.searchpath


local import = function (modname)
		if modname then
			local prefix = modname:match "(.*%.).*$" or (modname .. ".")
			return function (name)
					local fullname = prefix .. name
					local m = loaded[fullname] or loaded[name]
					if m then
						return m
					end

					if searchpath(fullname, package.path) then
						return require(fullname)
					else
						return require(name)
					end

				end		
		
		else 
			return require
		end
	end


return import