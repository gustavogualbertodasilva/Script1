local Aimlock = {}

local AimLockActive = false -- variável privada do módulo

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
local sg = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
sg.IgnoreGuiInset = true
sg.Name = "Aimbot"
local circle = Instance.new("Frame", sg)
circle.AnchorPoint = Vector2.new(0.5, 0.5)
circle.Position = UDim2.new(0.5, 0, 0.5, 0)
circle.Size = UDim2.new(0, FOV_RADIUS * 2, 0, FOV_RADIUS * 2)
circle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
circle.BackgroundTransparency = 1.00
Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Thickness = 2
stroke.Parent = circle

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
    if IsClicking then
        if AimLockActive then
            local target = getClosestHead()
            if target then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
            else
                local AimLockUI = playerGui:FindFirstChild("MinhaInterfaceExecutor")
                if AimLockUI then
                    AimLockUI:Destroy()
                end
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
end

function Aimlock.IsActive()
    return AimLockActive
end



return Aimlock
