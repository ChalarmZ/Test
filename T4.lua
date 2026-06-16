local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ThrowLasso = Remotes:WaitForChild("ThrowLasso")
local minigameRequest = Remotes:WaitForChild("minigameRequest")
local UpdateProgress = Remotes:WaitForChild("UpdateProgress")

local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

local catching = false
local checkboxes = {}

-- GUI
if LocalPlayer.PlayerGui:FindFirstChild("CatchGui") then
    LocalPlayer.PlayerGui.CatchGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "CatchGui"
gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 480)
frame.Position = UDim2.new(0.5, -130, 0.5, -240)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -44, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🐾  Auto Catch Pet"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BorderSizePixel = 0
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -40, 0, 1)
closeBtn.Text = "✖"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.BorderSizePixel = 0
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Select All / Deselect All
local selectAllBtn = Instance.new("TextButton")
selectAllBtn.Size = UDim2.new(0.48, 0, 0, 28)
selectAllBtn.Position = UDim2.new(0, 8, 0, 44)
selectAllBtn.Text = "✅ เลือกทั้งหมด"
selectAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
selectAllBtn.BackgroundColor3 = Color3.fromRGB(50, 130, 50)
selectAllBtn.Font = Enum.Font.GothamBold
selectAllBtn.TextScaled = true
selectAllBtn.BorderSizePixel = 0
selectAllBtn.Parent = frame
Instance.new("UICorner", selectAllBtn).CornerRadius = UDim.new(0, 6)

local deselectAllBtn = Instance.new("TextButton")
deselectAllBtn.Size = UDim2.new(0.48, 0, 0, 28)
deselectAllBtn.Position = UDim2.new(0.52, -8, 0, 44)
deselectAllBtn.Text = "❌ ยกเลิกทั้งหมด"
deselectAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
deselectAllBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 50)
deselectAllBtn.Font = Enum.Font.GothamBold
deselectAllBtn.TextScaled = true
deselectAllBtn.BorderSizePixel = 0
deselectAllBtn.Parent = frame
Instance.new("UICorner", deselectAllBtn).CornerRadius = UDim.new(0, 6)

-- Refresh
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, -16, 0, 24)
refreshBtn.Position = UDim2.new(0, 8, 0, 78)
refreshBtn.Text = "🔄 Refresh รายการ"
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextScaled = true
refreshBtn.BorderSizePixel = 0
refreshBtn.Parent = frame
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 6)

-- Scroll
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 0, 220)
scroll.Position = UDim2.new(0, 8, 0, 108)
scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = scroll

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 4)
pad.PaddingLeft = UDim.new(0, 4)
pad.PaddingRight = UDim.new(0, 4)
pad.Parent = scroll

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -10, 0, 22)
status.Position = UDim2.new(0, 5, 0, 334)
status.Text = "พร้อมใช้งาน"
status.TextColor3 = Color3.fromRGB(0, 255, 128)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(1, -16, 0, 42)
startBtn.Position = UDim2.new(0, 8, 0, 362)
startBtn.Text = "▶  เริ่ม Auto Catch"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextScaled = true
startBtn.BorderSizePixel = 0
startBtn.Parent = frame
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

-- Load pet list
local function loadPets()
    for _, c in next, scroll:GetChildren() do
        if c:IsA("TextButton") then c:Destroy() end
    end
    checkboxes = {}
    local count = 0

    for _, pet in next, petsFolder:GetChildren() do
        count = count + 1
        local name = pet:GetAttribute("Name") or pet.Name:sub(1, 12)
        local rarity = pet:GetAttribute("Rarity") or ""

        local cb = Instance.new("TextButton")
        cb.Size = UDim2.new(1, 0, 0, 30)
        cb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        cb.Text = "✅  " .. name .. (rarity ~= "" and "  [" .. rarity .. "]" or "")
        cb.TextColor3 = Color3.fromRGB(255, 255, 255)
        cb.Font = Enum.Font.Gotham
        cb.TextScaled = true
        cb.BorderSizePixel = 0
        cb.TextXAlignment = Enum.TextXAlignment.Left
        cb.Parent = scroll
        Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 6)
        local p = Instance.new("UIPadding")
        p.PaddingLeft = UDim.new(0, 8)
        p.Parent = cb

        checkboxes[pet] = { btn = cb, selected = true, obj = pet, displayName = name, rarity = rarity }

        cb.MouseButton1Click:Connect(function()
            local data = checkboxes[pet]
            if not data then return end
            data.selected = not data.selected
            cb.Text = (data.selected and "✅  " or "⬜  ") .. name .. (rarity ~= "" and "  [" .. rarity .. "]" or "")
            cb.BackgroundColor3 = data.selected and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(35, 35, 35)
        end)
    end

    scroll.CanvasSize = UDim2.new(0, 0, 0, count * 34 + 8)
    status.Text = "พบ " .. count .. " pets ใน RoamingPets"
end

-- Catch logic
local function catchPet(pet)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChild("Humanoid")
    if not hrp or not humanoid then return end

    local petCF = pet:GetPivot()
    local targetPos = (petCF * CFrame.new(0, 0, 4)).Position

    humanoid:MoveTo(targetPos)

    local timeout = 10
    local t = 0
    while t < timeout do
        if not catching then return end
        if (hrp.Position - targetPos).Magnitude < 6 then break end
        task.wait(0.1)
        t = t + 0.1
    end

    local dir = (petCF.Position - hrp.Position).Unit

    pcall(function()
        ThrowLasso:FireServer(0.9, dir)
    end)
    task.wait(0.3)

    pcall(function()
        minigameRequest:InvokeServer(pet, petCF)
    end)
    task.wait(0.2)

    task.spawn(function()
        while catching do
            pcall(function()
                UpdateProgress:FireServer(75)
            end)
            task.wait(1)
        end
    end)
end

local function catchSelected()
    local done = 0
    for pet, data in next, checkboxes do
        if not catching then break end
        if data.selected then
            status.Text = "🐾 เดินไปจับ " .. data.displayName .. "..."
            catchPet(pet)
            done = done + 1
            task.wait(0.3)
        end
    end
    if catching then
        status.Text = "✅ จบ! จับไป " .. done .. " ตัว"
        catching = false
        startBtn.Text = "▶  เริ่ม Auto Catch"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    end
end

-- Buttons
refreshBtn.MouseButton1Click:Connect(function()
    loadPets()
end)

selectAllBtn.MouseButton1Click:Connect(function()
    for _, data in next, checkboxes do
        data.selected = true
        data.btn.Text = "✅  " .. data.displayName .. (data.rarity ~= "" and "  [" .. data.rarity .. "]" or "")
        data.btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

deselectAllBtn.MouseButton1Click:Connect(function()
    for _, data in next, checkboxes do
        data.selected = false
        data.btn.Text = "⬜  " .. data.displayName .. (data.rarity ~= "" and "  [" .. data.rarity .. "]" or "")
        data.btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    catching = false
    gui:Destroy()
end)

startBtn.MouseButton1Click:Connect(function()
    catching = not catching
    if catching then
        startBtn.Text = "⏹  หยุด"
        startBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        task.spawn(catchSelected)
    else
        catching = false
        startBtn.Text = "▶  เริ่ม Auto Catch"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        status.Text = "⏹ หยุดแล้ว"
    end
end)

-- โหลดครั้งแรก
loadPets()
