RegisterNetEvent("ug_vehicle_wash:degradeItem", function(itemName, percent)
    local src = source
    if not itemName then return end
    percent = tonumber(percent) or 25

    if Config.Inventory == "ox" then
        local inventory = exports.ox_inventory:GetInventoryItems(src)

        for slot, item in pairs(inventory) do
            if item.name == itemName and item.metadata and item.metadata.durability then
                local metadata = item.metadata
                local currentDurability = metadata.durability

                local itemInfo = exports.ox_inventory:Items(itemName)
                local degradeMinutes = itemInfo and itemInfo.degrade

                if not degradeMinutes then
                    print(("[SERVER] No degrade config found in ox_inventory for item: %s"):format(itemName))
                    return
                end

                local degradeSeconds = degradeMinutes * 60
                local lossTime = math.floor(degradeSeconds * (percent / 100))
                local newDurability = currentDurability - lossTime

                if newDurability <= os.time() then
                    exports.ox_inventory:RemoveItem(src, itemName, 1, nil, slot)
                    if Config.Debug then
                        print(("[SERVER] %s expired. Removed from slot %s"):format(itemName, slot))
                    end
                else
                    metadata.durability = newDurability
                    exports.ox_inventory:SetMetadata(src, slot, metadata)
                    if Config.Debug then
                        print(("[SERVER] %s degraded to: %s (was %s) — loss: %s sec"):format(itemName, newDurability,
                            currentDurability, lossTime))
                    end
                end
                return
            end
        end
    elseif Config.Inventory == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(src)
        if xPlayer then
            xPlayer.Functions.RemoveItem(itemName, 1)
        end
    end
end)

lib.callback.register('ug_vehicle_wash:hasCleaningCloth', function(source)
    if Config.Inventory == "ox" then
        local count = exports.ox_inventory:Search(source, 'count', 'cleaning_cloth')
        return count > 0
    elseif Config.Inventory == "qb" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            local item = xPlayer.Functions.GetItemByName('cleaning_cloth')
            return item and item.amount and item.amount > 0
        end
    end
    return false
end)

if Config.Inventory == "qb" then
    QBCore.Functions.CreateUseableItem("cleaning_cloth", function(source)
        TriggerClientEvent("ug_vehicle_wash:useItem", source)
    end)
end
