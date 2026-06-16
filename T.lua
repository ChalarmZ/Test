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
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "FoodGui"
gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.5, -100, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🍖 Pet Food Bot"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

local cornerTitle = Instance.new("UICorner")
cornerTitle.CornerRadius = UDim.new(0, 10)
cornerTitle.Parent = title

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -10, 0, 25)
status.Position = UDim2.new(0, 5, 0, 40)
status.Text = "พร้อมใช้งาน"
status.TextColor3 = Color3.fromRGB(0, 255, 128)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -20, 0, 35)
btn.Position = UDim2.new(0, 10, 0, 75)
btn.Text = "▶ เริ่มให้อาหาร"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = btn

-- drag
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)
frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ========== LOGIC ==========
local running = false

btn.MouseButton1Click:Connect(function()
    if running then return end
    running = true
    btn.Text = "⏳ กำลังให้อาหาร..."
    btn.BackgroundColor3 = Color3.fromRGB(180, 100, 0)

    local petCount = 0
    local foodCount = 0

    for _, v2 in next, Foods do
        for _, v in next, workspace.PlayerPens:GetChildren() do
            if v:GetAttribute("Owner") == LocalPlayer.Name then
                for _, v1 in next, v.Pets:GetChildren() do
                    petCount = petCount + 1
                    local ok = pcall(function()
                        ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, v1.Name, 0/0)
                    end)
                    if ok then foodCount = foodCount + 1 end
                    status.Text = "ให้: " .. v2 .. " | " .. v1.Name
                    task.wait(0.05)
                end
            end
        end
    end

    status.Text = "✅ เสร็จ! (" .. foodCount .. " ครั้ง)"
    btn.Text = "▶ เริ่มให้อาหาร"
    btn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    running = false
end)
