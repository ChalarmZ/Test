local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ลองหา inventory ใน PlayerGui, leaderstats, หรือ character
print("=== PlayerGui ===")
for _, v in next, LocalPlayer.PlayerGui:GetChildren() do
    print(v.Name, v.ClassName)
end

print("=== Character ===")
if LocalPlayer.Character then
    for _, v in next, LocalPlayer.Character:GetChildren() do
        print(v.Name, v.ClassName)
    end
end

print("=== LocalPlayer children ===")
for _, v in next, LocalPlayer:GetChildren() do
    print(v.Name, v.ClassName)
    for _, v2 in next, v:GetChildren() do
        print("  "..v2.Name, v2.ClassName)
    end
end
