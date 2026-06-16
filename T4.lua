local petsFolder = workspace:WaitForChild("RoamingPets"):WaitForChild("Pets")

for _, pet in next, petsFolder:GetChildren() do
    print("=== " .. pet.Name .. " ===")
    for attrName, attrValue in next, pet:GetAttributes() do
        print("  " .. attrName .. " = " .. tostring(attrValue))
    end
end
