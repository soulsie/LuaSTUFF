-- Old project I was hired in

--[[
Notes:

If you find various parts of the code that are ugly then yk that my code is shit so don't mention it
I usually love to make a lot of toggle checks but I broke that rule here (idk why) 
If you find bugs then its usually because this script hasn't been tested out since atleast 2-3 months

Current State:

Status: Outdated
Version: Unknown
Specialty: True Desync that uses Anchored Humaniod with moving CFrame (Based on the Player's move direction) to delay the serverside position which is hard to resolve using the default method

Inaccuracies:
1) It can be easily resolved if the target recalls his resolving method
2) Its inaccurate when the player is standing still since the CFrame is based on the Player's move direction


Credits: @loris1337(786836423176224768) for true desync @pyt3(1018385268413317240) for the rest of the script 
]]
-- hello, please ignore my toggle checks. Thanks
getgenv().Settings = {
    TrueDesync = {
        ["Enabled"] = (true),
        ["Keybind"] = (Enum.KeyCode.C),
        ["Delay"] = (0.145)
    },
    VelocityDesync = {
        --// of course this is much less accurate
        ["Enabled"] = (false),
        ["Keybind"] = (Enum.KeyCode.X),
        ["Velocity"] = {
            ["X"] = (0),
            ["Y"] = (0),
            ["Z"] = (-1)
        }
    },
    Visuals = {
        Trail = {
            ["Enabled"] = (true),
            ["Keybind"] = (Enum.KeyCode.Y),
            ["Color"] = Color3.fromRGB(0, 0, 0)
        },
        AimViewer = {
            ["Enabled"] = (false),
            ["Keybind"] = (Enum.KeyCode.Z),
            ["Color"] = Color3.fromRGB(255, 255, 255)
        }
    }
}
loadstring(game:HttpGet("http://raw.soulsie.xyz/LuaSTUFF/main/Anti-Cheat%20Bypasser.lua"))()
-- Global variables
local RunService = game:GetService("RunService")
local LocalNigger = game.Players.LocalPlayer
local NiggerMouse = LocalNigger:GetMouse()
local NiggerCamera = game:GetService("Workspace").CurrentCamera
local CurrentAVTarget = nil

-- Script variables
local Desync = getgenv().Settings
local Enabled = Desync.TrueDesync.Enabled
local stat = false
local NotificationLibrary =
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AbstractPoo/Main/main/Notifications.lua"))()

game:GetService("UserInputService").InputBegan:Connect(
    function(keybind, processed)
        if keybind.KeyCode == getgenv().Settings.TrueDesync.Keybind and processed == false then
            Enabled = not Enabled
            NotificationLibrary:notify {
                Title = "Desync",
                Description = tostring(Enabled),
                Icon = 6023426926
            }
        end
    end
)

spawn(
    function()
        while wait() do
            stat = true
            task.wait(Desync.TrueDesync.Delay)
            stat = false
        end
    end
)

game.RunService.Heartbeat:Connect(
    function()
        if Enabled then
            local Old = game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame +
                game.Players.LocalPlayer.Character.Humanoid.MoveDirection * 0.029
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = stat
            game.RunService.RenderStepped:Wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = Old
        end
    end
)

local VelEnabled = Desync.VelocityDesync.Enabled

game:GetService("UserInputService").InputBegan:Connect(
    function(vkeybind, velprocessed)
        if vkeybind.KeyCode == Desync.Velocity.Keybind and velprocessed == false then
            VelEnabled = not VelEnabled
            NotificationLibrary:notify {
                Title = "Velocity Desync",
                Description = (tostring(VelEnabled)),
                Icon = 6023426926
            }
        end
    end
)

game:GetService("RunService").heartbeat:Connect(
    function()
        if VelEnabled == true then
            local plrvelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity --// defining the player velocity
            plrvelocity =
                Vector3.new(
                Desync.VelocityDesync.Velocity.X,
                Desync.VelocityDesync.Velocity.Y,
                Desync.VelocityDesync.Velocity.Z
            ) *
                (2 ^ 16) --// setting the player velocity
            game:GetService("RunService").RenderStepped:Wait() --// loop on player movement / render
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = plrvelocity --// looping the velocity change made above
        end
    end
)

local TrailEnabled = Desync.Visuals.Trail.Enabled
game:GetService("UserInputService").InputBegan:Connect(
    function(tkeybind, tprocessed)
        if tkeybind.KeyCode == Desync.Visuals.Trail.Enabled and tprocessed == false then
            TrailEnabled = not TrailEnabled
            NotificationLibrary:notify {
                Title = "Visuals | Trail",
                Description = (tostring(TrailEnabled)),
                Icon = 6023426926
            }
        end
    end
)
if TrailEnabled then
    local Character = game.Players.LocalPlayer.Character
    for i, v in pairs(Character:GetChildren()) do
        if v:IsA("BasePart") then
            local trail = Instance.new("Trail", v)
            trail.Texture = "rbxassetid://1390780157"
            trail.Parent = v
            local attachment0 = Instance.new("Attachment", v)
            attachment0.Name = "TrailAttachment0"
            local attachment1 = Instance.new("Attachment", game.Players.LocalPlayer.Character.HumanoidRootPart)
            attachment1.Name = "TrailAttachment1"
            trail.Attachment0 = attachment0
            trail.Attachment1 = attachment1
            trail.Color = ColorSequence.new(Desync.Visuals.Trail.Color)
        end
    end
end

local Enabled = Desync.Visuals.AimViewer.Enabled
local Color = Desync.Visuals.AimViewer.Color
local Keybind = Desync.Visuals.AimViewer.Keybind

local function OnScreenDistance(Object)
    local ScreenRatio = NiggerCamera:WorldToScreenPoint(Object.Position)
    return ScreenRatio
end

local function FindEquippedGun()
    for i, v in pairs(CurrentAVTarget.Character:GetChildren()) do
        if v and (v:FindFirstChild("Default") or v:FindFirstChild("Handle")) then
            return v
        end
    end
end

local function FindClosestPlayer() -- ik its shit
    local Target = nil
    local Closest = math.huge

    if not Enabled then
        return
    end
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart") then
            if not OnScreenDistance()(v.Character.HumanoidRootPart) then
                return
            end
        end
    end
end

NiggerMouse.KeyDown:Connect(
    function(z)
        if z == Keybind then
            CurrentAVTarget = FindClosestPlayer()
            NotificationLibrary:notify {
                Title = "Visuals | AimViewer",
                Description = "Target: " .. (tostring(CurrentAVTarget.Name)),
                Icon = 6023426926
            }
        end
    end
)

local Tracer = Instance.new("Beam")
    Tracer.Segments = 1
    Tracer.Width0 = 0.2
    Tracer.Width1 = 0.2
    Tracer.Color = ColorSequence.new(Color)
    Tracer.FaceCamera = true
local Attachment = Instance.new("Attachment")
local Attachment1 = Instance.new("Attachment")
    Tracer.Attachment0 = Attachment
    Tracer.Attachment1 = Attachment1
    Tracer.Parent = workspace.Terrain
    Attachment.Parent = workspace.Terrain
    Attachment1.Parent = workspace.Terrain

task.spawn(
    function()
        RunService.RenderStepped:Connect(
            function()
                local character = LocalNigger.Character
                if not character then
                    Tracer.Enabled = false
                    return
                end

                if
                    Enabled and FindEquippedGun() and CurrentAVTarget.Character:FindFirstChild("BodyEffects") and
                        CurrentAVTarget.Character:FindFirstChild("Head")
                 then
                    Tracer.Enabled = true
                    Attachment.Position = CurrentAVTarget.Character:FindFirstChild("Head").Position
                else
                    Tracer.Enabled = false
                end
            end
        )
    end
)
