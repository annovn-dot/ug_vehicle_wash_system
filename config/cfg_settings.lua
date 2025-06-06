Config = {}

Config.Framework = "esx" -- "esx", "qb", or "qbox"
Config.Inventory = "ox"  -- "ox" or "qb"

-- set this to true if you are NOT using our UG keybinds script for other scripts already
-- in our keybinds script every keymap of every script is in one place
Config.EnableKeyMap = false

Config.TextUILabel = '[E] Car Wash\nUse /carwash'

-- Car wash
Config.CarWashDuration = 10000
Config.CarWashLabel = "Washing car..."
Config.CarWashSuccessLabel = "Your car is now clean"
Config.CarWashCancelLabel = "Car wash canceled"
Config.CarWashNotAtLocationLabel = "You are not at a car wash location"
Config.CarWashMustBeInVehicleLabel = "You must be in a vehicle"
Config.CarWashMustBeDriverLabel = "You must be the driver"

-- Cloth wash
Config.ClothWashTargetIcon = "fas fa-soap"
Config.ClothWashTargetLabel = "Clean vehicle"
Config.ClothWashDuration = 25000
Config.ClothWashLabel = "Cleaning car..."
Config.ClothWashSuccessLabel = "Vehicle cleaned"
Config.ClothWashCanceledLabel = "Cleaning canceled"

Config.Blip = {
    Sprite = 100,
    Color = 3,
    Scale = 0.70,
    Label = "Car Wash"
}

Config.CarWashLocations = {
    vector4(-699.7256, -933.0679, 18.4253, 358.7819),
    vector4(25.1381, -1391.9316, 28.6476, 90.1278)
}
