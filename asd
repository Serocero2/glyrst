local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local aimbotEnabled = false
local targetPlayer = nil

-- Function to find the closest player
local function getClosestPlayer()
    local closest = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = plr.Character.HumanoidRootPart
            local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)

            if onScreen then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closest = plr
                end
            end
        end
    end

    return closest
end

-- Aimbot function
local function aimAtTarget()
    if aimbotEnabled and targetPlayer and targetPlayer.Character then
        local rootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, rootPart.Position)
        end
    end
end

-- Toggle aimbot
local function toggleAimbot()
    if not aimbotEnabled then
        targetPlayer = getClosestPlayer()
        if targetPlayer then
            aimbotEnabled = true
            print("Aimbot activated on:", targetPlayer.Name)
        else
            print("No target found!")
        end
    else
        aimbotEnabled = false
        targetPlayer = nil
        print("Aimbot deactivated")
    end
end

-- Bind aimbot activation to N key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.N then
        toggleAimbot()
    end
end)

-- Update aim every frame
RunService.RenderStepped:Connect(aimAtTarget)
