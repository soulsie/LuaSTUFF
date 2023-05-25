--[[
Ass method but an unpatched one

just made a toggle for it for now 

Credits: ASOULS#3009 
]]

--// table for easier customizations
getgenv().Settings = {
    ["Enabled"] = (false),
    ["Velocity"] = Vector3.new(3009, 1337, -6900),
    ["Keybind"] = (Enum.KeyCode.M)
}

--// script vars
local COOLNotifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbstractPoo/Main/main/Notifications.lua"))()
local Settings = getgenv().Settings
local Enabled = Settings.Enabled
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

game:GetService("UserInputService").InputBegan:Connect(function(keybind, ison)
    if keybind.KeyCode == Settings.Keybind and ison == false then
        Enabled = not Enabled
        notify(tostring(Enabled))
    end
end
)

while task.wait() do --> this enables the process even if your not knocked (Toggle)
    coroutine.wrap(function()
        if Enabled then
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
