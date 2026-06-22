local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

if LocalPlayer.PlayerGui:FindFirstChild("OutputGui") then LocalPlayer.PlayerGui.OutputGui:Destroy() end

local gui = Instance.new("ScreenGui"); gui.ResetOnSpawn = false; gui.Name = "OutputGui"; gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame"); frame.Size = UDim2.new(0,340,0,420); frame.Position = UDim2.new(0.5,-170,0.5,-210); frame.BackgroundColor3 = Color3.fromRGB(20,20,20); frame.BorderSizePixel = 0; frame.Active = true; frame.Draggable = true; frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel"); title.Size = UDim2.new(1,-44,0,36); title.BackgroundColor3 = Color3.fromRGB(40,40,40); title.Text = "🔍 FeedPet Return Checker"; title.TextColor3 = Color3.fromRGB(255,255,255); title.Font = Enum.Font.GothamBold; title.TextScaled = true; title.BorderSizePixel = 0; title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

local closeBtn = Instance.new("TextButton"); closeBtn.Size = UDim2.new(0,36,0,36); closeBtn.Position = UDim2.new(1,-40,0,0); closeBtn.Text = "✖"; closeBtn.TextColor3 = Color3.fromRGB(255,255,255); closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50); closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextScaled = true; closeBtn.BorderSizePixel = 0; closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local scroll = Instance.new("ScrollingFrame"); scroll.Size = UDim2.new(1,-16,0,320); scroll.Position = UDim2.new(0,8,0,44); scroll.BackgroundColor3 = Color3.fromRGB(30,30,30); scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 4; scroll.CanvasSize = UDim2.new(0,0,0,0); scroll.Parent = frame
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0,8)
local ll = Instance.new("UIListLayout"); ll.Padding = UDim.new(0,2); ll.Parent = scroll
local pp = Instance.new("UIPadding"); pp.PaddingTop = UDim.new(0,4); pp.PaddingLeft = UDim.new(0,4); pp.PaddingRight = UDim.new(0,4); pp.Parent = scroll

local runBtn = Instance.new("TextButton"); runBtn.Size = UDim2.new(1,-16,0,36); runBtn.Position = UDim2.new(0,8,0,374); runBtn.Text = "▶  รัน Test"; runBtn.TextColor3 = Color3.fromRGB(255,255,255); runBtn.BackgroundColor3 = Color3.fromRGB(0,160,80); runBtn.Font = Enum.Font.GothamBold; runBtn.TextScaled = true; runBtn.BorderSizePixel = 0; runBtn.Parent = frame
Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0,8)

local lineCount = 0
local function addLine(text, color)
    lineCount += 1
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1,0,0,18); l.Text = lineCount..". "..text; l.TextColor3 = color or Color3.fromRGB(200,200,200); l.BackgroundTransparency = 1; l.Font = Enum.Font.Gotham; l.TextScaled = true; l.TextXAlignment = Enum.TextXAlignment.Left; l.Parent = scroll
    local p = Instance.new("UIPadding"); p.PaddingLeft = UDim.new(0,4); p.Parent = l
    scroll.CanvasSize = UDim2.new(0,0,0,lineCount*20+8)
    scroll.CanvasPosition = Vector2.new(0,lineCount*20)
end

local function printResult(val, prefix)
    prefix = prefix or ""
    if type(val) == "table" then
        for k, v in next, val do
            printResult(v, prefix..tostring(k)..": ")
        end
    else
        addLine(prefix..tostring(val), Color3.fromRGB(0,255,128))
    end
end

runBtn.MouseButton1Click:Connect(function()
    -- clear
    for _, c in next, scroll:GetChildren() do if c:IsA("TextLabel") then c:Destroy() end end
    lineCount = 0

    local petFound = false
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _, v1 in next, v.Pets:GetChildren() do
                petFound = true
                local petName = v1:GetAttribute("Name") or v1.Name:sub(1,8)
                addLine("=== Pet: "..petName.." ===", Color3.fromRGB(255,200,0))

                local ok, result = pcall(function()
                    return ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer("Banana", v1.Name, 0/0)
                end)

                if not ok then
                    addLine("ERROR: "..tostring(result), Color3.fromRGB(255,80,80))
                elseif result == nil then
                    addLine("return: nil", Color3.fromRGB(150,150,150))
                elseif type(result) == "boolean" then
                    addLine("return boolean: "..tostring(result), Color3.fromRGB(0,200,255))
                elseif type(result) == "number" then
                    addLine("return number: "..tostring(result), Color3.fromRGB(0,200,255))
                elseif type(result) == "string" then
                    addLine("return string: "..result, Color3.fromRGB(0,200,255))
                elseif type(result) == "table" then
                    addLine("return table:", Color3.fromRGB(0,200,255))
                    printResult(result, "  ")
                else
                    addLine("return "..type(result)..": "..tostring(result), Color3.fromRGB(0,200,255))
                end
                break
            end
        end
        if petFound then break end
    end

    if not petFound then addLine("ไม่พบ pet ในสวน", Color3.fromRGB(255,80,80)) end
end)
