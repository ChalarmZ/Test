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

if LocalPlayer.PlayerGui:FindFirstChild("FoodGui") then
    LocalPlayer.PlayerGui.FoodGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "FoodGui"
gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 500)
frame.Position = UDim2.new(0.5, -130, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -44, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🍖  Pet Food Bot"
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

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 0, 200)
scroll.Position = UDim2.new(0, 8, 0, 78)
scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = scroll

local pad0 = Instance.new("UIPadding")
pad0.PaddingTop = UDim.new(0, 4)
pad0.PaddingLeft = UDim.new(0, 4)
pad0.PaddingRight = UDim.new(0, 4)
pad0.Parent = scroll

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -10, 0, 22)
status.Position = UDim2.new(0, 5, 0, 284)
status.Text = "พร้อมใช้งาน"
status.TextColor3 = Color3.fromRGB(0, 255, 128)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -16, 0, 42)
btn.Position = UDim2.new(0, 8, 0, 312)
btn.Text = "▶  เริ่มให้อาหาร"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.BorderSizePixel = 0
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

local progressLabel = Instance.new("TextLabel")
progressLabel.Size = UDim2.new(1, -10, 0, 20)
progressLabel.Position = UDim2.new(0, 5, 0, 362)
progressLabel.Text = "🔒 Lock Progress: ปิดอยู่"
progressLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
progressLabel.BackgroundTransparency = 1
progressLabel.Font = Enum.Font.Gotham
progressLabel.TextScaled = true
progressLabel.Parent = frame

local lockBtn = Instance.new("TextButton")
lockBtn.Size = UDim2.new(1, -16, 0, 42)
lockBtn.Position = UDim2.new(0, 8, 0, 388)
lockBtn.Text = "🔒  Lock Progress 75%"
lockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
lockBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
lockBtn.Font = Enum.Font.GothamBold
lockBtn.TextScaled = true
lockBtn.BorderSizePixel = 0
lockBtn.Parent = frame
Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 8)

local catchLabel = Instance.new("TextLabel")
catchLabel.Size = UDim2.new(1, -10, 0, 20)
catchLabel.Position = UDim2.new(0, 5, 0, 438)
catchLabel.Text = "🐾 Auto Catch: ปิดอยู่"
catchLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
catchLabel.BackgroundTransparency = 1
catchLabel.Font = Enum.Font.Gotham
catchLabel.TextScaled = true
catchLabel.Parent = frame

local catchBtn = Instance.new("TextButton")
catchBtn.Size = UDim2.new(1, -16, 0, 42)
catchBtn.Position = UDim2.new(0, 8, 0, 458)
catchBtn.Text = "🐾  Auto Catch Pet"
catchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
catchBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 0)
catchBtn.Font = Enum.Font.GothamBold
catchBtn.TextScaled = true
catchBtn.BorderSizePixel = 0
catchBtn.Parent = frame
Instance.new("UICorner", catchBtn).CornerRadius = UDim.new(0, 8)

-- ========== LOGIC ==========
local checkboxes = {}
local running = false
local closed = false
local connections = {}
local lockRunning = false
local catchRunning = false

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateProgress = Remotes:WaitForChild("UpdateProgress")
local ThrowLasso = Remotes:WaitForChild("ThrowLasso")
local minigameRequest = Remotes:WaitForChild("minigameRequest")
local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

local function getDisplayName(v1)
    local name = v1:GetAttribute("Name")
    if name and type(name) == "string" and name ~= "" then
        return name
    end
    return v1.Name:sub(1, 8) .. "..."
end

local function loadPets()
    if closed then return end
    for _, c in next, scroll:GetChildren() do
        if c:IsA("TextButton") then c:Destroy() end
    end
    local prevSelected = {}
    for petName, data in next, checkboxes do
        prevSelected[petName] = data.selected
    end
    checkboxes = {}
    local count = 0
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _, v1 in next, v.Pets:GetChildren() do
                count = count + 1
                local petName = v1.Name
                local displayName = getDisplayName(v1)
                local rarity = v1:GetAttribute("Rarity") or ""
                local isSelected = prevSelected[petName]
                if isSelected == nil then isSelected = true end

                local cb = Instance.new("TextButton")
                cb.Size = UDim2.new(1, 0, 0, 30)
                cb.BackgroundColor3 = isSelected and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(35, 35, 35)
                cb.Text = (isSelected and "✅  " or "⬜  ") .. displayName .. (rarity ~= "" and "  [" .. rarity .. "]" or "")
                cb.TextColor3 = Color3.fromRGB(255, 255, 255)
                cb.Font = Enum.Font.Gotham
                cb.TextScaled = true
                cb.BorderSizePixel = 0
                cb.TextXAlignment = Enum.TextXAlignment.Left
                cb.Parent = scroll
                Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 6)
                local pad = Instance.new("UIPadding")
                pad.PaddingLeft = UDim.new(0, 8)
                pad.Parent = cb
                checkboxes[petName] = { btn = cb, selected = isSelected, obj = v1 }
                cb.MouseButton1Click:Connect(function()
                    local data = checkboxes[petName]
                    if not data then return end
                    data.selected = not data.selected
                    if data.selected then
                        cb.Text = "✅  " .. displayName .. (rarity ~= "" and "  [" .. rarity .. "]" or "")
                        cb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    else
                        cb.Text = "⬜  " .. displayName .. (rarity ~= "" and "  [" .. rarity .. "]" or "")
                        cb.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    end
                end)
            end
        end
    end
    scroll.CanvasSize = UDim2.new(0, 0, 0, count * 34 + 8)
    if not running then status.Text = "พบ " .. count .. " pets" end
end

local function setupAutoRefresh()
    for _, c in next, connections do c:Disconnect() end
    connections = {}
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            table.insert(connections, v.Pets.ChildAdded:Connect(function()
                task.wait(0.5) loadPets()
            end))
            table.insert(connections, v.Pets.ChildRemoved:Connect(function()
                task.wait(0.1) loadPets()
            end))
        end
    end
end

loadPets()
setupAutoRefresh()

selectAllBtn.MouseButton1Click:Connect(function()
    for petName, data in next, checkboxes do
        data.selected = true
        local displayName = getDisplayName(data.obj)
        local rarity = data.obj:GetAttribute("Rarity") or ""
        data.btn.Text = "✅  " .. displayName .. (rarity ~= "" and "  [" .. rarity .. "]" or "")
        data.btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

deselectAllBtn.MouseButton1Click:Connect(function()
    for petName, data in next, checkboxes do
        data.selected = false
        local displayName = getDisplayName(data.obj)
        local rarity = data.obj:GetAttribute("Rarity") or ""
        data.btn.Text = "⬜  " .. displayName .. (rarity ~= "" and "  [" .. rarity .. "]" or "")
        data.btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    closed = true
    lockRunning = false
    catchRunning = false
    for _, c in next, connections do c:Disconnect() end
    gui:Destroy()
end)

btn.MouseButton1Click:Connect(function()
    if running or closed then return end
    running = true
    btn.Text = "⏳  กำลังให้อาหาร..."
    btn.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
    local count = 0
    for _, v2 in next, Foods do
        if closed then break end
        for petName, data in next, checkboxes do
            if closed then break end
            if data.selected then
                pcall(function()
                    ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, petName, 0/0)
                end)
                count = count + 1
                if not closed then
                    status.Text = v2 .. " → " .. getDisplayName(data.obj)
                end
                task.wait(0.05)
            end
        end
    end
    if not closed then
        status.Text = "✅ เสร็จแล้ว! (" .. count .. " ครั้ง)"
        btn.Text = "▶  เริ่มให้อาหาร"
        btn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        running = false
    end
end)

lockBtn.MouseButton1Click:Connect(function()
    if closed then return end
    lockRunning = not lockRunning
    if lockRunning then
        lockBtn.Text = "🔓  หยุด Lock Progress"
        lockBtn.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
        progressLabel.Text = "🔒 Lock Progress: 75% กำลังทำงาน"
        progressLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
        task.spawn(function()
            while lockRunning and not closed do
                pcall(function()
                    UpdateProgress:FireServer(75)
                end)
                task.wait(1)
            end
        end)
    else
        lockBtn.Text = "🔒  Lock Progress 75%"
        lockBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
        progressLabel.Text = "🔒 Lock Progress: ปิดอยู่"
        progressLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)

catchBtn.MouseButton1Click:Connect(function()
    if closed then return end
    catchRunning = not catchRunning
    if catchRunning then
        catchBtn.Text = "⏹  หยุด Auto Catch"
        catchBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        catchLabel.Text = "🐾 Auto Catch: กำลังทำงาน"
        catchLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
        task.spawn(function()
            while catchRunning and not closed do
                local pets = petsFolder:GetChildren()
                if #pets == 0 then
                    catchLabel.Text = "🐾 รอ pet spawn..."
                    task.wait(1)
                    continue
                end
                for _, pet in next, pets do
                    if not catchRunning or closed then break end

                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local humanoid = char and char:FindFirstChild("Humanoid")
                    if not hrp or not humanoid then task.wait(1) continue end

                    local petCF = pet:GetPivot()
                    local targetPos = (petCF * CFrame.new(0, 0, 4)).Position
                    local petName = pet:GetAttribute("Name") or pet.Name:sub(1, 8)

                    catchLabel.Text = "🚶 เดินไปหา " .. petName

                    -- เดินไปหา pet
                    humanoid:MoveTo(targetPos)

                    -- รอจนถึงหรือ timeout 10 วิ
                    local t = 0
                    while t < 10 do
                        if not catchRunning or closed then break end
                        if (hrp.Position - targetPos).Magnitude < 6 then break end
                        task.wait(0.1)
                        t += 0.1
                    end

                    if not catchRunning or closed then break end

                    catchLabel.Text = "🎯 จับ " .. petName

                    local dir = (petCF.Position - hrp.Position).Unit

                    pcall(function()
                        ThrowLasso:FireServer(0.9, dir)
                    end)
                    task.wait(0.3)

                    pcall(function()
                        minigameRequest:InvokeServer(pet, petCF)
                    end)
                    task.wait(0.3)

                    -- UpdateProgress 75 แยก thread ไม่บล็อก loop
                    task.spawn(function()
                        for _ = 1, 10 do
                            if not catchRunning or closed then break end
                            pcall(function()
                                UpdateProgress:FireServer(75)
                            end)
                            task.wait(1)
                        end
                    end)

                    task.wait(0.5)
                end
            end
        end)
    else
        catchBtn.Text = "🐾  Auto Catch Pet"
        catchBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 0)
        catchLabel.Text = "🐾 Auto Catch: ปิดอยู่"
        catchLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)
