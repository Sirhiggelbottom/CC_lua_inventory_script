local chest1 = peripheral.wrap("minecraft:chest_0")
local chest2 = peripheral.wrap("minecraft:chest_1")
local chest3 = peripheral.wrap("minecraft:chest_2")
local chest4 = peripheral.wrap("minecraft:chest_3")

local monitor = peripheral.wrap("monitor_2")

local chest1Size = chest1.size()
local chest2Size = chest2.size()
local chest3Size = chest3.size()

local function countInv(checkChest)
    local chest = checkChest
    local totalItemCount = 0
    local items = chest.list()  -- This gets a table of all the items in the chest

    for slot, itemDetail in pairs(items) do
        totalItemCount = totalItemCount + itemDetail.count  -- Adds the count of items in the slot to the total
    end

    return totalItemCount
end



local function debug(text)
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write(text)
end

local function searchInv()
    local hasIron = false
    local hasGold = false
    local ironSlot, goldSlot

    local items = chest1.list()
    
    for slot, item in pairs(items) do
        if item.name == "minecraft:iron_ingot" then
            hasIron = true
            ironSlot = slot
        elseif item.name == "minecraft:gold_ingot" then
            hasGold = true
            goldSlot = slot
        end
    end
    
    if hasIron and hasGold then
        local resultIron = chest1.pushItems(peripheral.getName(chest2), ironSlot, 1)
        local resultGold = chest1.pushItems(peripheral.getName(chest2), goldSlot, 1)
        debug("Moved iron: " .. resultIron .. "\nMoved gold: " .. resultGold)
    break

end

while true

    if countInv(chest1) > 2 then
        if countInv(chest2) < 2 then
            searchInv()
        else countInv(chest2) >= 2 then
            debug("Chest 2 is not ready")
        end
    elseif countInv(chest1) < 1 and countInv(chest2) < 1 then
        if countInv(chest1) < 1 then
            debug("Chest 1 isn't connected")
        break
        
        elseif countInv(chest2) < 1 then
            debug("Chest 2 isn't connected")
        end
    end

    if countInv(chest3) > 1 then
        local moveItems = chest3.list()
        local moveSlot

        for slot, item in pairs(moveItems) do
            moveSlot = slot
            local moveItem = chest3.pushItems(peripheral.getName(chest4), moveSlot)
        end
    end

    os.sleep(1)
end

