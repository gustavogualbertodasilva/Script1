local Aimlock = {}

local AimLockActive = false -- variável privada do módulo

function Aimlock.TurnOnOrOff(estado)
    AimLockActive = estado
end

function Aimlock.IsActive()
    return AimLockActive
end

return Aimlock
