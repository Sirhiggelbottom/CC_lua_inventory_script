local chest1 = peripheral.wrap("minecraft:chest_0")
local chest2 = peripheral.wrap("minecraft:chest_1")
local chest3 = peripheral.wrap("minecraft:chest_2")
local chest4 = peripheral.wrap("minecraft:chest_3")

local monitor = peripheral.wrap("monitor_2")
local constValue = false

local chest1Size = chest1.size()
local chest2Size = chest2.size()
local chest3Size = chest3.size()

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

    if chest1Size > 2 then
        if chest2Size < 2 then
            searchInv()
        else chest2Size >= 2 then
            debug("Chest 2 is not ready")
        end

    elseif chest1Size < 1 and chest2Size < 1 then
        if chest1Size < 1 then
            debug("Chest 1 isn't connected")
        break
        
        elseif chest2Size < 1 then
            debug("Chest 2 isn't connected")
        end
    end

    if chest3Size > 1 then
        local moveItems = chest3.list()
        local moveSlot

        for slot, item in pairs(moveItems) do
            moveSlot = slot
            local moveItem = chest3.pushItems(peripheral.getName(chest4), moveSlot)
        end
    end

    os.sleep(1)
end

