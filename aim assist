local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local aimbotEnabled = false
local targetPlayer = nil
local aimSmoothness = 0.2  -- Adjust this to make aiming more or less snappy

-- Function to find the closest visible player
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

-- Soft aim assist function
local function aimAssist()
    if aimbotEnabled and targetPlayer and targetPlayer.Character then
        local rootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local targetPosition = rootPart.Position
            local newCFrame = camera.CFrame:Lerp(CFrame.lookAt(camera.CFrame.Position, targetPosition), aimSmoothness)
            camera.CFrame = newCFrame
        end
    end
end

-- Toggle aim assist
local function toggleAimbot()
    if not aimbotEnabled then
        targetPlayer = getClosestPlayer()
        if targetPlayer then
            aimbotEnabled = true
            print("Aim assist activated on:", targetPlayer.Name)
        else
            print("No target found!")
        end
    else
        aimbotEnabled = false
        targetPlayer = nil
        print("Aim assist deactivated")
    end
end

-- Bind activation to N key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.N then
        toggleAimbot()
    end
end)

-- Smooth aim assist update
RunService.RenderStepped:Connect(aimAssist)
