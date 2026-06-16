local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- ========== PRINT SYSTEM ==========
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "DebugGui"
gui.Parent = LocalPlayer.PlayerGui

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
scrollFrame.Position = UDim2.new(0, 0, 0.5, 0)
scrollFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
scrollFrame.BackgroundTransparency = 0.4
scrollFrame.ScrollBarThickness = 4
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = gui

local layout = Instance.new("UIListLayout")
layout.Parent = scrollFrame

local lineCount = 0
local function chatPrint(msg)
    lineCount = lineCount + 1
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Text = lineCount .. ". " .. msg
    label.TextColor3 = Color3.fromRGB(0, 255, 128)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = scrollFrame
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, lineCount * 20)
    scrollFrame.CanvasPosition = Vector2.new(0, lineCount * 20)
end

-- ========== FOOD ==========
local Foods = {
    "Banana", "Cave Mushroom", "Cosmic Fruit", "Volcanic Fruit",
    "Heart Chocolate", "Bloodmoon Grape", "Tuna Fish", "Dog Treat",
    "Taco", "Alien Fruit", "Chocolate Egg", "Radioactive Strawberry",
    "Cotton Candy", "Waffle", "Star", "Bag Of Worms", "Pepper",
    "Abyss Crystal", "Steak", "Rocky Cookie"
}

chatPrint("===== FOOD START =====")
for _, v2 in next, Foods do
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _, v1 in next, v.Pets:GetChildren() do
                ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, v1.Name, 0/0)
            end
        end
    end
end
chatPrint("===== FOOD END =====")

-- ========== SCAN REMOTES ==========
chatPrint("===== SCANNING REMOTES =====")
local function scanRemotes(parent, path)
    for _, v in next, parent:GetChildren() do
        local newPath = path .. "." .. v.Name
        if v:IsA("RemoteFunction") or v:IsA("RemoteEvent") then
            chatPrint(newPath)
        end
        if #v:GetChildren() > 0 then
            scanRemotes(v, newPath)
        end
    end
end

scanRemotes(ReplicatedStorage, "RS")
chatPrint("===== SCAN DONE =====")
