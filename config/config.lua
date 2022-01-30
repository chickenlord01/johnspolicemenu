Config = {}

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
				[1] = {
					WEAPON_COMBATPISTOL.flashlight,
					WEAPON_PUMPSHOTGUN.flashlight,
					WEAPON_CARBINERIFLE.flashlight,
					WEAPON_CARBINERIFLE.sight,
					WEAPON_CARBINERIFLE.grip,
				},
				[2] = {}
			}
		},
		perms = {},
	},
	["sru"] = {
		name = "SRU Loadout",
		access = false,
		weapons = {
			WEAPON_HEAVYPISTOL,
			WEAPON_KNIFE
		},
		attachments = {
			[1] = {
				WEAPON_HEAVYPISTOL.flashlight
			},
			[2] = {}
		},
		perms = {
			"steam:1100001155f7f59",    --John
		},
	},
}

Config.Accesslist = {
	"steam:1100001155f7f59",   --John
}


--Shows notification
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end