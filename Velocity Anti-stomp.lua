-- ass method. However, unpatched one

--// table for easier customizations
getgenv().Settings = {
    ScriptSets = {    
    ["Enabled"] = (false),
    ["Toggled"] = (false),
    ["Velocity"] = {
        ["X"] = (3009),
        ["Y"] = (1337),
        ["Z"] = (-69)
    },
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
local Settings = getgenv().Settings.ScriptSets
local TSets = getgenv().Settings.Text
local Enabled = Settings.Enabled
local Toggled = Settings.Toggled --> Force toggle var
--// text 
local t = Drawing.new("Text")
t.Text = "Enabled" or "Disabled" 
t.Color = Color3.fromRGB(0, 255, 0) or Color3(255, 0, 0)
t.Size = TSets.Size
t.Outline = true 
t.Visible = TSets.Enabled
--// game vars
local Player = game:GetService("Players").LocalPlayer
local RootPart = Player.Character.HumanoidRootParty
local Velocity = RootPart.Velocity
--// funcs 
local function UpdateText()
    if Enabled or Toggled and TSets.Enabled == true then -- shitty check ik 
        t.Text = "Enabled - Status =  " + tostring(Toggled)
        t.Color = Color3.fromRGB(0, 255, 0)
        t.Size = TSets.Size
        t.Position = TSets.Position
    elseif not Enabled or Toggled and TSets.Enabled == true then 
        t.Text = "Disabled"
        t.Color = Color3.fromRGB(255, 0, 0)
        t.Size = TSets.Size
        t.Position = TSets.Position
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(keybind, ison)
    if keybind.KeyCode == Settings.ToggleKeybind and ison == false then
        Enabled = not Enabled
        UpdateText()
    end
end
)

while task.wait() do --> (Toggle)
    game:GetService("UserInputService").InputBegan:Connect(function(key)
        if key.KeyCode == Settings.ForceKeybind then Toggled = not Toggled
            if Toggled == true then repeat -- so many checks ? ik 
                pcall(function()
                local CurrenVeloctiy = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
                CurrenVeloctiy = Vector3.new(Settings.Velocity.X, Settings.Velocity.Y, Settings.Velocity.Z) * (2^16) 
                game:GetService("RunService").RenderStepped:Wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = CurrenVeloctiy 
            end)
        until Toggled == false
       end
    end
end
)
end
if Enabled == true and Toggled == false then -- yep another Toggled check 
    pcall(function() --> Detection: Enables the process when your knocked (Animations method, Name pos compared to char pos method)
        for _,Player in pairs(game:GetService("Players"):GetPlayers()) do
            if Player:DistanceFromCharacter(Player.Character.UpperTorso.Position) <= 5 and Player.Name ~= Player.Name then --// this uses the player's name distance because when your knocked it changes
                Velocity = Settings.Velocity
            else
                Velocity = Vector3.new(0, 0, 0)
            end
            for _,Health in pairs(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Health) do
            if Health <= 5 then
                Velocity = Settings.Velocity
            else 
                Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end)
end
