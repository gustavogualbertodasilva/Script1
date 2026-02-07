local Aimlock = {}

local AimLockActive = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- CONFIGURAÇÕES
local FOV_RADIUS = 30
local IsClicking = false

-- 1. Interface do Círculo
local circleGui
local circle

local function CriarCirculo()
    if not circleGui then
        circleGui = Instance.new("ScreenGui")
        circleGui.Name = "Aimbot"
        circleGui.IgnoreGuiInset = true
        circleGui.ResetOnSpawn = false
        circleGui.Parent = LocalPlayer.PlayerGui
    end

    if circle then
        circle:Destroy()
    end

    -- Cria o novo círculo
    circle = Instance.new("Frame")
    circle.Name = "FOVCircle"
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
    circle.Size = UDim2.new(0, FOV_RADIUS * 2, 0, FOV_RADIUS * 2)
    circle.BackgroundTransparency = 1
    circle.Parent = circleGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = circle

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.Thickness = 2
    stroke.Parent = circle
end

-- 2. Função para achar a cabeça mais próxima do centro
local function getClosestHead()
    local closestDistance = FOV_RADIUS
    local targetHead = nil
    local screenCenter = Camera.ViewportSize / 2

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            local hum = player.Character:FindFirstChild("Humanoid")

            if head and hum and hum.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if dist < closestDistance then
                        closestDistance = dist
                        targetHead = head
                    end
                end
            end
        end
    end
    return targetHead
end

-- 3. Loop de Câmera (Sobrescreve Arma/Shift Lock)
RunService:BindToRenderStep("Headlock", Enum.RenderPriority.Camera.Value + 1, function()
    
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    if not AimLockActive then
        local AimLockUI = playerGui:FindFirstChild("Aimbot")
        if AimLockUI then
            AimLockUI.Enabled = false
        end
    else
        local AimLockUI = playerGui:FindFirstChild("Aimbot")
        if AimLockUI then
            AimLockUI.Enabled = true
        end
    end


    if IsClicking then
        if AimLockActive then
            local target = getClosestHead()
            if target then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
            end
        end    
    end
end)

-- 4. Detectar Clique Esquerdo
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        IsClicking = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        IsClicking = false
    end
end)

function Aimlock.TurnOnOrOff(estado)
    AimLockActive = estado

    if circle then
        circle.Visible = AimLockActive
    end
end



function Aimlock.IsActive()
    return AimLockActive
end

function Aimlock.SetFOV(fov)
    FOV_RADIUS = math.clamp(fov, 5, 75)
end


return Aimlock
