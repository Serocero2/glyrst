local a,b,c,d,e,f=game:GetService("Players"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("Workspace"),nil,true
local g={Home=CFrame.new(146.552,18.5,-297.112),Away=CFrame.new(-146.261,18.5,-297.368)}
local function h()return d.LocalPlayer.Team and d.LocalPlayer.Team.Name or"Neutral"end
local function i()local j=h()local k=nil if j=="Home"then k=g.Away elseif j=="Away"then k=g.Home end return k or g.Away end
local function l(m)if not f or not m then return end local n=i()if not n then return end task.wait(0.2)m.CFrame=n+Vector3.new(0,-1,0)m.Velocity=Vector3.zero m.AssemblyLinearVelocity=Vector3.zero end
d.ChildAdded:Connect(function(o)if o:IsA("BasePart")and o.Name:lower():find("ball")then e=o l(e)end end)
b.InputBegan:Connect(function(p,q)if q then return end if p.KeyCode==Enum.KeyCode.Insert then f=not f end end)
