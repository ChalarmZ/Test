local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local rarityCounts = {}

for _, v in next, workspace.PlayerPens:GetChildren() do
    if v:GetAttribute("Owner") == LocalPlayer.Name then
        for _, v1 in next, v.Pets:GetChildren() do
            local name = v1:GetAttribute("Name") or "?"
            local rarity = v1:GetAttribute("Rarity") or "?"
            local key = rarity
            if not rarityCounts[key] then rarityCounts[key] = {} end
            table.insert(rarityCounts[key], name)
        end
    end
end

print("===== RARITY SUMMARY =====")
for rarity, pets in next, rarityCounts do
    print("[" .. rarity .. "] x" .. #pets)
    for _, name in next, pets do
        print("  - " .. name)
    end
end
print("===== END =====")
