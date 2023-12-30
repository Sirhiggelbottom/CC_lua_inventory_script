local chest1 = peripheral.wrap("minecraft:chest_0")
local chest2 = peripheral.wrap("minecraft:chest_1")
local monitor = peripheral.wrap("monitor_2")
local constValue = false

local chest1Size = chest1.size()
local chest2Size = chest2.size()

local function debug(text)
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write(text)
end

repeat
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

    if hasIron and hasGold and chest2.size() < 2 then
        local resultIron = chest1.pushItems(peripheral.getName(chest2), ironSlot, 1)
        local resultGold = chest1.pushItems(peripheral.getName(chest2), goldSlot, 1)
        debug("Moved iron: " .. resultIron .. "\nMoved gold: " .. resultGold)
    break

    elseif chest1Size < 1 and chest2Size < 1 then
        debug("Chests aren't connected")
    break
    
    elseif chest1Size < 1 then
        debug("Chest 1 isn't connected")
    break
    
    elseif chest2Size < 1 then
        debug("Chest 2 isn't connected")
    break
    
    else
        debug("Iron or gold not found, or Chest2 already have ingots.")
    end
    os.sleep(4)
until constValue
