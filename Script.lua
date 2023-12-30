local chest1 = peripheral.wrap("minecraft:chest_0")
local chest2 = peripheral.wrap("minecraft:chest_1")

while true do
    local hasIron = false
    local hasGold = false
    local ironSlot, goldSlot

    for slot, item in pairs(chest1.list()) do
        if item.tags and item.tags["forge:ingots/iron"] then
            hasIron = true
            ironSlot = slot
        elseif item.tags and item.tags["forge:ingots/gold"] then
            hasGold = true
            goldSlot = slot
        end
    end

    if hasIron and hasGold then
        chest1.pushItems(peripheral.getName(chest2), ironSlot, 1)
        chest1.pushItems(peripheral.getName(chest2), goldSlot, 1)
    end

    os.sleep(4)
end
