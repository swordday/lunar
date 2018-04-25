local class = require("rtti").class

local fiber = class("fiber")
fiber.s_Guarded = false
fiber.s_Fibers = {}
fiber.s_WaitingFibers = {}

-- fiber
-- m_co            coroutine
-- m_paused        boolean

-- Initialize Function
function fiber:ctor()
    
end

function fiber:init()
end

function fiber:release()
end

-- Static Function
function fiber.Instance()
    if not self.s_Instance then
        self.s_Instance = fiber.new()
    end

    return self.s_Instance
end

function fiber.Create(func)
    local fib = fiber.new()
    fib.__pdatas.m_co = coroutine.create(func)
    return fib
end

function fiber.Tick(dt)
    fiber.s_Guarded = true
    for k, f in pairs(self.s_Fibers) do
        if coroutine.status(f.m_co) == 'dead' then
            f.__pdatas.m_paused = false
            fiber.s_Fibers[k] = nil
            -- f:PrintError()
        end

        if f.Ticker and f:Ticker(dt) then
            f.Ticker = nil
            f:Resume()
        end
    end

    fiber.s_Guarded = false
    fiber.CheckWaitingFibers()    
end

function fiber.AddFiber(fib)
    if fib:get_paused() then
        return 
    end

    if fiber.s_Guarded then
        table.insert(fiber.s_WaitingFibers, fib)
    else
        table.insert(fiber.s_Fibers, fib)
        fib.set_puased(true)
    end
end

function fiber.CheckWaitingFibers()
    if fiber.s_Guarded then
        return 
    end

    for k, f in pairs(fiber.s_WaitingFibers) do
        if not f:get_yielded() then
            table.insert(fiber.s_Fibers, f)
            f:set_yielded(true)
            fiber.s_WaitingFibers[k] = nil
        end
    end
end

-- Functional
function fiber:Start(...)
    coroutine.resume(self.__pdatas.m_co, ...)
end

function fiber:GetStatus()
    return coroutine.status(self.__pdatas.m_co)
end

function fiber:IsYield()
    return self:GetStatus() == "yield"
end

function fiber:Yield(ticker) 
    self.__pdatas.m_ticker = ticker
    coroutine.yield(self.m_co)
end

-- Getter and Setter
function fiber:get_paused()
    return self.__pdatas.m_paused
end

function fiber:set_paused(paused)
    self.__pdatas.m_paused = paused
end


return fiber