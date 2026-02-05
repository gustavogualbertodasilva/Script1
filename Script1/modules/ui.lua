local UI = {}

function UI.Init(Aimlock)


    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")


--INTERFACE GERAL_____________________________________________________

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MinhaInterfaceExecutor"
    screenGui.ResetOnSpawn = false
    local quadroAzul = Instance.new("Frame")
    quadroAzul.ClipsDescendants = true
    screenGui.Parent = playerGui

    
    local uicornerAzul = Instance.new("UICorner")
    local gradient = Instance.new("UIGradient")

    quadroAzul.Size = UDim2.new(0, 400, 0, 200)
    quadroAzul.Position = UDim2.new(0.5, -200, 0, 0)
    quadroAzul.BackgroundColor3 = Color3.fromRGB(0,0,40)
    quadroAzul.Parent = screenGui

    uicornerAzul.CornerRadius = UDim.new(0, 15)
    uicornerAzul.Parent = quadroAzul

    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }
    gradient.Rotation = 45
    gradient.Parent = quadroAzul
--____________________________________________________________________


--INTERFACE MINIMIZADA________________________________________________
    local TelaMinimizada = Instance.new("TextButton")
    local CornerTelaMinimizada = Instance.new("UICorner")
    local GradientTelaMinimizada = Instance.new("UIGradient")
    
    TelaMinimizada.Position = UDim2.new(0.5, -30, 0, 100)
    TelaMinimizada.Size = UDim2.new(0, 60, 0, 60)
    TelaMinimizada.BackgroundColor3 = Color3.fromRGB(0,255,255)
    TelaMinimizada.Parent = screenGui
    TelaMinimizada.Visible = false 

    CornerTelaMinimizada.CornerRadius = UDim.new(0, 10)
    CornerTelaMinimizada.Parent = TelaMinimizada

    GradientTelaMinimizada.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }
    GradientTelaMinimizada.Rotation = 45
    GradientTelaMinimizada.Parent = TelaMinimizada


    TelaMinimizada.MouseButton1Click:Connect(function()
        
        quadroAzul.Visible = true
        TelaMinimizada.Visible = false
    end)

--____________________________________________________________________


--Minimizar Menu Do Script____________________________________________

    local MinimizarMenu = Instance.new("TextButton")
    MinimizarMenu.Size = UDim2.new(0,70,0,25)
    MinimizarMenu.Position = UDim2.new(1,-70,0,0)
    MinimizarMenu.BackgroundColor3 = Color3.fromRGB(15,38,60)
    MinimizarMenu.Text = "MINIMIZE"
    MinimizarMenu.TextColor3 = Color3.fromRGB(0,255,255)
    MinimizarMenu.Parent = quadroAzul
    MinimizarMenu.BackgroundTransparency = 0

    MinimizarMenu.MouseButton1Click:Connect(function()
        
        quadroAzul.Visible = false
        TelaMinimizada.Visible = true
    end)

--____________________________________________________________________


--AIMLBOT SETTINGS____________________________________________________

--Botão de desativar/ativar AimBot____________________________________
    local AimLockButton = Instance.new("TextButton")
    AimLockButton.Size = UDim2.new(0, 100, 0, 40)
    AimLockButton.Position = UDim2.new(0.5, -50, 0.5, -25)
    AimLockButton.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
    AimLockButton.Text = "AIM BOT"
    AimLockButton.TextColor3 = Color3.fromRGB(0, 255, 255)
    AimLockButton.Parent = quadroAzul
    AimLockButton.BackgroundTransparency = 0

    local botaoCorner = Instance.new("UICorner")
    botaoCorner.CornerRadius = UDim.new(0, 10)
    botaoCorner.Parent = AimLockButton

    AimLockButton.MouseButton1Click:Connect(function()
        Aimlock.TurnOnOrOff(not Aimlock.IsActive())
        if Aimlock.IsActive() then 
            AimLockButton.BackgroundColor3 = Color3.fromRGB(0, 70, 0)
        else
            AimLockButton.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
        end
    end)
--____________________________________________________________________


--Mudar Fov AimBot____________________________________________________

local NumericInputFov = Instance.new("TextBox")
NumericInputFov.Size = UDim2.new(0, 80, 0, 35)
NumericInputFov.Position = UDim2.new(0.5, -40, 0.8, 0)
NumericInputFov.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NumericInputFov.TextColor3 = Color3.fromRGB(0, 255, 255)
NumericInputFov.PlaceholderText = "5 - 75"
NumericInputFov.Text = "20"
NumericInputFov.ClearTextOnFocus = false
NumericInputFov.Parent = quadroAzul
Instance.new("UICorner", NumericInputFov).CornerRadius = UDim.new(0, 4)

NumericInputFov:GetPropertyChangedSignal("Text"):Connect(function()
    local texto = NumericInputFov.Text
    local somenteNumeros = texto:gsub("%D", "")
    if texto ~= somenteNumeros then
        NumericInputFov.Text = somenteNumeros
    end
end)

InputNumero.FocusLost:Connect(function()
    local valor = tonumber(InputNumero.Text)

    if not valor then
        InputNumero.Text = "5"
        return
    end

    if valor < 5 then
        InputNumero.Text = "5"
    elseif valor > 75 then
        InputNumero.Text = "75"
    end
end)

InputNumero.FocusLost:Connect(function()
    local valor = tonumber(InputNumero.Text)
    if valor then
        Aimlock.SetFOV(valor)
    end
end)

--____________________________________________________________________


--____________________________________________________________________

end

return UI
