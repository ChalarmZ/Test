local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Foods = {
    "Banana", "Cave Mushroom", "Cosmic Fruit", "Volcanic Fruit",
    "Heart Chocolate", "Bloodmoon Grape", "Tuna Fish", "Dog Treat",
    "Taco", "Alien Fruit", "Chocolate Egg", "Radioactive Strawberry",
    "Cotton Candy", "Waffle", "Star", "Bag Of Worms", "Pepper",
    "Abyss Crystal", "Steak", "Rocky Cookie"
}

-- ========== GUI ==========
if LocalPlayer.PlayerGui:FindFirstChild("FoodGui") then
    LocalPlayer.PlayerGui.FoodGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "FoodGui"
gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 130)
frame.Position = UDim2.new(0.5, -110, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🍖  Pet Food Bot"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BorderSizePixel = 0
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -10, 0, 25)
status.Position = UDim2.new(0, 5, 0, 43)
status.Text = "พร้อมใช้งาน"
status.TextColor3 = Color3.fromRGB(0, 255, 128)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -20, 0, 38)
btn.Position = UDim2.new(0, 10, 0, 82)
btn.Text = "▶  เริ่มให้อาหาร"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.BorderSizePixel = 0
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

-- ========== LOGIC ==========
local running = false

btn.MouseButton1Click:Connect(function()
    if running then return end
    running = true
    btn.Text = "⏳  กำลังให้อาหาร..."
    btn.BackgroundColor3 = Color3.fromRGB(180, 100, 0)

    local count = 0
    for _, v2 in next, Foods do
        for _, v in next, workspace.PlayerPens:GetChildren() do
            if v:GetAttribute("Owner") == LocalPlayer.Name then
                for _, v1 in next, v.Pets:GetChildren() do
                    pcall(function()
                        ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, v1.Name, 0/0)
                    end)
                    count = count + 1
                    status.Text = v2 .. " → " .. v1.Name
                    task.wait(0.05)
                end
            end
        end
    end

    status.Text = "✅ เสร็จแล้ว! (" .. count .. " ครั้ง)"
    btn.Text = "▶  เริ่มให้อาหาร"
    btn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    running = false
end)
