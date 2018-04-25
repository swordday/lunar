local class = require("rtti").class

statechart = class("statechart")

function statechart:ctor()
    local this = self.__pdatas

    this.m_prevState = nil
    this.m_currentState = nil
    this.m_nextState = nil
    this.m_terminated = false
end

function statechart:Start(init_state)
    local this = self.__pdatas

    this.m_currentState = init_state
    this.m_currentState:Enter(self)
end

function statechart:End()
    local this = self.__pdatas

    this.m_currentState:Exit()
    this.m_currentState = nil
    this.m_nextState = nil
end

function statechart:Update(dt)
    local this = self.__pdatas

    if this.m_nextState then
        local current_state = this.m_currentState
        if  current_state then
            current_state:Exit()
        end

        this.m_prevState = current_state
        this.m_currentState = this.m_nextState
        this.m_currentState:Enter(self)
        this.m_nextState = nil
    end

    if this.m_currentState then
        this.m_currentState:Update(dt)
    end
end

function statechart:Transition(state)
    self.__pdatas.m_nextState = state
end

function statechart:Terminate()
    local this = self.__pdatas

    if this.m_currentState then
        this.m_currentState:Terminate()
    end
end

function statechart:Resume()
    local this = self.__pdatas

    this.m_terminated = true
    if this.m_currentState then
        this.m_currentState:Resume()
    end
end

function statechart:Recover()
    local this = self.__pdatas

    if this.m_prevState then
        this.m_nextState = this.m_prevState
        this.m_prevState = nil
    end
end

-- Getter and Setter
function statechart:get_current_state()
    return self.__pdatas.m_currentState
end

function statechart:get_next_state()
    return self.__pdatas.m_nextState
end


return statechart