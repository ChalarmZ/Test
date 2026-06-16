local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

if LocalPlayer.PlayerGui:FindFirstChild("AttrGui") then
    LocalPlayer.PlayerGui.AttrGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "AttrGui"
gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 500)
frame.Position = UDim2.new(0.5, -170, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 36)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🔍  Pet Attributes"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BorderSizePixel = 0
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 1, -48)
scroll.Position = UDim2.new(0, 8, 0, 42)
scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 4)
list.Parent = scroll

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 6)
pad.PaddingLeft = UDim.new(0, 6)
pad.PaddingRight = UDim.new(0, 6)
pad.Parent = scroll

local function addLabel(text, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = scroll
    Instance.new("UIPadding", lbl).PaddingLeft = UDim.new(0, 4)
    return lbl
end

local totalLines = 0
local pets = petsFolder:GetChildren()

if #pets == 0 then
    addLabel("❌ ไม่มี pet ใน RoamingPets", Color3.fromRGB(255, 80, 80))
    totalLines = 1
else
    for _, pet in next, pets do
        addLabel("══ " .. pet.Name:sub(1, 20) .. " ══", Color3.fromRGB(255, 200, 0))
        totalLines += 1
        local attrs = pet:GetAttributes()
        local count = 0
        for attrName, attrValue in next, attrs do
            addLabel("  " .. attrName .. " = " .. tostring(attrValue), Color3.fromRGB(180, 255, 180))
            totalLines += 1
            count += 1
        end
        if count == 0 then
            addLabel("  (ไม่มี attribute)", Color3.fromRGB(150, 150, 150))
            totalLines += 1
        end
    end
end

scroll.CanvasSize = UDim2.new(0, 0, 0, totalLines * 26 + 10)
