local chest1 = peripheral.wrap("minecraft:chest_0")
local chest2 = peripheral.wrap("minecraft:chest_1")
local chest3 = peripheral.wrap("minecraft:chest_2")
local chest4 = peripheral.wrap("minecraft:chest_3")

local enderDrawer = peripheral.wrap("functionalstorage:oak_1_0")
local goldDrawer = peripheral.wrap("functionalstorage:oak_1_1")
local ironDrawer = peripheral.wrap("functionalstorage:oak_1_2")
local potatoDrawer = peripheral.wrap("functionalstorage:oak_1_3")

local monitor = peripheral.wrap("monitor_2")

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
    monitor.clear
    monitor.setCursorPos(1, 1)
    monitor.write(text)
end

local function debugLine(text, line)
    monitor.setCursorPos(1, line)
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
        elseif item.name == "minecraft:iron_ingot" then
            hasGold = true
            goldSlot = slot
        end
    end

    if hasIron and hasGold then
        local resultIron = chest1.pushItems(peripheral.getName(chest2), ironSlot, 1)
        local resultGold = chest1.pushItems(peripheral.getName(chest2), goldSlot, 1)
        debug("Moved iron: " .. resultIron .. "\nMoved gold: " .. resultGold)
    end
end

local function checkSize(inventorySize, inventory)
    if inventorySize ~= inventory.getItemLimit(1) then
        inventorySize = inventory.getItemLimit(1)
    end
end


while constValue do
    if countInv(chest1) >= 2 then
        if countInv(2) < 2 then
            searchInv()
        else
            debug("Chest 2 isn't ready")
        end
    end

    if countInv(chest3) > 1 then
        local moveItems = chest3.list()
        local moveSlot

        for slot, item in pairs(moveItems) do
            moveSlot = slot
            local moveItem = chest3.pushItems(peripheral.getName(chest4), moveSlot)
            debug("Moving items from output chest to refined stoarge")
        end
    end

    checkSize(enderDrawerSize, enderDrawer)
    checkSize(goldDrawerSize, goldDrawer)
    checkSize(ironDrawerSize, ironDrawer)
    checkSize(potatoDrawerSize, potatoDrawer)

    monitor.clear()
    debugLine("Amount of Enderpearls: " .. countInv(enderDrawer) .. " / " .. enderDrawerSize, 1)
    debugLine("Amount of Gold ingots: " .. countInv(goldDrawer) .. " / " .. goldDrawerSize, 2)
    debugLine("Amount of Enderpearls: " .. countInv(ironDrawer) .. " / " .. ironDrawerSize, 3)
    debugLine("Amount of Enderpearls: " .. countInv(potatoDrawer) .. " / " .. potatoDrawerSize, 4)

    os.sleep(4)
end
