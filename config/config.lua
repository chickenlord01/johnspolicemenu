Config = {}

--Toggles actions true/false
Config.Actions = {
	cuffing = true,
	dragging = true,
	removefromvehicle = true,
	removeweapons = true,
	spikes = true
}

--If any of these are toggled to true use ace permissions for the commands EX: add_ace identifier.steam:1100001155f7f59 command.cuff allow #John
Config.ActionCommands = {
	cuffing = true,  --Permission (command.cuff)
	dragging = true, --Permission (command.drag)
	spikes = true    --Permission (command.spikes)
}

--You can add more command strings to this. For example /hu is "hu" in the handsup list.
Config.Commands = {
	handsup = {
		"hu",
		"handsup",
	},
	kneel = {
		"k",
		"kneel",
		"surrender",
	}
}

--Configuration for loadouts
Config.Loadouts = {
	["sheriff"] = {
		name = "Sheriff Loadout",
		access = true,
		weapons = {
			spawn = {
				WEAPON_COMBATPISTOL,
				WEAPON_NIGHTSTICK,
				WEAPON_FLASHLIGHT,
				WEAPON_STUNGUN,
				WEAPON_CARBINERIFLE,
				WEAPON_PUMPSHOTGUN,
				WEAPON_FLARE
			},
			attachments = {
				WEAPON_COMBATPISTOL.flashlight,
				WEAPON_PUMPSHOTGUN.flashlight,
				WEAPON_CARBINERIFLE.flashlight,
				WEAPON_CARBINERIFLE.sight,
				WEAPON_CARBINERIFLE.grip,
			}
		},
	},
	["sru"] = {
		name = "SRU Loadout",
		access = false,
		weapons = {
			spawn = {
				WEAPON_HEAVYPISTOL,
				WEAPON_KNIFE
			},
			attachments = {
				WEAPON_HEAVYPISTOL.flashlight
			}
		},
	},
}

--Don't touch unless you know what you are doing.
Config.AceAccessPerm = "policemenu.open"

--Sets key to open menu
Config.MenuKey = "F9"

--Shows notification
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end



--Turns commands off if actions are off (Delete this if you dont want the commands and actions to be linked)
if not Config.Actions.cuffing then
	Config.ActionCommands.cuffing = false
end
if not Config.Actions.dragging then
	Config.ActionCommands.dragging = false
end
if not Config.Actions.spikes then
	Config.ActionCommands.spikes = false
end
--End Delete