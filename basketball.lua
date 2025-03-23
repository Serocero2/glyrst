--// Perfect Aim Assist for Basketball Game
--// Ensures the ball always enters the opponent's hoop based on the player's team

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Ball = nil
local AimAssistEnabled = true

-- Define home and away rings
local TeamRings = {
    ["Home"] = CFrame.new(146.552, 18.5, -297.112), -- Home team's ring
    ["Away"] = CFrame.new(-146.261, 18.5, -297.368)  -- Away team's ring
}

-- Function to get player's team
local function GetPlayerTeam()
    local teamName = LocalPlayer.Team and LocalPlayer.Team.Name or "Neutral"
    warn("Detected Team: " .. teamName)
    return teamName
end

-- Get the opponent's ring based on the player's team
local function GetTargetRing()
    local TeamName = GetPlayerTeam()
    local TargetRing = nil
    
    if TeamName == "Home" then
        TargetRing = TeamRings["Away"] -- Home team scores in Away ring
    elseif TeamName == "Away" then
        TargetRing = TeamRings["Home"] -- Away team scores in Home ring
    end
    
    if TargetRing then
        warn("Target Ring: " .. tostring(TargetRing.Position))
    else
        warn("No specific ring assigned for team: " .. TeamName .. ", defaulting to Home target.")
        TargetRing = TeamRings["Away"] -- Default to Away target if unknown
    end
    return TargetRing
end

-- Instantly teleport ball into the opponent's hoop
local function TeleportBallToHoop(ball)
    if not AimAssistEnabled or not ball then return end
    local TargetRing = GetTargetRing()
    if not TargetRing then return end
    
    task.wait(0.2) -- Short delay to allow shot animation
    ball.CFrame = TargetRing + Vector3.new(0, -1, 0)
    ball.Velocity = Vector3.zero
    ball.AssemblyLinearVelocity = Vector3.zero
    warn("Ball teleported to: " .. tostring(TargetRing.Position))
end

-- Detect ball being shot
workspace.ChildAdded:Connect(function(child)
    if child:IsA("BasePart") and child.Name:lower():find("ball") then
        Ball = child
        TeleportBallToHoop(Ball)
    end
end)

-- Toggle aim assist with "INS" key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        AimAssistEnabled = not AimAssistEnabled
        warn("Aim Assist: " .. (AimAssistEnabled and "Enabled" or "Disabled"))
    end
