-- Load GUI and Initialize Main Window
local interface = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/z4gs/scripts/master/testtttt.lua"))():AddWindow("MadeByGlyrst", {
    main_color = Color3.fromRGB(0, 0, 225),
    min_size = Vector2.new(373, 340),
    can_resize = false
})

-- Helper to Access Game Services
local service = setmetatable({}, {
    __index = function(_, serviceName)
        return game:GetService(serviceName) or game[serviceName]
    end
})

-- Add Tabs
local farmingTab, optionsTab, trainersTab, miscTab = interface:AddTab("Farming"), interface:AddTab("Options"), interface:AddTab("Trainers"), interface:AddTab("Misc")

-- Variables
local player = service.Players.LocalPlayer
local remotes = service.ReplicatedStorage.Remotes
local statsFunc = player.PlayerFolder.StatsFunction
local team = player.PlayerFolder.Customization.Team.Value
local settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/z4gs/scripts/master/Settings.lua"))()("Ro-Ghoul Autofarm Alternative", {
    Skills = {E = false, F = false, C = false, R = false, G = false},
    Boss = {["Gyakusatsu"] = false, ["Eto Yoshimura"] = false, ["Koutarou Amon"] = false, ["Nishiki Nishio"] = false, ["Touka Kirishima"] = false},
    DistanceFromNpc = 4,
    DistanceFromBoss = 8,
    TeleportSpeed = 160,
    ReputationFarm = false,
    ReputationCashout = false,
    AutoKickWhitelist = ""
})

-- Utility Functions
local function formatNumber(number)
    local i, j, k = tostring(number):match("(%-?%d?)(%d*)(%.?.*)")
    return i..k:reverse():gsub("(%d%d%d)", "%1,"):reverse()..j
end

local function teleportTo(position)
    local rootPart = player.Character.HumanoidRootPart
    local targetPosition = CFrame.new(position)
    local distance = (rootPart.Position - position).magnitude
    local travelTime = distance / settings.TeleportSpeed

    local tween = game:GetService("TweenService"):Create(rootPart, TweenInfo.new(travelTime, Enum.EasingStyle.Linear), {CFrame = targetPosition})
    tween:Play()

    local finished = false
    tween.Completed:Connect(function() finished = true end)

    while not finished do
        if not settings.autofarm then tween:Cancel() break end
        task.wait()
    end
end

-- Farming Logic
local function startFarming()
    if not settings.autofarm then
        settings.autofarm = true
        local startTime = tick()

        while settings.autofarm do
            farmingTab:UpdateLabel("Time Elapsed: " .. os.date("!%H:%M:%S", tick() - startTime))
            task.wait(1)
        end
    else
        settings.autofarm = false
    end
end

-- GUI Components
farmingTab:AddLabel("Target NPC")
local dropdown = farmingTab:AddDropdown("Select NPC", function(option)
    settings.targetNpc = option
end)

local startButton = farmingTab:AddButton("Start Farming", startFarming)
local resetButton = farmingTab:AddButton("Reset", function() settings.autofarm = false end)

-- Options Tab
local function initializeOptionsTab()
    optionsTab:AddSwitch("Reputation Farm", function(state)
        settings.ReputationFarm = state
    end):Set(settings.ReputationFarm)

    optionsTab:AddSwitch("Auto Reputation Cashout", function(state)
        settings.ReputationCashout = state
    end):Set(settings.ReputationCashout)

    optionsTab:AddSlider("Teleport Speed", function(value)
        settings.TeleportSpeed = value
    end, {min = 90, max = 250}):Set(settings.TeleportSpeed)

    optionsTab:AddSlider("Distance from NPC", function(value)
        settings.DistanceFromNpc = value
    end, {min = 0, max = 8}):Set(settings.DistanceFromNpc)

    optionsTab:AddSlider("Distance from Boss", function(value)
        settings.DistanceFromBoss = value
    end, {min = 0, max = 15}):Set(settings.DistanceFromBoss)

    for boss, level in pairs(settings.Boss) do
        optionsTab:AddSwitch(boss .. " Boss Farm", function(state)
            settings.Boss[boss] = state
        end):Set(settings.Boss[boss])
    end
end

initializeOptionsTab()

-- Trainers Tab
local function initializeTrainersTab()
    trainersTab:AddLabel("Current Trainer: " .. player.PlayerFolder.Trainers[team .. "Trainer"].Value)

    local progressBar = trainersTab:AddSlider("Progress", nil, {min = 0, max = 100, readonly = true})
    progressBar:Set(player.PlayerFolder.Trainers[team .. "Trainer"].Progress.Value)

    player.PlayerFolder.Trainers[team .. "Trainer"].Changed:Connect(function()
        trainersTab:UpdateLabel("Current Trainer: " .. player.PlayerFolder.Trainers[team .. "Trainer"].Value)
        progressBar:Set(player.PlayerFolder.Trainers[team .. "Trainer"].Progress.Value)
    end)

    local trainerButton = trainersTab:AddButton("Start Training", function()
        if not settings.training then
            settings.training = true
            trainerButton.Text = "Stop Training"
        else
            settings.training = false
            trainerButton.Text = "Start Training"
        end
    end)
end

initializeTrainersTab()

-- Misc Tab
local function initializeMiscTab()
    miscTab:AddSwitch("Auto Add Weapon Stats", function(state)
        settings.autoAddWeaponStats = state
    end)

    miscTab:AddSwitch("Auto Add Durability Stats", function(state)
        settings.autoAddDurabilityStats = state
    end)

    miscTab:AddSwitch("Auto Kick", function(state)
        settings.autoKick = state
    end)

    miscTab:AddLabel("Auto Kick Whitelist")
    local console = miscTab:AddConsole({["y"] = 50, ["source"] = "Text"})
    console:Set(settings.AutoKickWhitelist)
    console:OnChange(function(newText)
        settings.AutoKickWhitelist = newText
    end)

    for skill, _ in pairs(settings.Skills) do
        miscTab:AddSwitch("Auto Use " .. skill .. " Skill (on bosses)", function(state)
            settings.Skills[skill] = state
        end):Set(settings.Skills[skill])
    end
end

initializeMiscTab()

-- Main Loop
coroutine.wrap(function()
    while true do
        if settings.autofarm then
            -- Farming logic here
        end
        task.wait()
    end
end)()

interface:Show()