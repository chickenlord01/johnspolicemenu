Config = {}

Config.Actions = {
	cuffing = true,
	dragging = true,
	removefromvehicle = true,
	removeweapons = true,
	spikes = true
}

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


--Shows notification
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end