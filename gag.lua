local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Foods = {
    "Bamboo"
}

local LocalPlayer = Players.LocalPlayer

    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _,v1 in next, v.Pets:GetChildren() do 
                ReplicatedStorage.SharedModules.Packet.RemoteEvent(v1.name, 9999)
            end 
        end
    end
