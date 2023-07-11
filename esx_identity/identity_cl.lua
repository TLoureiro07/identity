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


RegisterNetEvent('codem-identity:client:ShowIdentity')
AddEventHandler('codem-identity:client:ShowIdentity', function(type, data)
    ShowIdentity(type, data)
end)
Citizen.CreateThread(function()

    if Config.IdCards.enableCivilIdCard then
        RegisterNetEvent('codem-identity:client:ShowCivilianIdentity')
        AddEventHandler('codem-identity:client:ShowCivilianIdentity', function()

            local player, distance = ESX.Game.GetClosestPlayer()

            if  player ~= -1 and distance <= 3.0 then
                TriggerServerEvent('codem-identity:server:ShowIdentity', GetPlayerServerId(player), {

                },'civilian')
            end
        end)
        RegisterNetEvent('codem-identity:client:CheckCivilianIdentity')
        AddEventHandler('codem-identity:client:CheckCivilianIdentity', function()

            TriggerServerEvent('codem-identity:server:ShowIdentity', GetPlayerServerId(PlayerId()), {

            },'civilian')
        end)
        RegisterCommand(Config.IdCards.civilIdCardCommand, function()
            TriggerEvent('codem-identity:client:ShowCivilianIdentity')
        end)
        RegisterCommand(Config.IdCards.checkCivilIdCardCommand, function()
            TriggerEvent('codem-identity:client:CheckCivilianIdentity')
        end)
    end
    if Config.IdCards.enableEmsIdCard then
        RegisterNetEvent('codem-identity:client:ShowEMSIdentity')
        AddEventHandler('codem-identity:client:ShowEMSIdentity', function()
            local job_grade = ESX.GetPlayerData().job.grade_label
            local job_name = ESX.GetPlayerData().job.name

            local player, distance = ESX.Game.GetClosestPlayer()

            if job_name == 'ambulance' and player ~= -1 and distance <= 3.0 then
                TriggerServerEvent('codem-identity:server:ShowIdentity', GetPlayerServerId(player), {
                    job_grade = job_grade,

                },'ems')
            end
        end)
        RegisterNetEvent('codem-identity:client:CheckEMSIdentity')
        AddEventHandler('codem-identity:client:CheckEMSIdentity', function()
            local job_grade = ESX.GetPlayerData().job.grade_label
            local job_name = ESX.GetPlayerData().job.name

            if job_name == 'ambulance' then
                TriggerServerEvent('codem-identity:server:ShowIdentity', GetPlayerServerId(PlayerId()), {
                    job_grade = job_grade,
                },'ems')
            end
        end)

        RegisterCommand(Config.IdCards.emsIdCardCommand, function()
            TriggerEvent('codem-identity:client:ShowEMSIdentity')
        end)

        RegisterCommand(Config.IdCards.checkEmsIdCardCommand, function()
            TriggerEvent('codem-identity:client:CheckEMSIdentity')
        end)
    end
    if Config.IdCards.enableDriverLicense then
        RegisterNetEvent('codem-identity:client:ShowDrivingLicense')
        AddEventHandler('codem-identity:client:ShowDrivingLicense', function()
            local firstname = ESX.GetPlayerData().firstName
            local lastname = ESX.GetPlayerData().lastName
            local gender = ESX.GetPlayerData().sex
            local height = ESX.GetPlayerData().height
            local dob = ESX.GetPlayerData().dateofbirth
            local player, distance = ESX.Game.GetClosestPlayer()

            if  player ~= -1 and distance <= 3.0 then
                TriggerServerEvent('codem-identity:server:ShowIdentity', GetPlayerServerId(player), {
                    firstname = firstname,
                    lastname = lastname,
                    gender = gender,
                    height = height,
                    dob = dob,
                },'driver_license')
            end
        end)

        RegisterNetEvent('codem-identity:client:CheckDrivingLicense')
        AddEventHandler('codem-identity:client:CheckDrivingLicense', function()
            local firstname = ESX.GetPlayerData().firstName
            local lastname = ESX.GetPlayerData().lastName
            local gender = ESX.GetPlayerData().sex
            local height = ESX.GetPlayerData().height
            local dob = ESX.GetPlayerData().dateofbirth

            TriggerServerEvent('codem-identity:server:ShowIdentity', GetPlayerServerId(PlayerId()), {
                firstname = firstname,
                lastname = lastname,
                gender = gender,
                height = height,
                dob = dob,
            },'driver_license')
        end)
        RegisterCommand(Config.IdCards.driverLicenseCommand, function()
            TriggerEvent('codem-identity:client:ShowDrivingLicense')
        end)
        RegisterCommand(Config.IdCards.checkDriverLicenseCommand, function()
            TriggerEvent('codem-identity:client:CheckDrivingLicense')
        end)
    end
end)
