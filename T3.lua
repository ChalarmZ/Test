local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local minigameRequest = Remotes:WaitForChild("minigameRequest")
local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

local catching = false
local caughtList = {}

-- GUI
if LocalPlayer.PlayerGui:FindFirstChild("CatchGui") then
    LocalPlayer.PlayerGui.CatchGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "CatchGui"
gui.Parent = LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 130)
frame.Position = UDim2.new(0.5, -120, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 36)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🐾  Auto Catch Pet"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BorderSizePixel = 0
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -10, 0, 24)
status.Position = UDim2.new(0, 5, 0, 42)
status.Text = "พร้อมใช้งาน"
status.TextColor3 = Color3.fromRGB(0, 255, 128)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextScaled = true
status.Parent = frame

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(1, -16, 0, 38)
startBtn.Position = UDim2.new(0, 8, 0, 72)
startBtn.Text = "▶  เริ่ม Auto Catch"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextScaled = true
startBtn.BorderSizePixel = 0
startBtn.Parent = frame
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

-- Logic
local function catchAllPets()
    local pets = petsFolder:GetChildren()
    if #pets == 0 then
        status.Text = "❌ ไม่มี pet ใน RoamingPets"
        return
    end

    local total = #pets
    local done = 0

    for _, pet in next, pets do
        if not catching then break end

        task.spawn(function()
            pcall(function()
                local args = {
                    [1] = pet,
                    [2] = pet:GetPivot()
                }
                minigameRequest:InvokeServer(unpack(args))
            end)
            done = done + 1
            if catching then
                status.Text = "จับแล้ว " .. done .. " / " .. total
            end
        end)

        task.wait(0.5) -- หน่วงระหว่างตัว ปรับได้
    end

    task.wait(1)
    if catching then
        status.Text = "✅ จบแล้ว! จับ " .. done .. " ตัว"
        catching = false
        startBtn.Text = "▶  เริ่ม Auto Catch"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    end
end

startBtn.MouseButton1Click:Connect(function()
    catching = not catching
    if catching then
        startBtn.Text = "⏹  หยุด"
        startBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        status.Text = "⏳ กำลังจับ..."
        task.spawn(catchAllPets)
    else
        startBtn.Text = "▶  เริ่ม Auto Catch"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        status.Text = "⏹ หยุดแล้ว"
    end
end)
