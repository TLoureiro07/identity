local loadingScreenFinished = false
local ready = false
local guiEnabled = false
nuiLoaded = false

RegisterNetEvent('esx_identity:alreadyRegistered', function()
    while not loadingScreenFinished do Wait(100) end
    TriggerEvent('esx_skin:playerRegistered')
end)



Citizen.CreateThread(function()
    while not nuiLoaded do
        Citizen.Wait(0)
    end

    SendNUIMessage({type = "set_translation", Translation = Config.Translation})

end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1000)
--         SendNUIMessage({
--             type = "CHECK_NUI_READY",
--         })
--         if nuiLoaded then
--             return
--         end
--     end
-- end)

RegisterNetEvent('esx_identity:setPlayerData')
AddEventHandler('esx_identity:setPlayerData', function(data)
    SetTimeout(1, function()
         ESX.SetPlayerData("name", ('%s %s'):format(data.firstName, data.lastName))
         ESX.SetPlayerData('firstName', data.firstName)
         ESX.SetPlayerData('lastName', data.lastName)
         ESX.SetPlayerData('dateofbirth', data.dateOfBirth)
         ESX.SetPlayerData('sex', data.sex)
         ESX.SetPlayerData('height', data.height)
    end)
end)

AddEventHandler('esx:loadingScreenOff', function()
    loadingScreenFinished = true
end)

RegisterNUICallback('ready', function(data, cb)
    nuiLoaded = true
    cb(1)
end)



function EnableGui(state)
    while not loadingScreenFinished do Wait(100) end

    while not nuiLoaded do
        Citizen.Wait(0)
    end
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(0)
    end
    SetNuiFocus(state, state)
    guiEnabled = state


    SendNUIMessage({type = "enableui", enable = state, Translation = Config.Translation,  Logo = Config.Logo, maxValues = {
        MaxNameLength = Config.MaxNameLength,
        MinHeight = Config.MinHeight,
        MaxHeight = Config.MaxHeight,
        LowestYear = Config.LowestYear,
        HighestYear = Config.HighestYear,
    }})

    if state then
        ESX.TriggerServerCallback('esx_identity:GetPlayerAvatar', function(callback)
            SendNUIMessage({type = "setdiscord", image = callback})
        end, 'male')
    end


end


RegisterNUICallback('GenderChange', function(data, cb)
    local sex = data.sex
    ESX.TriggerServerCallback('esx_identity:GetPlayerAvatar', function(callback)
        SendNUIMessage({type = "setdiscord", image = callback})
    end, sex)
    cb("ok")
end)

RegisterNetEvent('esx_identity:showRegisterIdentity', function()
    TriggerEvent('esx_skin:resetFirstSpawn')
    if not ESX.PlayerData.dead then
         EnableGui(true) 
         --TriggerScreenblurFadeIn(1000)
    end
end)
RegisterNUICallback('register', function(data, cb)
    ESX.TriggerServerCallback('esx_identity:registerIdentity', function(callback)
        if callback then
            ESX.ShowNotification(Config.Translation.NotifWelcome)
            EnableGui(false)
            --TriggerScreenblurFadeOut(1000)
            if not ESX.GetConfig().Multichar then
                if  Config.CharCreator == 'vms_charcreator' then
                    TriggerEvent('vms_charcreator:openCreator', data.sex)
                elseif Config.CharCreator == 'esx_skin' then
                    TriggerEvent('esx_skin:playerRegistered')
                elseif Config.CharCreator == 'fivem-appearance' then
                    local config = {
                        ped = true,
                        headBlend = true,
                        faceFeatures = true,
                        headOverlays = true,
                        components = true,
                        props = true,
                        allowExit = true,
                        tattoos = true
                    }
                    
                    exports['fivem-appearance']:startPlayerCustomization(function (appearance)
                        if (appearance) then
                        print('Saved')
                        else
                        print('Canceled')
                        end
                    end, config)
                end
            end
        end
    end, data)
end)
CreateThread(function()
    while true do
        local sleep = 1500
        if guiEnabled then
            sleep = 0
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 30, true) -- MoveLeftRight
            DisableControlAction(0, 31, true) -- MoveUpDown
            DisableControlAction(0, 21, true) -- disable sprint
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(0, 47, true) -- disable weapon
            DisableControlAction(0, 58, true) -- disable weapon
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 75, true) -- disable exit vehicle
            DisableControlAction(27, 75, true) -- disable exit vehicle
        else
            sleep = 1500
        end
        Wait(sleep)
    end
end)