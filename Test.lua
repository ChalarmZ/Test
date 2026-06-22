local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

for _, v in next, workspace.PlayerPens:GetChildren() do
    if v:GetAttribute("Owner") == LocalPlayer.Name then
        for _, v1 in next, v.Pets:GetChildren() do
            print("=== "..(v1:GetAttribute("Name") or v1.Name).." ===")
            for k, val in next, v1:GetAttributes() do
                print("  "..k.." = "..tostring(val))
            end
        end
    end
end
