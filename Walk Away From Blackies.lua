-- credits: warlock#0001
-- walk away from black people 
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local blacklist = {"Medium brown","Reddish brown","Brown","CGA brown","Dark orange","Dark taupe"}; --// you can add yellow colors.

local IsBlack = function(Part)
    if table.find(blacklist, tostring(Part.BrickColor)) then
        return true
    else
       return false 
    end
end

task.spawn(function()
    while true and task.wait(0.08) do 
        for i,v in pairs(Players:GetChildren()) do 
            if (v.Character) and (v.Character:FindFirstChildWhichIsA("Humanoid")) then 
                if (IsBlack(v.Character.Head) == true) then
                    if (v.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        if v~=Player then
                            Player.Character.Humanoid:MoveTo(v.Character.HumanoidRootPart.Position - (Player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).unit * -1 * 10.5)
                        end
                    end
                end
            end
        end
    end
end)
