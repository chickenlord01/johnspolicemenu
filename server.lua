--Handles all permissions
function HandleLoadoutPerms(_source)
    local placeholderloadout = Config.Loadouts
    for i,v in pairs(placeholderloadout) do
        Wait(2)
        if v.access ~= true then
            if IsPlayerAceAllowed(_source, "policemenu."..i) then
                placeholderloadout[i].access = true
            end
        end
    end
    return placeholderloadout
end

function Access()
    local _source = source
    local allowed = IsPlayerAceAllowed(_source, Config.AceAccessPerm)
	TriggerClientEvent("accessresponse", _source, allowed)
    if allowed then
        local plh = HandleLoadoutPerms(_source)
        TriggerClientEvent("setloadout", _source, plh)
    end
end

RegisterNetEvent("refreshscriptperms")
AddEventHandler("refreshscriptperms", Access)
--End *Handles all permissions*


--Action server sync
RegisterServerEvent('cuffplayer')
AddEventHandler('cuffplayer', function(player)
	TriggerClientEvent('cuffplayer', player)
end)

RegisterServerEvent('dragplayer')
AddEventHandler('dragplayer', function(player)
	TriggerClientEvent('dragplayer', player, source)
end)

RegisterServerEvent('forceplayerintovehicle')
AddEventHandler('forceplayerintovehicle', function(player)
	TriggerClientEvent('forceplayerintovehicle', player)
end)

RegisterServerEvent('removeplayerfromvehicle')
AddEventHandler('removeplayerfromvehicle', function(player)
	TriggerClientEvent('removeplayerfromvehicle', player)
end)

RegisterServerEvent('searchplayer')
AddEventHandler('searchplayer', function(player)
	TriggerClientEvent('searchplayer', player, source)
end)

RegisterServerEvent('removeplayerweapons')
AddEventHandler('removeplayerweapons', function(player)
	TriggerClientEvent("removeplayerweapons", player)
end)
--End *Action server sync*