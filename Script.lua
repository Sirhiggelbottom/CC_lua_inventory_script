local chestInput = peripheral.wrap("minecraft:chest_5")
local chestCrafting = peripheral.wrap("minecraft:chest_1")
local chestOutput = peripheral.wrap("minecraft:chest_2")
local chestRefined = peripheral.wrap("minecraft:chest_3")
 
local enderDrawer = peripheral.wrap("functionalstorage:oak_1_0")
local goldDrawer = peripheral.wrap("functionalstorage:oak_1_1")
local ironDrawer = peripheral.wrap("functionalstorage:oak_1_2")
local potatoDrawer = peripheral.wrap("functionalstorage:oak_1_3")
 
local monitor = peripheral.wrap("monitor_3")
 
local enderDrawerSize = enderDrawer.getItemLimit(1)
local goldDrawerSize = goldDrawer.getItemLimit(1)
local ironDrawerSize = ironDrawer.getItemLimit(1)
local potatoDrawerSize = potatoDrawer.getItemLimit(1)
 
local constValue = true
 
local function countInv(checkChest)
    local totalItemCount = 0
    if checkChest then
        local items = checkChest.list()
        for slot, itemDetail in pairs(items) do
            totalItemCount = totalItemCount + itemDetail.count
        end
    else
        return "Can't find inventory"
    end
    return totalItemCount
end
 
local function debug(text)
    if monitor then
    
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write(text)
    end
end
 
local function debugLine(text, line)
    if monitor then
    
        monitor.setCursorPos(1, line)
        monitor.write(text)
    end
end
 
local function moveItems(slot1, amount1, slot2, amount2)
    local itemToBeMoved1
    local itemToBeMoved2
    
    if amount1 then
        itemToBeMoved1 = chestInput.pushItems(peripheral.getName(chestCrafting), slot1, amount1)
    else
        itemToBeMoved1 = chestInput.pushItems(peripheral.getName(chestCrafting), slot1)
    end
 
    if slot2 then
        if amount2 then
            itemToBeMoved2 = chestInput.pushItems(peripheral.getName(chestCrafting), slot2, amount2)
        else
            itemToBeMoved2 = chestInput.pushItems(peripheral.getName(chestCrafting), slot2)
        end
    end
end
 
local function searchInv()
    local hasIron = false
    local hasGold = false
    local hasBlazeRod = false
    local hasDiamond = false
    local hasEmerald = false
    local ironSlot, goldSlot, blazeRodSlot, diamondSlot, emeraldSlot
    local items = chestInput.list()
    local resultEnergizeSteel, resultBlazingCrystal, nioticCrystal, spiritedCrystal
 
 
    for slot, item in pairs(items) do -- Checks if input chest has the ingredients for: Energized steel
        if item.name == "minecraft:iron_ingot" then
            hasIron = true
            ironSlot = slot
        elseif item.name == "minecraft:iron_ingot" then
            hasGold = true
            goldSlot = slot
        elseif item.name == "minecraft:blaze_rod" then
            hasBlazeRod = true
            blazeRodSlot = slot
        elseif item.name == "minecraft:diamond" then
            hasDiamond = true
            diamondSlot = slot
        elseif item.name == "minecraft:emerald" then
            hasEmerald = true
            emeraldSlot = slot
        end
    end
 
    if hasIron and hasGold and (hasBlazeRod or hasDiamond or hasEmerald) then -- If input chest contains ingredients for more
        -- than one item it starts with the Energized steel, and checks what other items are present after that.
        
        resultEnergizeSteel = moveItems(ironSlot, 1, goldSlot, 1)
        --debug("Moved iron: " .. resultEnergizeSteel .. "\nMoved gold: " .. resultEnergizeSteel)
        os.sleep(2)
 
        if hasBlazeRod then
            resultBlazingCrystal = moveItems(blazeRodSlot, 1, nil, nil)
            --debug ("Moved blaze rod: " .. resultBlazingCrystal)
            os.sleep(2)
        elseif hasDiamond then
            nioticCrystal = moveItems(diamondSlot, 1, nil, nil)
            --debug ("Moved diamond: " .. nioticCrystal)
            os.sleep(2)
        elseif hasEmerald then
            spiritedCrystal = moveItems(emeraldSlot, 1, nil, nil)
            os.sleep(3)
        end
    elseif hasIron and hasGold then
        --local resultIron = chestInput.pushItems(peripheral.getName(chestCrafting), ironSlot, 1)
        --local resultGold = chestInput.pushItems(peripheral.getName(chestCrafting), goldSlot, 1)
 
        resultEnergizeSteel = moveItems(ironSlot, 1, goldSlot, 1)
        os.sleep(2)
        --debug("Moved iron: " .. resultEnergizeSteel .. "\nMoved gold: " .. resultEnergizeSteel)
    elseif hasBlazeRod then
        --local resultBlazeRod = chestInput.pushItems(peripheral.getName(chestCrafting), blazeRodSlot, 1)
        resultBlazingCrystal = moveItems(blazeRodSlot, 1)
        os.sleep(2)
        --debug ("Moved blaze rod: " .. resultBlazingCrystal)
    elseif hasDiamond then
        --local resultDiamond = chestInput.pushItems(peripheral.getName(chestCrafting), diamondSlot, 1)
        nioticCrystal = moveItems(diamondSlot, 1)
        os.sleep(2)
        --debug ("Moved diamond: " .. nioticCrystal)
    elseif hasEmerald then
        spiritedCrystal = moveItems(emeraldSlot, 1)
        os.sleep(3)
    end
end
 
local function checkSize(inventorySize, inventory)
    if inventorySize ~= inventory.getItemLimit(1) then
        inventorySize = inventory.getItemLimit(1)
    end
end
 
local function CraftingRdy()
    local bool = false
    if countInv(chestCrafting) < 1 then
        bool = true
    end
    return bool
end
 
while constValue do
    
    if countInv(chestInput) > 0 then
        if CraftingRdy() then
            searchInv()
        else
            debug("Chest 2 isn't ready")
        end
    end
 
    if countInv(chestOutput) > 0 then
        local moveItems = chestOutput.list()
        local moveSlot
 
        for slot, item in pairs(moveItems) do
            moveSlot = slot
            local moveItem = chestOutput.pushItems(peripheral.getName(chestRefined), moveSlot)
            debug("Moving items from output chest to refined stoarge")
        end
    end
 
    checkSize(enderDrawerSize, enderDrawer)
    checkSize(goldDrawerSize, goldDrawer)
    checkSize(ironDrawerSize, ironDrawer)
    checkSize(potatoDrawerSize, potatoDrawer)
    if monitor then
    
        monitor.clear()
    end
    
    debugLine("Amount of Enderpearls: " .. countInv(enderDrawer) .. " / " .. enderDrawerSize, 1)
    debugLine("Amount of Gold ingots: " .. countInv(goldDrawer) .. " / " .. goldDrawerSize, 2)
    debugLine("Amount of Iron ingots: " .. countInv(ironDrawer) .. " / " .. ironDrawerSize, 3)
    debugLine("Amount of Potatos:     " .. countInv(potatoDrawer) .. " / " .. potatoDrawerSize, 4)
 
    os.sleep(2)
end