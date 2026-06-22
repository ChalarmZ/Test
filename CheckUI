local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if LocalPlayer.PlayerGui:FindFirstChild("CheckGui") then
    LocalPlayer.PlayerGui.CheckGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "CheckGui"
gui.Parent = LocalPlayer.PlayerGui

local win = Instance.new("Frame")
win.Size = UDim2.new(0,360,0,480)
win.Position = UDim2.new(0.5,-180,0.5,-240)
win.BackgroundColor3 = Color3.fromRGB(18,18,28)
win.BorderSizePixel = 0
win.Active = true
win.Draggable = true
win.Parent = gui
Instance.new("UICorner", win).CornerRadius = UDim.new(0,10)

local titlebar = Instance.new("Frame")
titlebar.Size = UDim2.new(1,0,0,40)
titlebar.BackgroundColor3 = Color3.fromRGB(25,25,40)
titlebar.BorderSizePixel = 0
titlebar.Parent = win
Instance.new("UICorner", titlebar).CornerRadius = UDim.new(0,10)
local titleFix = Instance.new("Frame"); titleFix.Size = UDim2.new(1,0,0,10); titleFix.Position = UDim2.new(0,0,1,-10); titleFix.BackgroundColor3 = Color3.fromRGB(25,25,40); titleFix.BorderSizePixel = 0; titleFix.Parent = titlebar

local titleTxt = Instance.new("TextLabel")
titleTxt.Size = UDim2.new(1,-50,1,0)
titleTxt.Position = UDim2.new(0,10,0,0)
titleTxt.Text = "🔍 Attr Checker"
titleTxt.TextColor3 = Color3.fromRGB(255,255,255)
titleTxt.Font = Enum.Font.GothamBold
titleTxt.TextScaled = true
titleTxt.BackgroundTransparency = 1
titleTxt.TextXAlignment = Enum.TextXAlignment.Left
titleTxt.Parent = titlebar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,28,0,28)
closeBtn.Position = UDim2.new(1,-32,0,6)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titlebar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1,-16,0,28)
statusLbl.Position = UDim2.new(0,8,0,46)
statusLbl.Text = "กด สแกน เพื่อเริ่ม"
statusLbl.TextColor3 = Color3.fromRGB(0,220,120)
statusLbl.BackgroundColor3 = Color3.fromRGB(20,35,25)
statusLbl.Font = Enum.Font.Gotham
statusLbl.TextScaled = true
statusLbl.BorderSizePixel = 0
statusLbl.Parent = win
Instance.new("UICorner", statusLbl).CornerRadius = UDim.new(0,6)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-16,0,340)
scroll.Position = UDim2.new(0,8,0,82)
scroll.BackgroundColor3 = Color3.fromRGB(25,25,38)
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.Parent = win
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0,8)

local ll = Instance.new("UIListLayout")
ll.Padding = UDim.new(0,2)
ll.Parent = scroll
local pp = Instance.new("UIPadding")
pp.PaddingTop = UDim.new(0,4)
pp.PaddingLeft = UDim.new(0,6)
pp.PaddingRight = UDim.new(0,6)
pp.Parent = scroll
ll.Changed:Connect(function()
    scroll.CanvasSize = UDim2.new(0,0,0,ll.AbsoluteContentSize.Y+12)
end)

local runBtn = Instance.new("TextButton")
runBtn.Size = UDim2.new(1,-16,0,40)
runBtn.Position = UDim2.new(0,8,1,-48)
runBtn.Text = "▶  สแกน"
runBtn.TextColor3 = Color3.fromRGB(255,255,255)
runBtn.BackgroundColor3 = Color3.fromRGB(0,140,80)
runBtn.Font = Enum.Font.GothamBold
runBtn.TextScaled = true
runBtn.BorderSizePixel = 0
runBtn.Parent = win
Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0,8)

local function addLine(text, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,0,22)
    l.Text = text
    l.TextColor3 = color or Color3.fromRGB(200,200,200)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.BorderSizePixel = 0
    l.Parent = scroll
end

runBtn.MouseButton1Click:Connect(function()
    for _, c in next, scroll:GetChildren() do
        if c:IsA("TextLabel") then c:Destroy() end
    end
    statusLbl.Text = "⏳ สแกนอยู่..."

    local pens = workspace:FindFirstChild("PlayerPens")
    if not pens then addLine("❌ ไม่เจอ PlayerPens", Color3.fromRGB(255,80,80)); return end

    local count = 0
    for _, pen in next, pens:GetChildren() do
        local owner = pen:GetAttribute("Owner") or "?"
        if owner == LocalPlayer.Name then
            local petsF = pen:FindFirstChild("Pets")
            if not petsF then continue end
            for _, pet in next, petsF:GetChildren() do
                count += 1
                addLine("── " .. (pet:GetAttribute("Name") or pet.Name), Color3.fromRGB(100,180,255))
                for k, v in next, pet:GetAttributes() do
                    addLine("   "..k.." = "..tostring(v), Color3.fromRGB(180,220,180))
                end
            end
        end
    end

    statusLbl.Text = count > 0 and "✅ พบ "..count.." pets" or "❌ ไม่พบ pet"
end)
