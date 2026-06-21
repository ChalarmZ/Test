local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Foods = {"Banana","Cave Mushroom","Cosmic Fruit","Volcanic Fruit","Heart Chocolate","Bloodmoon Grape","Tuna Fish","Dog Treat","Taco","Alien Fruit","Chocolate Egg","Radioactive Strawberry","Cotton Candy","Waffle","Star","Bag Of Worms","Pepper","Abyss Crystal","Steak","Rocky Cookie"}

if LocalPlayer.PlayerGui:FindFirstChild("FoodGui") then LocalPlayer.PlayerGui.FoodGui:Destroy() end

local gui = Instance.new("ScreenGui"); gui.ResetOnSpawn = false; gui.Name = "FoodGui"; gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame"); frame.Size = UDim2.new(0,260,0,540); frame.Position = UDim2.new(0.5,-130,0.5,-270); frame.BackgroundColor3 = Color3.fromRGB(25,25,25); frame.BorderSizePixel = 0; frame.Active = true; frame.Draggable = true; frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local function makeLabel(text, pos, color)
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,-10,0,22); l.Position = pos; l.Text = text; l.TextColor3 = color or Color3.fromRGB(180,180,180); l.BackgroundTransparency = 1; l.Font = Enum.Font.Gotham; l.TextScaled = true; l.Parent = frame; return l
end
local function makeBtn(text, pos, size, color)
    local b = Instance.new("TextButton"); b.Size = size; b.Position = pos; b.Text = text; b.TextColor3 = Color3.fromRGB(255,255,255); b.BackgroundColor3 = color; b.Font = Enum.Font.GothamBold; b.TextScaled = true; b.BorderSizePixel = 0; b.Parent = frame
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8); return b
end

local titleL = Instance.new("TextLabel"); titleL.Size = UDim2.new(1,-44,0,38); titleL.BackgroundColor3 = Color3.fromRGB(40,40,40); titleL.Text = "🍖  Pet Food Bot"; titleL.TextColor3 = Color3.fromRGB(255,255,255); titleL.Font = Enum.Font.GothamBold; titleL.TextScaled = true; titleL.BorderSizePixel = 0; titleL.Parent = frame
Instance.new("UICorner", titleL).CornerRadius = UDim.new(0,12)

local closeBtn  = makeBtn("✖",             UDim2.new(1,-40,0,1),    UDim2.new(0,36,0,36),  Color3.fromRGB(200,50,50))
local selAllBtn = makeBtn("✅ เลือกทั้งหมด", UDim2.new(0,8,0,44),     UDim2.new(0.48,0,0,28),Color3.fromRGB(50,130,50))
local deselBtn  = makeBtn("❌ ยกเลิกทั้งหมด",UDim2.new(0.52,-8,0,44), UDim2.new(0.48,0,0,28),Color3.fromRGB(130,50,50))

local scroll = Instance.new("ScrollingFrame"); scroll.Size = UDim2.new(1,-16,0,200); scroll.Position = UDim2.new(0,8,0,78); scroll.BackgroundColor3 = Color3.fromRGB(35,35,35); scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 4; scroll.CanvasSize = UDim2.new(0,0,0,0); scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0,8)
local ll = Instance.new("UIListLayout"); ll.Padding = UDim.new(0,4); ll.Parent = scroll
local pp = Instance.new("UIPadding"); pp.PaddingTop = UDim.new(0,4); pp.PaddingLeft = UDim.new(0,4); pp.PaddingRight = UDim.new(0,4); pp.Parent = scroll

local statusL   = makeLabel("พร้อมใช้งาน",             UDim2.new(0,5,0,284), Color3.fromRGB(0,255,128))
local foodBtn   = makeBtn("▶  เริ่มให้อาหาร",           UDim2.new(0,8,0,312),  UDim2.new(1,-16,0,42), Color3.fromRGB(0,180,80))
local progLabel = makeLabel("🔒 Lock Progress: ปิดอยู่", UDim2.new(0,5,0,362))
local lockBtn   = makeBtn("🔒  Lock Progress 75%",      UDim2.new(0,8,0,388),  UDim2.new(1,-16,0,42), Color3.fromRGB(80,80,180))

-- ========== RARITY SELECTOR ==========
makeLabel("🎯 Catch Rarity:", UDim2.new(0,5,0,436), Color3.fromRGB(200,200,200))

local Rarities = {"Common", "Divine"}
local rarityColors = {Common = Color3.fromRGB(150,150,150), Divine = Color3.fromRGB(80,220,220)}
local selectedRarities = {Common = false, Divine = false}
local rarityBtns = {}

local rarityRow = Instance.new("Frame"); rarityRow.Size = UDim2.new(1,-16,0,44); rarityRow.Position = UDim2.new(0,8,0,458); rarityRow.BackgroundTransparency = 1; rarityRow.Parent = frame
local rll = Instance.new("UIListLayout"); rll.FillDirection = Enum.FillDirection.Horizontal; rll.Padding = UDim.new(0,6); rll.Parent = rarityRow

for _, rarity in next, Rarities do
    local rb = Instance.new("TextButton"); rb.Size = UDim2.new(0,116,0,44); rb.BackgroundColor3 = Color3.fromRGB(50,50,50); rb.Text = rarity; rb.TextColor3 = rarityColors[rarity]; rb.Font = Enum.Font.GothamBold; rb.TextScaled = true; rb.BorderSizePixel = 0; rb.Parent = rarityRow
    Instance.new("UICorner", rb).CornerRadius = UDim.new(0,8)
    rarityBtns[rarity] = rb
    rb.MouseButton1Click:Connect(function()
        selectedRarities[rarity] = not selectedRarities[rarity]
        rb.BackgroundColor3 = selectedRarities[rarity] and rarityColors[rarity] or Color3.fromRGB(50,50,50)
        rb.TextColor3 = selectedRarities[rarity] and Color3.fromRGB(255,255,255) or rarityColors[rarity]
    end)
end

local catchLabel = makeLabel("🐾 Auto Catch: ปิดอยู่", UDim2.new(0,5,0,508))
local catchBtn   = makeBtn("🐾  Auto Catch Pet",        UDim2.new(0,8,0,508), UDim2.new(1,-16,0,42), Color3.fromRGB(180,120,0))
catchLabel.Position = UDim2.new(0,5,0,504)
catchBtn.Position = UDim2.new(0,8,0,492)

-- ========== LOGIC ==========
local checkboxes, connections = {}, {}
local running, closed, lockRunning, catchRunning = false, false, false, false
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateProgress = Remotes:WaitForChild("UpdateProgress")
local ThrowLasso = Remotes:WaitForChild("ThrowLasso")
local minigameRequest = Remotes:WaitForChild("minigameRequest")
local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

local function getDisplayName(v1)
    local n = v1:GetAttribute("Name"); return (n and n ~= "") and n or v1.Name:sub(1,8).."..."
end

local function loadPets()
    if closed then return end
    for _, c in next, scroll:GetChildren() do if c:IsA("TextButton") then c:Destroy() end end
    local prev = {}; for k, d in next, checkboxes do prev[k] = d.selected end
    checkboxes = {}; local count = 0
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _, v1 in next, v.Pets:GetChildren() do
                count += 1
                local id = v1.Name; local dn = getDisplayName(v1); local rar = v1:GetAttribute("Rarity") or ""
                local sel = prev[id]; if sel == nil then sel = true end
                local cb = Instance.new("TextButton"); cb.Size = UDim2.new(1,0,0,30); cb.BackgroundColor3 = sel and Color3.fromRGB(50,50,50) or Color3.fromRGB(35,35,35); cb.Text = (sel and "✅  " or "⬜  ")..dn..(rar~="" and "  ["..rar.."]" or ""); cb.TextColor3 = Color3.fromRGB(255,255,255); cb.Font = Enum.Font.Gotham; cb.TextScaled = true; cb.BorderSizePixel = 0; cb.TextXAlignment = Enum.TextXAlignment.Left; cb.Parent = scroll
                Instance.new("UICorner", cb).CornerRadius = UDim.new(0,6)
                local p = Instance.new("UIPadding"); p.PaddingLeft = UDim.new(0,8); p.Parent = cb
                checkboxes[id] = {btn=cb, selected=sel, obj=v1}
                cb.MouseButton1Click:Connect(function()
                    local d = checkboxes[id]; if not d then return end
                    d.selected = not d.selected
                    cb.Text = (d.selected and "✅  " or "⬜  ")..dn..(rar~="" and "  ["..rar.."]" or "")
                    cb.BackgroundColor3 = d.selected and Color3.fromRGB(50,50,50) or Color3.fromRGB(35,35,35)
                end)
            end
        end
    end
    scroll.CanvasSize = UDim2.new(0,0,0,count*34+8)
    if not running then statusL.Text = "พบ "..count.." pets" end
end

local function setupAutoRefresh()
    for _, c in next, connections do c:Disconnect() end; connections = {}
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            table.insert(connections, v.Pets.ChildAdded:Connect(function() task.wait(0.5); loadPets() end))
            table.insert(connections, v.Pets.ChildRemoved:Connect(function() task.wait(0.1); loadPets() end))
        end
    end
end

loadPets(); setupAutoRefresh()

selAllBtn.MouseButton1Click:Connect(function()
    for id, d in next, checkboxes do local dn=getDisplayName(d.obj); local r=d.obj:GetAttribute("Rarity") or ""; d.selected=true; d.btn.Text="✅  "..dn..(r~="" and "  ["..r.."]" or ""); d.btn.BackgroundColor3=Color3.fromRGB(50,50,50) end
end)
deselBtn.MouseButton1Click:Connect(function()
    for id, d in next, checkboxes do local dn=getDisplayName(d.obj); local r=d.obj:GetAttribute("Rarity") or ""; d.selected=false; d.btn.Text="⬜  "..dn..(r~="" and "  ["..r.."]" or ""); d.btn.BackgroundColor3=Color3.fromRGB(35,35,35) end
end)
closeBtn.MouseButton1Click:Connect(function()
    closed=true; lockRunning=false; catchRunning=false
    for _, c in next, connections do c:Disconnect() end; gui:Destroy()
end)

foodBtn.MouseButton1Click:Connect(function()
    if running or closed then return end
    running=true; foodBtn.Text="⏳  กำลังให้อาหาร..."; foodBtn.BackgroundColor3=Color3.fromRGB(180,100,0)
    local count=0
    for _, v2 in next, Foods do
        if closed then break end
        for id, d in next, checkboxes do
            if closed then break end
            if d.selected then
                pcall(function() ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, id, 0/0) end)
                count+=1; if not closed then statusL.Text=v2.." → "..getDisplayName(d.obj) end
                task.wait(0.05)
            end
        end
    end
    if not closed then statusL.Text="✅ เสร็จ! ("..count.." ครั้ง)"; foodBtn.Text="▶  เริ่มให้อาหาร"; foodBtn.BackgroundColor3=Color3.fromRGB(0,180,80); running=false end
end)

lockBtn.MouseButton1Click:Connect(function()
    if closed then return end
    lockRunning = not lockRunning
    if lockRunning then
        lockBtn.Text="🔓  หยุด Lock Progress"; lockBtn.BackgroundColor3=Color3.fromRGB(180,100,0)
        progLabel.Text="🔒 Lock Progress: 75% ทำงาน"; progLabel.TextColor3=Color3.fromRGB(0,255,128)
        task.spawn(function() while lockRunning and not closed do pcall(function() UpdateProgress:FireServer(75) end); task.wait(1) end end)
    else
        lockBtn.Text="🔒  Lock Progress 75%"; lockBtn.BackgroundColor3=Color3.fromRGB(80,80,180)
        progLabel.Text="🔒 Lock Progress: ปิดอยู่"; progLabel.TextColor3=Color3.fromRGB(180,180,180)
    end
end)

catchBtn.MouseButton1Click:Connect(function()
    if closed then return end
    local anySelected = false
    for _, v in next, selectedRarities do if v then anySelected = true; break end end
    if not anySelected then catchLabel.Text="⚠️ เลือก Rarity ก่อน!"; catchLabel.TextColor3=Color3.fromRGB(255,80,80); return end
    catchRunning = not catchRunning
    if catchRunning then
        catchBtn.Text="⏹  หยุด Auto Catch"; catchBtn.BackgroundColor3=Color3.fromRGB(180,50,50); catchLabel.TextColor3=Color3.fromRGB(0,255,128)
        task.spawn(function()
            while catchRunning and not closed do
                local pets = petsFolder:GetChildren()
                if #pets == 0 then catchLabel.Text="🐾 รอ pet spawn..."; task.wait(1); continue end
                for _, pet in next, pets do
                    if not catchRunning or closed then break end
                    local rar = pet:GetAttribute("Rarity") or ""
                    if not selectedRarities[rar] then continue end
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then task.wait(1); continue end
                    local petCF = pet:GetPivot()
                    local petName = pet:GetAttribute("Name") or pet.Name:sub(1,8)
                    catchLabel.Text="✨ จับ ["..rar.."] "..petName
                    hrp.CFrame = petCF * CFrame.new(0,3,4); task.wait(0.3)
                    local dir = (petCF.Position - hrp.Position).Unit
                    pcall(function() ThrowLasso:FireServer(0.9, dir) end); task.wait(0.3)
                    pcall(function() minigameRequest:InvokeServer(pet, petCF) end)
                    local t = tick()
                    while catchRunning and not closed and pet and pet.Parent do
                        pcall(function() UpdateProgress:FireServer(75) end)
                        task.wait(0.5); if tick()-t > 15 then break end
                    end
                    task.wait(0.3)
                end
                task.wait(0.3)
            end
            if not closed then catchBtn.Text="🐾  Auto Catch Pet"; catchBtn.BackgroundColor3=Color3.fromRGB(180,120,0); catchLabel.Text="🐾 Auto Catch: ปิดอยู่"; catchLabel.TextColor3=Color3.fromRGB(180,180,180) end
        end)
    else
        catchBtn.Text="🐾  Auto Catch Pet"; catchBtn.BackgroundColor3=Color3.fromRGB(180,120,0)
        catchLabel.Text="🐾 Auto Catch: ปิดอยู่"; catchLabel.TextColor3=Color3.fromRGB(180,180,180)
    end
end)
