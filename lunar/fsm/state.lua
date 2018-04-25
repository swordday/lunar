local class = require("rtti").class

local state = class("state")

function state:ctor()
	local this = self.__pdatas

    this.m_desc = "state"
    this.m_fsm = nil

    self.m_callback = nil
end

-- Functional
function state:Update(dt)
end

function state:Enter(fsm)
	local this = self.__pdatas

    this.m_fsm = fsm
end

function state:Exit()
	local this = self.__pdatas

    this.m_fsm = nil
    if self.m_callback then
        self.m_callback()
    end
end

function state:Terminate()
    self.__pdatas.m_terminated = true
end

function state:Resume()
    self.__pdatas.m_terminated = false
end


-- Getter and Setter
function state:get_desc()
    return self.__pdatas.m_desc
end


return state