local O00OO0O0O000O0OOO = game:GetService("Players")
local O00000000O0OO0OO0 = game:GetService("UserInputService")
local OOO0O000O00O0O0O0 = game:GetService("RunService")
local O0OOO0000O0O0O00O = O00OO0O0O000O0OOO.LocalPlayer
local O00OOO0O000000OOO = nil
local OOO0OOO00O0O000O0 = true

local O0OOO00OO0O0OO0O0 = {
    ["\72\111\109\101"] = CFrame.new(146.552, 18.5, -297.112),
    ["\65\119\97\121"] = CFrame.new(-146.261, 18.5, -297.368)
}

local function O0O0O0O0OO0O000O0()
    local O000OO000O000O0O0 = O0OOO0000O0O0O00O.Team and O0OOO0000O0O0O00O.Team.Name or "\78\101\117\116\114\97\108"
    warn("\68\101\116\101\99\116\101\100\32\84\101\97\109\58\32" .. O000OO000O000O0O0)
    return O000OO000O000O0O0
end

local function O0O0O0OOO0O0O0000()
    local O0O0OOO0O0O00000O = O0O0O0O0OO0O000O0()
    local O0O0OOO0O00O0OO0 = nil

    if O0O0OOO0O0O00000O == "\72\111\109\101" then
        O0O0OOO0O00O0OO0 = O0OOO00OO0O0OO0O0["\65\119\97\121"]
    elseif O0O0OOO0O0O00000O == "\65\119\97\121" then
        O0O0OOO0O00O0OO0 = O0OOO00OO0O0OO0O0["\72\111\109\101"]
    end

    if O0O0OOO0O00O0OO0 then
        warn("\84\97\114\103\101\116\32\82\105\110\103\58\32" .. tostring(O0O0OOO0O00O0OO0.Position))
    else
        warn("\78\111\32\115\112\101\99\105\102\105\99\32\114\105\110\103\32\97\115\115\105\103\110\101\100\32\102\111\114\32\116\101\97\109\58\32" .. O0O0OOO0O0O00000O .. ", \100\101\102\97\117\108\116\105\110\103\32\116\111\32\72\111\109\101\32\116\97\114\103\101\116.")
        O0O0OOO0O00O0OO0 = O0OOO00OO0O0OO0O0["\65\119\97\121"]
    end
    return O0O0OOO0O00O0OO0
end

local function O0O0O00O0000OO0O0(O0O0OOO00O0OO00OO)
    if not OOO0OOO00O0O000O0 or not O0O0OOO00O0OO00OO then return end
    local O0O00000O00OO0O0O = O0O0O0OOO0O0O0000()
    if not O0O00000O00OO0O0O then return end

    task.wait(0.2)
    O0O0OOO00O0OO00OO.CFrame = O0O00000O00OO0O0O + Vector3.new(0, -1, 0)
    O0O0OOO00O0OO00OO.Velocity = Vector3.zero
    O0O0OOO00O0OO00OO.AssemblyLinearVelocity = Vector3.zero
    warn("\66\97\108\108\32\116\101\108\101\112\111\114\116\101\100\32\116\111\58\32" .. tostring(O0O00000O00OO0O0O.Position))
end

workspace.ChildAdded:Connect(function(O0OO0000O0O000O00)
    if O0OO0000O0O000O00:IsA("\66\97\115\101\80\97\114\116") and O0OO0000O0O000O00.Name:lower():find("\98\97\108\108") then
        O00OOO0O000000OOO = O0OO0000O0O000O00
        O0O0O00O0000OO0O0(O00OOO0O000000OOO)
    end
end)

O00000000O0OO0OO0.InputBegan:Connect(function(O000O000000O00O0O, O0O000O00OOO0OOO0)
    if O0O000O00OOO0OOO0 then return end
    if O000O000000O00O0O.KeyCode == Enum.KeyCode.Insert then
        OOO0OOO00O0O000O0 = not OOO0OOO00O0O000O0
        warn("\65\105\109\32\65\115\115\105\115\116\58\32" .. (OOO0OOO00O0O000O0 and "\69\110\97\98\108\101\100" or "\68\105\115\97\98\108\101\100"))
    end
end)
