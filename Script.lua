local chest1 = peripheral.wrap("minecraft:chest_0")
local chest2 = peripheral.wrap("minecraft:chest_1")
local monitor = peripheral.wrap("monitor_2")

local chest1Size = chest1.size()
local chest2Size = chest2.size()

local function debug(text)
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write(text)
end

while true do
    local hasIron = false
    local hasGold = false
    local ironSlot, goldSlot

    local items = chest1.list()
    for slot, item in pairs(items) do
        if item.tags and item.tags["forge:ingots/iron"] then
            hasIron = true
            ironSlot = slot
        elseif item.tags and item.tags["forge:ingots/gold"] then
            hasGold = true
            goldSlot = slot
        end
    end

    if hasIron and hasGold then
        local resultIron = chest1.pushItems(peripheral.getName(chest2), ironSlot, 1)
        local resultGold = chest1.pushItems(peripheral.getName(chest2), goldSlot, 1)
        debug("Moved iron: " .. resultIron .. "\nMoved gold: " .. resultGold)
    
    elseif chest1Size < 1 and chest2Size < 1 then
        debug("Chests aren't connected")
    end
    
    elseif chest1Size < 1 then
        debug("Chest 1 isn't connected")
    end
    
    elseif chest2Size < 1 then
        debug("Chest 2 isn't connected")
    end
    
    else
        debug("Iron or gold not found.")
    end

    os.sleep(4)
end
