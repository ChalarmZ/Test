local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- ========== PRINT SYSTEM ==========
if LocalPlayer.PlayerGui:FindFirstChild("DebugGui") then
    LocalPlayer.PlayerGui.DebugGui:Destroy()
end

local gui2 = Instance.new("ScreenGui")
gui2.ResetOnSpawn = false
gui2.Name = "DebugGui"
gui2.Parent = LocalPlayer.PlayerGui

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
scrollFrame.Position = UDim2.new(0, 0, 0.5, 0)
scrollFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
scrollFrame.BackgroundTransparency = 0.4
scrollFrame.ScrollBarThickness = 4
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = gui2
Instance.new("UIListLayout", scrollFrame)

local lineCount = 0
local function cprint(msg)
    lineCount = lineCount + 1
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 18)
    label.Text = lineCount .. ". " .. tostring(msg)
    label.TextColor3 = Color3.fromRGB(0, 255, 128)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = scrollFrame
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, lineCount * 18)
    scrollFrame.CanvasPosition = Vector2.new(0, lineCount * 18)
end

-- ========== SCAN ==========
for _, v in next, workspace.PlayerPens:GetChildren() do
    if v:GetAttribute("Owner") == LocalPlayer.Name then
        for _, v1 in next, v.Pets:GetChildren() do
            cprint("=== UUID: " .. v1.Name .. " ===")

            -- attributes
            local attrs = v1:GetAttributes()
            local hasAttr = false
            for k, val in next, attrs do
                cprint("  attr: " .. k .. " = " .. tostring(val))
                hasAttr = true
            end
            if not hasAttr then
                cprint("  (ไม่มี attributes)")
            end

            -- children
            for _, child in next, v1:GetChildren() do
                cprint("  child: " .. child.Name .. " [" .. child.ClassName .. "]")
                if child:IsA("StringValue") or child:IsA("IntValue") or child:IsA("BoolValue") or child:IsA("NumberValue") then
                    cprint("    value: " .. tostring(child.Value))
                end
                -- หาก child มี children อีก
                for _, child2 in next, child:GetChildren() do
                    cprint("    child2: " .. child2.Name .. " [" .. child2.ClassName .. "]")
                    if child2:IsA("StringValue") or child2:IsA("IntValue") or child2:IsA("BoolValue") or child2:IsA("NumberValue") then
                        cprint("      value: " .. tostring(child2.Value))
                    end
                end
            end
        end
    end
end

cprint("===== SCAN DONE =====")
