CreateThread(function()
    exports.ox_target:addGlobalVehicle({
        {
            name = "car_wash_use_cloth",
            icon = Config.ClothWashTargetIcon,
            label = Config.ClothWashTargetLabel,
            canInteract = function(entity, distance, coords, name, bone)
                if IsPedInAnyVehicle(cache.ped, false) then return false end

                local hasItem = lib.callback.await('ug_vehicle_wash:hasCleaningCloth', false)
                return hasItem
            end,
            onSelect = function(data)
                local vehicle = data.entity
                TriggerEvent('ug_vehicle_wash:useItem', vehicle)
            end
        }
    })
end)

RegisterNetEvent('ug_vehicle_wash:useItem', function(vehicle)
    local success = lib.progressBar({
        duration = Config.ClothWashDuration,
        label = Config.ClothWashLabel,
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        },
        anim = {
            dict = "amb@world_human_maid_clean@",
            clip = "base"
        }
    })

    if success then
        SetVehicleDirtLevel(vehicle, 0.0)
        WashDecalsFromVehicle(vehicle, 1.0)
        lib.notify({ type = "success", description = Config.ClothWashSuccessLabel })
        TriggerServerEvent('ug_vehicle_wash:degradeItem', 'cleaning_cloth', 25)
    else
        lib.notify({ type = "inform", description = Config.ClothWashCanceledLabel })
    end
end)
