local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.wait(1)

local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets", 10)

if not petsFolder then
    warn("ไม่เจอ RoamingPets/Pets")
    return
end

if LocalPlayer.PlayerGui:FindFirstChild("AttrGui") then
    LocalPlayer.PlayerGui.AttrGui:Destroy()
end

task.wait(0.1)

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
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0, 0, 0, 2000)
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 2)
list.Parent = scroll

local function addLabel(text, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -8, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = scroll
end

local pets = petsFolder:GetChildren()
addLabel("พบ " .. #pets .. " pets", Color3.fromRGB(0, 255, 128))

if #pets == 0 then
    addLabel("❌ ไม่มี pet ใน RoamingPets", Color3.fromRGB(255, 80, 80))
else
    for i, pet in next, pets do
        addLabel("── Pet " .. i .. ": " .. pet.Name:sub(1,20), Color3.fromRGB(255, 200, 0))
        local attrs = pet:GetAttributes()
        local count = 0
        for k, v in next, attrs do
            addLabel("   " .. k .. " = " .. tostring(v), Color3.fromRGB(180, 255, 180))
            count += 1
        end
        if count == 0 then
            addLabel("   (ไม่มี attribute)", Color3.fromRGB(150, 150, 150))
        end
    end
end
