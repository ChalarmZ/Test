local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Foods = {"Banana","Cave Mushroom","Cosmic Fruit","Volcanic Fruit","Heart Chocolate","Bloodmoon Grape","Tuna Fish","Dog Treat","Taco","Alien Fruit","Chocolate Egg","Radioactive Strawberry","Cotton Candy","Waffle","Star","Bag Of Worms","Pepper","Abyss Crystal","Rocky Cookie","Mango"}

local MutationFoodMap = {
    Dusty        = "Banana",
    Cavern       = "Cave Mushroom",
    Cosmic       = "Cosmic Fruit",
    Volcanic     = "Volcanic Fruit",
    Lovestruck   = "Heart Chocolate",
    Bloodmoon    = "Bloodmoon Grape",
    Clawed       = "Tuna Fish",
    Fluffy       = "Dog Treat",
    Taco         = "Taco",
    Alien        = "Alien Fruit",
    Easter       = "Chocolate Egg",
    Abducted     = "Radioactive Strawberry",
    Candy        = "Cotton Candy",
    ["Steam Punk"] = "Waffle",
    Stary        = "Star",
    Tidal        = "Bag Of Worms",
    Spiced       = "Pepper",
    Void         = "Abyss Crystal",
    Rocky        = "Rocky Cookie",
}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateProgress = Remotes:WaitForChild("UpdateProgress")
local ThrowLasso = Remotes:WaitForChild("ThrowLasso")
local minigameRequest = Remotes:WaitForChild("minigameRequest")
local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

local running, lockRunning, catchRunning, closed = false, false, false, false
local selectedRarities = {Common = false, Divine = false}

local function getDisplayName(v1)
    local n = v1:GetAttribute("Name"); return (n and n ~= "") and n or v1.Name:sub(1,8).."..."
end
local function getMyPets()
    local t = {}
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _, v1 in next, v.Pets:GetChildren() do table.insert(t, v1) end
        end
    end
    return t
end

-- ========== GUI ==========
if LocalPlayer.PlayerGui:FindFirstChild("ChalarmGui") then LocalPlayer.PlayerGui.ChalarmGui:Destroy() end
local gui = Instance.new("ScreenGui"); gui.ResetOnSpawn = false; gui.Name = "ChalarmGui"; gui.Parent = LocalPlayer.PlayerGui

local win = Instance.new("Frame"); win.Size = UDim2.new(0,320,0,480); win.Position = UDim2.new(0.5,-160,0.5,-240); win.BackgroundColor3 = Color3.fromRGB(18,18,28); win.BorderSizePixel = 0; win.Active = true; win.Draggable = true; win.Parent = gui
Instance.new("UICorner", win).CornerRadius = UDim.new(0,10)

local shadow = Instance.new("ImageLabel"); shadow.Size = UDim2.new(1,30,1,30); shadow.Position = UDim2.new(0,-15,0,-15); shadow.BackgroundTransparency = 1; shadow.Image = "rbxassetid://5554236805"; shadow.ImageColor3 = Color3.fromRGB(0,0,0); shadow.ImageTransparency = 0.5; shadow.ScaleType = Enum.ScaleType.Slice; shadow.SliceCenter = Rect.new(23,23,277,277); shadow.ZIndex = 0; shadow.Parent = win

local titlebar = Instance.new("Frame"); titlebar.Size = UDim2.new(1,0,0,40); titlebar.BackgroundColor3 = Color3.fromRGB(25,25,40); titlebar.BorderSizePixel = 0; titlebar.Parent = win
Instance.new("UICorner", titlebar).CornerRadius = UDim.new(0,10)
local titleFix = Instance.new("Frame"); titleFix.Size = UDim2.new(1,0,0,10); titleFix.Position = UDim2.new(0,0,1,-10); titleFix.BackgroundColor3 = Color3.fromRGB(25,25,40); titleFix.BorderSizePixel = 0; titleFix.Parent = titlebar

local icon = Instance.new("TextLabel"); icon.Size = UDim2.new(0,30,0,30); icon.Position = UDim2.new(0,8,0,5); icon.Text = "⚡"; icon.TextScaled = true; icon.BackgroundTransparency = 1; icon.TextColor3 = Color3.fromRGB(100,180,255); icon.Font = Enum.Font.GothamBold; icon.Parent = titlebar
local titleTxt = Instance.new("TextLabel"); titleTxt.Size = UDim2.new(1,-120,1,0); titleTxt.Position = UDim2.new(0,42,0,0); titleTxt.Text = "ChalarmZ"; titleTxt.TextColor3 = Color3.fromRGB(255,255,255); titleTxt.Font = Enum.Font.GothamBold; titleTxt.TextScaled = true; titleTxt.BackgroundTransparency = 1; titleTxt.TextXAlignment = Enum.TextXAlignment.Left; titleTxt.Parent = titlebar

local function makeTitleBtn(pos, color, symbol)
    local b = Instance.new("TextButton"); b.Size = UDim2.new(0,24,0,24); b.Position = pos; b.Text = symbol; b.TextColor3 = Color3.fromRGB(255,255,255); b.BackgroundColor3 = color; b.Font = Enum.Font.GothamBold; b.TextSize = 12; b.BorderSizePixel = 0; b.Parent = titlebar
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0); return b
end
local minBtn  = makeTitleBtn(UDim2.new(1,-86,0,8), Color3.fromRGB(255,189,68), "─")
local maxBtn  = makeTitleBtn(UDim2.new(1,-58,0,8), Color3.fromRGB(39,201,63),  "□")
local closeB  = makeTitleBtn(UDim2.new(1,-30,0,8), Color3.fromRGB(255,95,86),  "✕")

local sidebar = Instance.new("Frame"); sidebar.Size = UDim2.new(0,80,1,-40); sidebar.Position = UDim2.new(0,0,0,40); sidebar.BackgroundColor3 = Color3.fromRGB(22,22,35); sidebar.BorderSizePixel = 0; sidebar.Parent = win
local sideLayout = Instance.new("UIListLayout"); sideLayout.Padding = UDim.new(0,4); sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; sideLayout.Parent = sidebar
local sidePad = Instance.new("UIPadding"); sidePad.PaddingTop = UDim.new(0,8); sidePad.Parent = sidebar

local contentArea = Instance.new("Frame"); contentArea.Size = UDim2.new(1,-88,1,-48); contentArea.Position = UDim2.new(0,84,0,44); contentArea.BackgroundTransparency = 1; contentArea.Parent = win
local divider = Instance.new("Frame"); divider.Size = UDim2.new(0,2,1,-40); divider.Position = UDim2.new(0,80,0,40); divider.BackgroundColor3 = Color3.fromRGB(35,35,55); divider.BorderSizePixel = 0; divider.Parent = win

local tabPages = {}
local tabBtns = {}
local currentTab = nil

local function newTab(icon2, name)
    local btn = Instance.new("TextButton"); btn.Size = UDim2.new(0,68,0,64); btn.BackgroundColor3 = Color3.fromRGB(30,30,48); btn.Text = ""; btn.BorderSizePixel = 0; btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    local ico = Instance.new("TextLabel"); ico.Size = UDim2.new(1,0,0,32); ico.Position = UDim2.new(0,0,0,6); ico.Text = icon2; ico.TextScaled = true; ico.BackgroundTransparency = 1; ico.TextColor3 = Color3.fromRGB(160,160,200); ico.Font = Enum.Font.GothamBold; ico.Parent = btn
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1,0,0,20); lbl.Position = UDim2.new(0,0,0,38); lbl.Text = name; lbl.TextSize = 10; lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.fromRGB(140,140,180); lbl.Font = Enum.Font.Gotham; lbl.Parent = btn

    local page = Instance.new("ScrollingFrame"); page.Size = UDim2.new(1,0,1,0); page.BackgroundTransparency = 1; page.BorderSizePixel = 0; page.ScrollBarThickness = 3; page.CanvasSize = UDim2.new(0,0,0,0); page.Visible = false; page.Parent = contentArea
    local pl = Instance.new("UIListLayout"); pl.Padding = UDim.new(0,8); pl.Parent = page
    local pp2 = Instance.new("UIPadding"); pp2.PaddingTop = UDim.new(0,8); pp2.PaddingLeft = UDim.new(0,4); pp2.PaddingRight = UDim.new(0,8); pp2.Parent = page
    pl.Changed:Connect(function() page.CanvasSize = UDim2.new(0,0,0,pl.AbsoluteContentSize.Y+16) end)

    tabPages[name] = page; tabBtns[name] = {btn=btn, ico=ico, lbl=lbl}
    btn.MouseButton1Click:Connect(function()
        for n, p in next, tabPages do
            p.Visible = false
            tabBtns[n].btn.BackgroundColor3 = Color3.fromRGB(30,30,48)
            tabBtns[n].ico.TextColor3 = Color3.fromRGB(160,160,200)
            tabBtns[n].lbl.TextColor3 = Color3.fromRGB(140,140,180)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(40,40,65)
        ico.TextColor3 = Color3.fromRGB(100,180,255)
        lbl.TextColor3 = Color3.fromRGB(100,180,255)
        currentTab = name
    end)
    return page
end

local function addBtn(page, text, color, fn)
    local b = Instance.new("TextButton"); b.Size = UDim2.new(1,0,0,40); b.BackgroundColor3 = color; b.Text = text; b.TextColor3 = Color3.fromRGB(255,255,255); b.Font = Enum.Font.GothamBold; b.TextScaled = true; b.BorderSizePixel = 0; b.Parent = page
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(fn); return b
end
local function addToggle(page, text, fn)
    local val = false
    local b = Instance.new("TextButton"); b.Size = UDim2.new(1,0,0,40); b.BackgroundColor3 = Color3.fromRGB(40,40,60); b.Text = "⬜  "..text; b.TextColor3 = Color3.fromRGB(200,200,200); b.Font = Enum.Font.GothamBold; b.TextScaled = true; b.BorderSizePixel = 0; b.Parent = page
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(function()
        val = not val
        b.Text = (val and "✅  " or "⬜  ")..text
        b.BackgroundColor3 = val and Color3.fromRGB(0,130,70) or Color3.fromRGB(40,40,60)
        fn(val)
    end); return b
end
local function addStatus(page, text)
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,0,0,28); l.Text = text; l.TextColor3 = Color3.fromRGB(0,220,120); l.BackgroundColor3 = Color3.fromRGB(20,35,25); l.Font = Enum.Font.Gotham; l.TextScaled = true; l.BorderSizePixel = 0; l.Parent = page
    Instance.new("UICorner", l).CornerRadius = UDim.new(0,6); return l
end
local function addLabel(page, text)
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,0,0,22); l.Text = text; l.TextColor3 = Color3.fromRGB(140,140,180); l.BackgroundTransparency = 1; l.Font = Enum.Font.GothamBold; l.TextSize = 12; l.BorderSizePixel = 0; l.Parent = page; return l
end

-- ========== TAB: Feed ==========
local feedPage = newTab("🍖", "Feed")
addLabel(feedPage, "Feed Pet (ข้าม Mutation ที่ติดแล้ว)")
local feedStatus = addStatus(feedPage, "พร้อมใช้งาน")
addBtn(feedPage, "▶  เริ่มให้อาหาร", Color3.fromRGB(0,150,80), function()
    if running then return end
    running = true; feedStatus.Text = "⏳ กำลังทำงาน..."
    local myPets = getMyPets()
    if #myPets == 0 then running=false; feedStatus.Text="ไม่พบ pet"; return end
    task.spawn(function()
        local total = 0
        local skipped = 0
        for _, v2 in next, Foods do
            if not running then break end
            for i = 1, 20 do
                if not running then break end
                for _, v1 in next, myPets do
                    if not running then break end

                    -- เช็ค mutation ถ้าตรงกับอาหารนี้ให้ข้ามเลย
                    local mutation = v1:GetAttribute("Mutation") or ""
                    local blockedFood = MutationFoodMap[mutation]
                    if blockedFood == v2 then
                        skipped += 1
                        feedStatus.Text = "⏭ ข้าม "..v2.." → "..getDisplayName(v1)
                        task.wait()
                        continue
                    end

                    pcall(function() ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, v1.Name, 0/0) end)
                    total+=1; feedStatus.Text=v2.." "..i.."/30 → "..getDisplayName(v1); task.wait()
                end
            end
        end
        feedStatus.Text="✅ เสร็จ! ให้ "..total.." | ข้าม "..skipped.." ครั้ง"; running=false
    end)
end)
addBtn(feedPage, "⏹  หยุดให้อาหาร", Color3.fromRGB(160,40,40), function()
    running=false; feedStatus.Text="⏹ หยุดแล้ว"
end)

-- ========== TAB: Lock ==========
local lockPage = newTab("🔒", "Lock")
addLabel(lockPage, "Lock Progress")
local lockStatus = addStatus(lockPage, "ปิดอยู่")
addBtn(lockPage, "🔒  Lock 75% (เปิด)", Color3.fromRGB(60,60,180), function()
    if lockRunning then return end
    lockRunning=true; lockStatus.Text="🔒 กำลัง Lock 75%"
    task.spawn(function()
        while lockRunning do pcall(function() UpdateProgress:FireServer(75) end); task.wait(1) end
    end)
end)
addBtn(lockPage, "🔓  หยุด Lock", Color3.fromRGB(100,60,20), function()
    lockRunning=false; lockStatus.Text="ปิดอยู่"
end)

-- ========== TAB: Catch ==========
local catchPage = newTab("🐾", "Catch")
addLabel(catchPage, "Auto Catch")
local catchStatus = addStatus(catchPage, "ปิดอยู่")
addToggle(catchPage, "Common", function(v) selectedRarities.Common=v end)
addToggle(catchPage, "Divine", function(v) selectedRarities.Divine=v end)
addBtn(catchPage, "🐾  Auto Catch (เปิด)", Color3.fromRGB(150,100,0), function()
    if catchRunning then return end
    local any=false; for _,v in next, selectedRarities do if v then any=true; break end end
    if not any then catchStatus.Text="⚠️ เลือก Rarity ก่อน!"; return end
    catchRunning=true; catchStatus.Text="🐾 กำลังจับ..."
    task.spawn(function()
        while catchRunning do
            local pets=petsFolder:GetChildren()
            if #pets==0 then catchStatus.Text="รอ pet spawn..."; task.wait(1); continue end
            for _, pet in next, pets do
                if not catchRunning then break end
                local rar=pet:GetAttribute("Rarity") or ""
                if not selectedRarities[rar] then continue end
                local hrp=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then task.wait(1); continue end
                local petCF=pet:GetPivot()
                catchStatus.Text="✨ ["..rar.."] "..(pet:GetAttribute("Name") or "?")
                hrp.CFrame=petCF*CFrame.new(0,3,4); task.wait(0.3)
                pcall(function() ThrowLasso:FireServer(0.9,(petCF.Position-hrp.Position).Unit) end); task.wait(0.3)
                pcall(function() minigameRequest:InvokeServer(pet,petCF) end)
                local t=tick()
                while catchRunning and pet and pet.Parent do
                    pcall(function() UpdateProgress:FireServer(75) end)
                    task.wait(0.5); if tick()-t>5 then break end
                end
                task.wait(0.3)
            end
            task.wait(0.3)
        end
        catchStatus.Text="ปิดอยู่"
    end)
end)
addBtn(catchPage, "⏹  หยุด Auto Catch", Color3.fromRGB(160,40,40), function()
    catchRunning=false; catchStatus.Text="ปิดอยู่"
end)

-- ========== CONTROLS ==========
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentArea.Visible = not minimized
    sidebar.Visible = not minimized
    divider.Visible = not minimized
    win.Size = minimized and UDim2.new(0,320,0,40) or UDim2.new(0,320,0,480)
end)
maxBtn.MouseButton1Click:Connect(function()
    win.Size = UDim2.new(0,400,0,560)
    contentArea.Visible = true; sidebar.Visible = true; divider.Visible = true; minimized = false
end)
closeB.MouseButton1Click:Connect(function()
    closed=true; running=false; lockRunning=false; catchRunning=false; gui:Destroy()
end)

tabBtns["Feed"].btn:MouseButton1Click()
