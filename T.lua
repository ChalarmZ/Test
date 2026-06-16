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
frame.Size = UDim2.new(0, 260, 0, 400)
frame.Position = UDim2.new(0.5, -130, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -36, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🍖  Pet Food Bot"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BorderSizePixel = 0
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -36, 0, 3)
closeBtn.Text = "✕"
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
scroll.Size = UDim2.new(1, -16, 0, 220)
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
status.Position = UDim2.new(0, 5, 0, 304)
status.Text = "พร้อมใช้งาน"
status.TextColor3 = Color3.fromRGB(0, 255, 128)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -16, 0, 42)
btn.Position = UDim2.new(0, 8, 0, 332)
btn.Text = "▶  เริ่มให้อาหาร"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.BorderSizePixel = 0
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

-- ========== LOAD PETS ==========
local checkboxes = {}
local running = false
local closed = false
local connections = {}

local function getDisplayName(v1)
    local attrs = {"PetName", "petName", "DisplayName", "Pet", "Type", "pet"}
    for _, attr in next, attrs do
        local val = v1:GetAttribute(attr)
        if val and type(val) == "string" then
            return val
        end
    end
    -- ถ้าไม่มี attribute ตัดเอา uuid ออก ใช้แค่ 8 ตัวแรก
    return v1.Name:sub(1, 8) .. "..."
end

local function loadPets()
    if closed then return end

    for _, c in next, scroll:GetChildren() do
        if c:IsA("TextButton") then c:Destroy() end
    end

    -- เก็บ selected state เดิมไว้
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

                -- ถ้าเคย deselect ไว้ก็ยัง deselect อยู่
                local isSelected = prevSelected[petName]
                if isSelected == nil then isSelected = true end

                local cb = Instance.new("TextButton")
                cb.Size = UDim2.new(1, 0, 0, 30)
                cb.BackgroundColor3 = isSelected and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(35, 35, 35)
                cb.Text = (isSelected and "✅  " or "⬜  ") .. displayName
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
                        cb.Text = "✅  " .. displayName
                        cb.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    else
                        cb.Text = "⬜  " .. displayName
                        cb.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    end
                end)
            end
        end
    end

    scroll.CanvasSize = UDim2.new(0, 0, 0, count * 34 + 8)
    if not running then
        status.Text = "พบ " .. count .. " pets"
    end
end

-- ========== AUTO REFRESH ==========
local function setupAutoRefresh()
    -- disconnect เดิม
    for _, c in next, connections do
        c:Disconnect()
    end
    connections = {}

    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            table.insert(connections, v.Pets.ChildAdded:Connect(function()
                task.wait(0.5)
                loadPets()
            end))
            table.insert(connections, v.Pets.ChildRemoved:Connect(function()
                task.wait(0.1)
                loadPets()
            end))
        end
    end
end

loadPets()
setupAutoRefresh()

-- ========== BUTTONS ==========
selectAllBtn.MouseButton1Click:Connect(function()
    for petName, data in next, checkboxes do
        data.selected = true
        local displayName = getDisplayName(data.obj)
        data.btn.Text = "✅  " .. displayName
        data.btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

deselectAllBtn.MouseButton1Click:Connect(function()
    for petName, data in next, checkboxes do
        data.selected = false
        local displayName = getDisplayName(data.obj)
        data.btn.Text = "⬜  " .. displayName
        data.btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    closed = true
    for _, c in next, connections do
        c:Disconnect()
    end
    gui:Destroy()
end)

-- ========== RUN ==========
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
                    status.Text = v2 .. " → " .. (getDisplayName(data.obj))
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
