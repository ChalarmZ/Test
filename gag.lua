local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Foods = {
    "Bamboo"
}

local LocalPlayer = Players.LocalPlayer

for _, v2 in next, Foods do 
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _,v1 in next, v.Pets:GetChildren() do 
                ReplicatedStorage.SharedModules.Packet.RemoteEvent(v2, v1.Name, 0/0)
            end 
        end
    end
end 
