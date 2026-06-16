local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function chatPrint(msg)
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = msg,
        Color = Color3.fromRGB(0, 255, 128),
        Font = Enum.Font.GothamBold,
        FontSize = Enum.FontSize.Size18
    })
end

local Foods = {
    "Banana", "Cave Mushroom", "Cosmic Fruit", "Volcanic Fruit",
    "Heart Chocolate", "Bloodmoon Grape", "Tuna Fish", "Dog Treat",
    "Taco", "Alien Fruit", "Chocolate Egg", "Radioactive Strawberry",
    "Cotton Candy", "Waffle", "Star", "Bag Of Worms", "Pepper",
    "Abyss Crystal", "Steak", "Rocky Cookie"
}

-- ========== FOOD ==========
for _, v2 in next, Foods do
    for _, v in next, workspace.PlayerPens:GetChildren() do
        if v:GetAttribute("Owner") == LocalPlayer.Name then
            for _, v1 in next, v.Pets:GetChildren() do
                ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, v1.Name, 0/0)
            end
        end
    end
end

-- ========== TOTEM / RIDE / FLY ==========
local testValues = {0/0, math.huge, 99999}
local testLabels = {"0/0 (NaN)", "math.huge", "99999"}

for _, v in next, workspace.PlayerPens:GetChildren() do
    if v:GetAttribute("Owner") == LocalPlayer.Name then
        for _, v1 in next, v.Pets:GetChildren() do
            for i, val in next, testValues do
                chatPrint("===== ลอง: " .. testLabels[i] .. " | Pet: " .. v1.Name .. " =====")

                local totemOk, totemErr = pcall(function()
                    ReplicatedStorage.Remotes.UseTotem:FireServer("Lightning Totem", v1.Name, val)
                end)
                chatPrint("UseTotem -> " .. (totemOk and "OK" or "ERROR: " .. tostring(totemErr)))

                local rideOk, rideErr = pcall(function()
                    ReplicatedStorage.Remotes.useRidingPotion:InvokeServer(v1.Name, val)
                end)
                chatPrint("useRidingPotion -> " .. (rideOk and "OK" or "ERROR: " .. tostring(rideErr)))

                local flyOk, flyErr = pcall(function()
                    ReplicatedStorage.Remotes.useFlyingPotion:InvokeServer(v1.Name, val)
                end)
                chatPrint("useFlyingPotion -> " .. (flyOk and "OK" or "ERROR: " .. tostring(flyErr)))

                task.wait(0.5)
            end
        end
    end
end

-- ========== SHOVEL TEST ==========
chatPrint("===== START SHOVEL TEST =====")
local req = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("requestShovels")

pcall(function() req:FireServer() end)
chatPrint("แบบ 1: ไม่มี arg")
task.wait(1)

pcall(function() req:FireServer("Steel Shovel") end)
chatPrint("แบบ 2: แค่ชื่อ")
task.wait(1)

pcall(function() req:FireServer(false, "Steel Shovel") end)
chatPrint("แบบ 3: false")
task.wait(1)

pcall(function() req:FireServer(nil, "Steel Shovel") end)
chatPrint("แบบ 4: nil")
task.wait(1)

pcall(function() req:FireServer(true, "Steel Shovel") end)
chatPrint("แบบ 5: true ปกติ (baseline)")

chatPrint("===== END SHOVEL TEST =====")
chatPrint("ดูใน game ว่า shovel equip ตอนไหนครับ")
