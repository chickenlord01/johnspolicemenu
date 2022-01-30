--Handles all permissions
function HandleLoadoutPerms(ident)
    local placeholderloadout = Config.Loadouts
    for i,v in pairs(placeholderloadout) do
        Wait(2)
        if v.access ~= true then
            for k,value in ipairs(v.perms) do
                if ident == value then
                    placeholderloadout[i].access = true
                end
            end
        end
    end
    return placeholderloadout
end

function Access(ident, source)
	for i,player in ipairs(Config.Accesslist) do
		if player == ident then
			TriggerClientEvent("accessresponse", source, true)
            local plh = HandleLoadoutPerms(ident)
            TriggerClientEvent("setloadout", source, plh)
            break
		end
	end
end

RegisterNetEvent("refreshscriptperms")
AddEventHandler("refreshscriptperms", function()
    local _source = source
    local steam

    for k,v in pairs(GetPlayerIdentifiers(_source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steam = v
          break
        end
    end

    if steam then
        Access(steam, _source)
    end
end)
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