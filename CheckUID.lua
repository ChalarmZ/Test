local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if LocalPlayer.PlayerGui:FindFirstChild("RarityGui") then
    LocalPlayer.PlayerGui.RarityGui:Destroy()
end

local gui = Instance.new("ScreenGui"); gui.ResetOnSpawn = false; gui.Name = "RarityGui"; gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame"); frame.Size = UDim2.new(0,320,0,400); frame.Position = UDim2.new(0.5,-160,0.5,-200); frame.BackgroundColor3 = Color3.fromRGB(25,25,25); frame.BorderSizePixel = 0; frame.Active = true; frame.Draggable = true; frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel"); title.Size = UDim2.new(1,-44,0,38); title.BackgroundColor3 = Color3.fromRGB(40,40,40); title.Text = "🔍 Rarity Checker"; title.TextColor3 = Color3.fromRGB(255,255,255); title.Font = Enum.Font.GothamBold; title.TextScaled = true; title.BorderSizePixel = 0; title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

local closeBtn = Instance.new("TextButton"); closeBtn.Size = UDim2.new(0,36,0,36); closeBtn.Position = UDim2.new(1,-40,0,1); closeBtn.Text = "✖"; closeBtn.TextColor3 = Color3.fromRGB(255,255,255); closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50); closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextScaled = true; closeBtn.BorderSizePixel = 0; closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local scroll = Instance.new("ScrollingFrame"); scroll.Size = UDim2.new(1,-16,0,350); scroll.Position = UDim2.new(0,8,0,44); scroll.BackgroundColor3 = Color3.fromRGB(35,35,35); scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 4; scroll.CanvasSize = UDim2.new(0,0,0,0); scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0,8)
local ll = Instance.new("UIListLayout"); ll.Padding = UDim.new(0,4); ll.Parent = scroll
local pp = Instance.new("UIPadding"); pp.PaddingTop = UDim.new(0,4); pp.PaddingLeft = UDim.new(0,4); pp.PaddingRight = UDim.new(0,4); pp.Parent = scroll

local rarityColors = {
    Common=Color3.fromRGB(150,150,150), Uncommon=Color3.fromRGB(80,200,80),
    Rare=Color3.fromRGB(80,120,220), Epic=Color3.fromRGB(160,80,220),
    Legendary=Color3.fromRGB(220,160,0), Mythic=Color3.fromRGB(220,80,80),
    Divine=Color3.fromRGB(80,220,220), Secret=Color3.fromRGB(255,100,200),
}

local lineCount = 0
local function addRow(name, rarity, uuid)
    lineCount += 1
    local color = rarityColors[rarity] or Color3.fromRGB(200,200,200)
    local row = Instance.new("Frame"); row.Size = UDim2.new(1,0,0,36); row.BackgroundColor3 = Color3.fromRGB(45,45,45); row.BorderSizePixel = 0; row.Parent = scroll
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,6)

    local rarTag = Instance.new("TextLabel"); rarTag.Size = UDim2.new(0,70,1,0); rarTag.BackgroundColor3 = color; rarTag.Text = rarity or "?"; rarTag.TextColor3 = Color3.fromRGB(255,255,255); rarTag.Font = Enum.Font.GothamBold; rarTag.TextScaled = true; rarTag.BorderSizePixel = 0; rarTag.Parent = row
    Instance.new("UICorner", rarTag).CornerRadius = UDim.new(0,6)

    local nameL = Instance.new("TextLabel"); nameL.Size = UDim2.new(1,-80,0,18); nameL.Position = UDim2.new(0,76,0,0); nameL.Text = name; nameL.TextColor3 = Color3.fromRGB(255,255,255); nameL.BackgroundTransparency = 1; nameL.Font = Enum.Font.GothamBold; nameL.TextScaled = true; nameL.TextXAlignment = Enum.TextXAlignment.Left; nameL.Parent = row

    local uuidL = Instance.new("TextLabel"); uuidL.Size = UDim2.new(1,-80,0,16); uuidL.Position = UDim2.new(0,76,0,18); uuidL.Text = uuid; uuidL.TextColor3 = Color3.fromRGB(130,130,130); uuidL.BackgroundTransparency = 1; uuidL.Font = Enum.Font.Gotham; uuidL.TextScaled = true; uuidL.TextXAlignment = Enum.TextXAlignment.Left; uuidL.Parent = row
end

local count = 0
for _, v in next, workspace.PlayerPens:GetChildren() do
    if v:GetAttribute("Owner") == LocalPlayer.Name then
        for _, v1 in next, v.Pets:GetChildren() do
            count += 1
            local name = v1:GetAttribute("Name") or "?"
            local rarity = v1:GetAttribute("Rarity") or "?"
            addRow(name, rarity, v1.Name)
        end
    end
end

scroll.CanvasSize = UDim2.new(0,0,0,count*40+8)

local countL = Instance.new("TextLabel"); countL.Size = UDim2.new(1,0,0,20); countL.Position = UDim2.new(0,0,1,-20); countL.Text = "พบทั้งหมด "..count.." pets"; countL.TextColor3 = Color3.fromRGB(0,255,128); countL.BackgroundTransparency = 1; countL.Font = Enum.Font.Gotham; countL.TextScaled = true; countL.Parent = frame
