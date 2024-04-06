local open = false
function ShowIdentity(type, data)
    SendNUIMessage({type = "openidentity", identityType = type, data = data})
    open = true
end


RegisterKeyMapping('hideidcard', 'hide id card', 'keyboard', "ESCAPE")
RegisterCommand('hideidcard', function()
    if open then
        SendNUIMessage({
            type = "hide"
        })
        open = false
    end
end)


RegisterNetEvent('stoned-identity:client:ShowIdentity')
AddEventHandler('stoned-identity:client:ShowIdentity', function(type, data)
    ShowIdentity(type, data)
end)
Citizen.CreateThread(function()


        RegisterNetEvent('stoned-identity:client:ShowCivilianIdentity')
        AddEventHandler('stoned-identity:client:ShowCivilianIdentity', function()

            local player, distance = ESX.Game.GetClosestPlayer()

            if  player ~= -1 and distance <= 3.0 then
                TriggerServerEvent('stoned-identity:server:ShowIdentity', GetPlayerServerId(player), {

                },'civilian')
            end
        end)
        RegisterNetEvent('stoned-identity:client:CheckCivilianIdentity')
        AddEventHandler('stoned-identity:client:CheckCivilianIdentity', function()

            TriggerServerEvent('stoned-identity:server:ShowIdentity', GetPlayerServerId(PlayerId()), {

            },'civilian')
        end)

end)
