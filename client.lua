--DONT CHANGE THESE UNLESS YOU KNOW WHAT YOU ARE DOING
local menu, player, loadouts, access = nil, nil, Config.Loadouts, false
local cuffed, dragged, isdragging, plhplayer = false, false, false, 0

--Thread(s) to manage menu and handle permission setting upon script start. Also handles player actions.
Citizen.CreateThread(function()
    CreateMenu()

    while not NetworkIsPlayerActive(PlayerId()) do
        Wait(0)
    end
    RefreshPerms()

    while true do
        AllMenu()
        Wait(0)
    end
end)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        player = PlayerPedId()
        HandleDrag()
    end
end)
--End *Thread(s) to manage menu and handle permission setting upon script start. Also handles player actions.*


--Menu creation and permissions
RegisterNetEvent("accessresponse")
AddEventHandler("accessresponse", function(toggle)
    access = toggle
end)

function CreateMenu()
    menu = WarMenu.CreateMenu("policemenu", "Police Menu", "Options")
    WarMenu.CreateSubMenu('policeactions', "policemenu", 'Actions')
    WarMenu.CreateSubMenu('policeloadouts', "policemenu",'Loadouts')
end

function HandleMenu()
    WarMenu.MenuButton("Actions", "policeactions")
    WarMenu.MenuButton("Loadouts", "policeloadouts")
end

function AllMenu()
    if access then
        if WarMenu.IsAnyMenuOpened() then
            player = PlayerPedId()
            if WarMenu.IsMenuOpened("policeloadouts") then
                HandleLoadouts()
            elseif WarMenu.IsMenuOpened("policeactions") then
                HandleActions()
            elseif WarMenu.IsMenuOpened("policemenu") then
                HandleMenu()
            end
        end
        WarMenu.Display()
    end
end

function RefreshPerms()
    if NetworkIsPlayerActive(PlayerId()) then
        TriggerServerEvent("refreshscriptperms")
    end
end

RegisterCommand("openpm", function()
    if access then
        if not WarMenu.IsAnyMenuOpened() then
            WarMenu.OpenMenu("policemenu")
        end
    end
end)
--End *Menu creation and permissions*


--Loadout/Weapons
RegisterNetEvent("setloadout")
AddEventHandler("setloadout", function(loadout)
    loadouts = loadout
end)

function HandleLoadouts()
    for k, v in pairs(loadouts) do
        if v.access then
            if WarMenu.Button(v.name) then
                HandleWeapons(v.weapons)
            end
        end
    end
end

function HandleWeapons(weapons)
    RemoveAllPedWeapons(player, true)
    local spawn = weapons.spawn
    local attach = weapons.attachments
    if spawn then
        for k,v in pairs(spawn) do
            GiveWeaponToPed(player, GetHashKey(v.spawn), 9999, false, false)
            for i=1, #attach do
                local list = attach[i]
                for _,value in pairs(list) do
                    GiveWeaponComponentToPed(player, GetHashKey(v.spawn), GetHashKey(value))
                end
            end
        end
    else
        print("No weapons to spawn")
    end
end
--End *Loadout/Weapons*


--Actions
function PlayerCuffed()
	if not cuffed then
		ShowNotification("Player Cuffed")
		cuffed = true
	else
		ShowNotification("Player Uncuffed")
		dragged = false
		cuffed = false
		Citizen.Wait(100)
		ClearPedTasksImmediately(player)
	end
end

RegisterNetEvent('dragplayer')
AddEventHandler('dragplayer', function(otherplayer)
	if cuffed then
		isdragging = not isdragging
		plhplayer = tonumber(otherplayer)
		ShowNotification("Dragging Player")
	else
		ShowNotification("Dragging Player Stopped")
	end
end)

RegisterNetEvent('removeplayerweapons')
AddEventHandler('removeplayerweapons', function()
    RemoveAllPedWeapons(player, true)
end)

RegisterNetEvent('forceplayerintovehicle')
AddEventHandler('forceplayerintovehicle', function()
	if cuffed then
		local pos = GetEntityCoords(player)
		local playercoords = GetOffsetFromEntityInWorldCoords(player, 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, playercoords.x, playercoords.y, playercoords.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetPedIntoVehicle(player, vehicleHandle, 2)
		end
	end
end)

RegisterNetEvent('removeplayerfromvehicle')
AddEventHandler('removeplayerfromvehicle', function(otherplayer)
	local ped = GetPlayerPed(otherplayer)
	ClearPedTasksImmediately(ped)
	playercoords = GetEntityCoords(player, true)
	local xnew = playercoords.x+2
	local ynew = playercoords.y+2

	SetEntityCoords(player, xnew, ynew, playercoords.z)
end)

RegisterNetEvent('cuffplayer')
AddEventHandler('cuffplayer', PlayerCuffed)

function DisableControls()
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    --SetPedPathCanUseLadders(player, false)
end

function PlayerHandsup()
    ExecuteCommand("e handsup")
end

function PlayerSurrender()
    ExecuteCommand("e surrender")
end

function PlayerUncuffing()
    ExecuteCommand("e uncuff")
end

function PlayerCancelEmote()
    ExecuteCommand("e c")
end

function HandleDrag()
    Citizen.CreateThread(function()
        while cuffed or dragged or isdragging do
	    	Citizen.Wait(0)

	    	if cuffed == true then
	    		RequestAnimDict('mp_arresting')
	    		while not HasAnimDictLoaded('mp_arresting') do
                    Citizen.Wait(0)
	    		end

	    		while IsPedBeingStunned(player, false) do
	    			ClearPedTasksImmediately(player)
	    		end
	    		TaskPlayAnim(player, 'mp_arresting', 'idle', 8.0, -8, -1, 16, 0, 0, 0, 0)
                DisableControls()
	    	end

	    	if IsPlayerDead(PlayerPedId()) then
	    		cuffed = false
	    		isdragging = false
                dragged = false
	    	end

	    	if isdragging then
	    		local ped = GetPlayerPed(GetPlayerFromServerId(plhplayer))
	    		AttachEntityToEntity(player, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	    		dragged = true
	    	else
	    		if not IsPedInParachuteFreeFall(player) and dragged then
	    			dragged = false
	    			DetachEntity(player, true, false)
	    		end
	    	end
	    end
    end)
end


function GetPlayers()
	local players = {}
	for i, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		table.insert(players, player)
	end
	return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance,closestPlayer = -1, -1
	local playercoords = GetEntityCoords(player, 0)
	
	for i,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= player) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], playercoords.x, playercoords.y, playercoords.z)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end

function RemoveWeapons()
    local closeplayer, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("removeplayerweapons", GetPlayerServerId(closeplayer))
    else
        ShowNotification("Error: No Player Near")
    end
end

function ToggleCuffs()
	local closeplayer, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("cuffplayer", GetPlayerServerId(closeplayer))
		ShowNotification("Player Cuffed")
	else
		ShowNotification("Error: No Player Near")
	end
end

function ToggleDrag()
	local closeplayer, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("dragplayer", GetPlayerServerId(closeplayer))
	else
		ShowNotification("Error: No Player Near")
	end
	
end

function PutInVehicle()
	local closeplayer, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("forceplayerintovehicle", GetPlayerServerId(closeplayer))
	else
		ShowNotification("Error: No Player Near")
	end
end

function UnseatVehicle()
	local closeplayer, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("removeplayerfromvehicle", GetPlayerServerId(closeplayer))
	else
		ShowNotification("Error: No Player Near")
	end
end

function HandleActions()
    if WarMenu.Button('Cuff Suspect') then
        ToggleCuffs()
    elseif WarMenu.Button('Drag Suspect') then
        ToggleDrag()
    elseif WarMenu.Button('Place in Vehicle') then
        PutInVehicle()
    elseif WarMenu.Button('Remove From Vehicle') then
        UnseatVehicle()
    elseif WarMenu.Button('Remove Weapons') then
        RemoveWeapons()
    elseif WarMenu.Button('Drop Spike') then
        ToggleSpikes()
    end
end


RegisterCommand("hu", PlayerHandsup)
RegisterCommand("handsup", PlayerHandsup)
RegisterCommand("surrender", PlayerSurrender)
RegisterCommand("kneel", PlayerSurrender)
RegisterCommand("k", PlayerSurrender)
--End *Actions*


--Registers Keymapping to open Police Menu
RegisterKeyMapping("openpm", "Open Police Menu", "keyboard", "F9")