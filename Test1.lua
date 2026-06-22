foodBtn.MouseButton1Click:Connect(function()
    if running or closed then return end
    running=true; foodBtn.Text="⏳  กำลังให้อาหาร..."; foodBtn.BackgroundColor3=Color3.fromRGB(180,100,0)
    local count=0
    for _, v2 in next, Foods do
        if closed then break end
        -- วนให้อาหารชนิดเดียวจนได้ false (ของหมด/buff เต็ม)
        local keepFeeding = true
        while keepFeeding and not closed do
            local anyFed = false
            for id, d in next, checkboxes do
                if closed then break end
                if d.selected then
                    local ok, result = pcall(function()
                        return ReplicatedStorage.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FoodService.RF.FeedPet:InvokeServer(v2, id, 0/0)
                    end)
                    if ok and result == true then
                        anyFed = true
                        count+=1
                        if not closed then statusL.Text=v2.." → "..getDisplayName(d.obj) end
                    end
                    task.wait(0.05)
                end
            end
            -- ถ้าไม่มี pet ไหนได้รับอาหารเลย = buff เต็มหมดทุกตัวแล้ว
            if not anyFed then keepFeeding = false end
        end
        if not closed then statusL.Text="✅ "..v2.." เต็มทุกตัวแล้ว ไปต่อ..." end
        task.wait(0.1)
    end
    if not closed then statusL.Text="✅ เสร็จทั้งหมด! ("..count.." ครั้ง)"; foodBtn.Text="▶  เริ่มให้อาหาร"; foodBtn.BackgroundColor3=Color3.fromRGB(0,180,80); running=false end
end)
