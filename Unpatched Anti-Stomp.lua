--[[
Ass method but an unpatched one

just made a toggle for it for now 

Credits: ASOULS#3009 
]]

-- ass method. However, unpatched one

-- ass method. However, unpatched one

--// table for easier customizations
getgenv().Settings = {
    ScriptSets = {    
    ["Enabled"] = (false),
    ["Velocity"] = Vector3.new(3009, 1337, -6900),
    ["ToggleKeybind"] = (Enum.KeyCode.M),
    ["ForceKeybind"] = (Enum.KeyCode.T) --> Forces the process even if your not knocked 
    },
    Text = {
        ["Enabled"] = true,
        ["Color"] = Color3.fromRGB(255, 0, 0) or Color3(0, 255, 0),
        ["Size"] = math.random(10, 32),
        ["Position"] = Vector2.new(15, 10)
    },
}

--// script vars
local COOLNotifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbstractPoo/Main/main/Notifications.lua"))()
local Settings = getgenv().Settings.ScriptSets
local TSets = getgenv().Settings.Text
local Enabled = Settings.Enabled

--// Text 
local t = Drawing.new("Text")
t.Text = "Enabled" or "Disabled" 
t.Color = Color3.fromRGB(0, 255, 0) or Color3(255, 0, 0)
t.Size = TSets.Size
t.Outline = true 
t.Visible = TSets.Enabled
--// game vars
local FindPlayer = game:GetService("Players").LocalPlayer
local RootPart = FindPlayer.Character.HumanoidRootPart
local Velocity = RootPart.Velocity

--// kind-of functions
local function notify(Desc)
    COOLNotifications:notify {
        Title = "anti STOMP",
        Description = Desc, 
        Icon = 6023426926,
    }
end

local function UpdateText()
    if Enabled and TSets.Enabled == true then
        t.Text = "Enabled"
        t.Color = Color3.fromRGB(0, 255, 0)
        t.Size = TSets.Size
        t.Position = TSets.Position
    elseif not Enabled then 
        t.Text = "Disabled"
        t.Color = Color3.fromRGB(255, 0, 0)
        t.Size = TSets.Size
        t.Position = TSets.Position
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(keybind, ison)
    if keybind.KeyCode == Settings.ToggleKeybind and ison == false then
        Enabled = not Enabled
        notify(tostring(Enabled))
        UpdateText()
    end
end
)

while task.wait() do --> (Toggle)
    game:GetService("UserInputService").InputBegan:Connect(function(key)
        if key.KeyCode == Settings.ForceKeybind then
            pcall(function()
                local RootPart = RootPart
                local CurrentVelocity = Velocity
                local RunService = game:GetService("RunService")
                RootPart.Velocity = Settings.Velocity
                RunService.RenderStepped:wait()
                RootPart.Velocity = CurrentVelocity
            end)
        end
    end
)
end
pcall(function() --> Detection: Enables the process when your knocked (Health, Name pos compared to char pos)
    for _, Player in pairs(game:GetService("Players"):GetPlayers()) do
        if Player:DistanceFromCharacter(FindPlayer.Character.UpperTorso.Position) <= 5 and Player.Name ~= FindPlayer.Name then --// this uses the player's name distance because when your knocked it changes
            Enabled = true
        else
            Enabled = false
        end
        for _, Health in pairs(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Health) do
        if Health <= 5 then
            Enabled = true 
        else 
            Enabled = false
            end
        end
    end
end
)
