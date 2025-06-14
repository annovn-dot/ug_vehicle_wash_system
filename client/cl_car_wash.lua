CreateThread(function()
    for _, coords in pairs(Config.CarWashLocations) do
        setupCarWashZone(coords)
        createCarWashBlip(coords)
    end
end)

local inZone = false

function setupCarWashZone(coords)
    local zone = lib.zones.box({
        coords = vec3(coords.x, coords.y, coords.z),
        size = vec3(6, 6, 3),
        rotation = coords.w,
        debug = false,
        onEnter = function()
            inZone = true
            lib.showTextUI(Config.TextUILabel)
        end,
        onExit = function()
            inZone = false
            lib.hideTextUI()
        end
    })
end

function createCarWashBlip(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, Config.Blip.Sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.Blip.Scale)
    SetBlipColour(blip, Config.Blip.Color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.Label)
    EndTextCommandSetBlipName(blip)
end

RegisterCommand("carwash", function()
    if not inZone then
        -- lib.notify({ type = "error", description = "You must be at a car wash to use this." })
        return
    end

    local ped = cache.ped
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 then
        lib.notify({ type = "error", description = Config.CarWashMustBeInVehicleLabel })
        return
    end

    if GetPedInVehicleSeat(vehicle, -1) ~= ped then
        lib.notify({ type = "error", description = Config.CarWashMustBeDriverLabel })
        return
    end

    local success = lib.progressBar({
        duration = Config.CarWashDuration,
        label = Config.CarWashLabel,
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        }
    })

    if success then
        SetVehicleDirtLevel(vehicle, 0.0)
        WashDecalsFromVehicle(vehicle, 1.0)
        lib.notify({ type = "success", description = Config.CarWashSuccessLabel })
    else
        lib.notify({ type = "inform", description = Config.CarWashCancelLabel })
    end
end)

if Config.EnableKeyMap then
    RegisterKeyMapping("carwash", "~b~Enter Car wash", "KEYBOARD", "E")
end
