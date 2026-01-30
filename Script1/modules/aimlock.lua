local Aimlock = {}

local ativo = false

function Aimlock.Toggle()
    ativo = not ativo
    print("Aimlock:", ativo and "ON" or "OFF")
end

return Aimlock