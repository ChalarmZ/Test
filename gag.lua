local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Foods = {
    "Bamboo"
}

local LocalPlayer = Players.LocalPlayer
    for _,v1 in next, Foods do 
        ReplicatedStorage.SharedModules.Packet.RemoteEvent(v1, 0/0)
    end 
