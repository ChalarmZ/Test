local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ThrowLasso = Remotes:WaitForChild("ThrowLasso")
local minigameRequest = Remotes:WaitForChild("minigameRequest")
local UpdateProgress = Remotes:WaitForChild("UpdateProgress")

local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

local catching = false

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
local function catchPet(pet)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local petCF = pet:GetPivot()

    -- Teleport ไปใกล้ pet
    hrp.CFrame = petCF * CFrame.new(0, 3, 4)
    task.wait(0.3)

    -- คำนวณ direction
    local dir = (petCF.Position - hrp.Position).Unit

    -- ThrowLasso
    pcall(function()
        ThrowLasso:FireServer(0.9, dir)
    end)
    task.wait(0.3)

    -- minigameRequest
    pcall(function()
        minigameRequest:InvokeServer(pet, petCF)
    end)
    task.wait(0.2)

    -- แยก thread ค้าง 75 ไปเรื่อยๆ ไม่บล็อก loop หลัก
    task.spawn(function()
        while catching do
            pcall(function()
                UpdateProgress:FireServer(75)
            end)
            task.wait(1)
        end
    end)
end

local function catchAllPets()
    local done = 0

    while catching do
        local pets = petsFolder:GetChildren()

        if #pets == 0 then
            status.Text = "⏳ รอ pet spawn..."
            task.wait(1)
            continue
        end

        for _, pet in next, pets do
            if not catching then break end

            status.Text = "⏳ กำลังจับ... (" .. done .. " ตัวแล้ว)"
            catchPet(pet)
            done = done + 1
            task.wait(0.5)
        end

        -- วน loop ใหม่จับตัวที่ spawn มาใหม่
        task.wait(0.5)
    end

    status.Text = "⏹ หยุดแล้ว จับไป " .. done .. " ตัว"
    startBtn.Text = "▶  เริ่ม Auto Catch"
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
end

startBtn.MouseButton1Click:Connect(function()
    catching = not catching
    if catching then
        startBtn.Text = "⏹  หยุด"
        startBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        status.Text = "⏳ กำลังจับ..."
        task.spawn(catchAllPets)
    else
        catching = false
        startBtn.Text = "▶  เริ่ม Auto Catch"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        status.Text = "⏹ หยุดแล้ว"
    end
end)
