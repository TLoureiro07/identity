RegisterServerEvent('codem-identity:server:ShowIdentity')
AddEventHandler('codem-identity:server:ShowIdentity', function(targetId, data, type)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        if data == nil then
            data = {}
        end
        local identifier = xPlayer.identifier
        if Config.EnableDiscordImages then
            data.discordImage = GetDiscordAvatar(src)
        else
            local gender = data.gender
            if gender == 'm' then
                data.discordImage = Config.MaleDefaultImage
            else
                data.discordImage = Config.FemaleDefaultImage
            end
        end
        data.firstname = xPlayer.get('firstName')
        data.lastname = xPlayer.get('lastName')
        data.gender = xPlayer.get('sex')
        data.height = xPlayer.get('height')
        data.dob = xPlayer.get('dateofbirth')

        if type == 'driver_license' then
            MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = ?', {identifier}, function (licenses)
                local licensesText = ''
                for i=1, #licenses, 1 do
                    if licenses[i].type == 'drive_bike' then
                        licensesText =  licensesText .. Config.Translation["BIKE_LICENSE_CLASS"]..' '
                    end
                    if licenses[i].type == 'drive' then
                        licensesText =  licensesText .. Config.Translation["VEHICLE_LICENSE_CLASS"]..' '
                    end
                    if licenses[i].type == 'drive_truck' then
                        licensesText =  licensesText .. Config.Translation["TRUCK_LICENSE_CLASS"]..' '
                    end
                end
                data.licensesText = licensesText


                TriggerClientEvent('codem-identity:client:ShowIdentity', targetId, type, data)
            end)
        else
            TriggerClientEvent('codem-identity:client:ShowIdentity', targetId, type, data)
        end
    end
end)