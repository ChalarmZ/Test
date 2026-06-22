local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ChalarmZ", "Ocean")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Foods = {"Banana","Cave Mushroom","Cosmic Fruit","Volcanic Fruit","Heart Chocolate","Bloodmoon Grape","Tuna Fish","Dog Treat","Taco","Alien Fruit","Chocolate Egg","Radioactive Strawberry","Cotton Candy","Waffle","Star","Bag Of Worms","Pepper","Abyss Crystal","Steak","Rocky Cookie","Mango"}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateProgress = Remotes:WaitForChild("UpdateProgress")
local ThrowLasso = Remotes:WaitForChild("ThrowLasso")
local minigameRequest = Remotes:WaitForChild("minigameRequest")
local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

local running, closed, lockRunning, catchRunning = false, false, false, false
local selectedRarities = {Common = false, Divine = false}

local function getDisplayName(v1)
    local n = v1:GetAttribute("Name"); return (n and n ~= "") and n or v1.Name:sub(1,8).."..."
end

local function getMyPets()
    local pets = {}
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _, v1 in next, v.Pets:GetChildren() do
                table.insert(pets, v1)
            end
        end
    end
    return pets
end

-- ========== TAB: FeedPet ==========
local FeedPet = Window:NewTab("FeedPet")
local FeedSection = FeedPet:NewSection("Feed Pet")

local feedStatus = "พร้อมใช้งาน"

FeedSection:NewButton("▶ เริ่มให้อาหาร (50 ครั้ง/ชนิด)", "ให้อาหารทุกชนิด ชนิดละ 50 ครั้ง", function()
    if running then return end
    running = true
    local totalCount = 0
    local myPets = getMyPets()
    if #myPets == 0 then running = false; return end

    for _, v2 in next, Foods do
        if closed then break end
        for i = 1, 30 do
            if closed then break end
            for _, v1 in next, myPets do
                if closed then break end
                pcall(function()
                    ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, v1.Name, 0/0)
                end)
                totalCount += 1
                task.wait()
            end
        end
    end

    running = false
end)

FeedSection:NewButton("⏹ หยุดให้อาหาร", "หยุด loop ให้อาหาร", function()
    running = false
end)

-- ========== TAB: LockProgress ==========
local LockProgressTab = Window:NewTab("LockProgress")
local LockSection = LockProgressTab:NewSection("Lock Progress")

LockSection:NewButton("🔒 Lock Progress 75% (เปิด)", "วนส่ง progress 75 ทุก 1 วินาที", function()
    if lockRunning then return end
    lockRunning = true
    task.spawn(function()
        while lockRunning and not closed do
            pcall(function() UpdateProgress:FireServer(75) end)
            task.wait(1)
        end
    end)
end)

LockSection:NewButton("🔓 หยุด Lock Progress", "หยุดส่ง progress", function()
    lockRunning = false
end)

-- ========== TAB: AutoCatch ==========
local AutoCatchTab = Window:NewTab("AutoCatch")
local CatchSection = AutoCatchTab:NewSection("Auto Catch")

CatchSection:NewToggle("Common", "จับ Common", false, function(val)
    selectedRarities["Common"] = val
end)

CatchSection:NewToggle("Divine", "จับ Divine", false, function(val)
    selectedRarities["Divine"] = val
end)

CatchSection:NewButton("🐾 Auto Catch (เปิด)", "เริ่มจับ pet ตาม rarity ที่เลือก", function()
    if catchRunning then return end
    local anySelected = false
    for _, v in next, selectedRarities do if v then anySelected = true; break end end
    if not anySelected then return end

    catchRunning = true
    task.spawn(function()
        while catchRunning and not closed do
            local pets = petsFolder:GetChildren()
            if #pets == 0 then task.wait(1); continue end
            for _, pet in next, pets do
                if not catchRunning or closed then break end
                local rar = pet:GetAttribute("Rarity") or ""
                if not selectedRarities[rar] then continue end
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then task.wait(1); continue end
                local petCF = pet:GetPivot()
                hrp.CFrame = petCF * CFrame.new(0,3,4); task.wait(0.3)
                local dir = (petCF.Position - hrp.Position).Unit
                pcall(function() ThrowLasso:FireServer(0.9, dir) end); task.wait(0.3)
                pcall(function() minigameRequest:InvokeServer(pet, petCF) end)
                local t = tick()
                while catchRunning and not closed and pet and pet.Parent do
                    pcall(function() UpdateProgress:FireServer(75) end)
                    task.wait(0.5); if tick()-t > 5 then break end
                end
                task.wait(0.3)
            end
            task.wait(0.3)
        end
    end)
end)

CatchSection:NewButton("⏹ หยุด Auto Catch", "หยุดจับ pet", function()
    catchRunning = false
end)
