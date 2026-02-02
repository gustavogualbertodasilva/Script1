local UI = {}

function UI.Init(Aimlock)

--INTERFACE GERAL_____________________________________________________
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MinhaInterfaceExecutor"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local quadroAzul = Instance.new("Frame")
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


--Minimizar Menu Do Script____________________________________________

    local MinimizarMenu = Instance.new("TextButton")
    MinimizarMenu.Size = UDim2.new(0,70,0,25)
    MinimizarMenu.Position = UDim2.new(1,-70,0,0)
    MinimizarMenu.BackgroundColor3 = Color3.fromRGB(10,40,70)
    MinimizarMenu.Text = "MINIMIZE"
    MinimizarMenu.TextColor3 = Color3.fromRGB(0,255,255)
    MinimizarMenu.Parent = quadroAzul
    AimLockButton.BackgroundTransparency = 0

--____________________________________________________________________

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
--__________________________________________________________________



end

return UI
