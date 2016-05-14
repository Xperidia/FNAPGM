DeriveGamemode( "fnafgm" )

--[[ Base config ]]--

GM.Name 	= "Five Nights at Pinkie's"
GM.ShortName = "FNAPGM"
GM.Author 	= "Xperidia"
GM.Email 	= "contact@Xperidia.com"
GM.Website 	= "http://go.Xperidia.com/FNAPGM"

GM.Version 	= 1.19
GM.CustomVersionChecker = "http://xperidia.com/fnapgmversion.txt"

for _, gamemodec in pairs(engine.GetGamemodes()) do
	
	if gamemodec.name=="fnafgm" then
		fnafgmishere=true
	end
	
end

if !fnafgmishere then
	if SERVER then
		PrintMessage(HUD_PRINTTALK, "FNAFGM is not detected!")
		hook.Add( "PlayerSpawn", "fnafgmnotdetected", function() PrintMessage(HUD_PRINTTALK, "FNAFGM is not detected!") end )
		Error( "FNAFGM is not detected!\n" )
	end
end

hook.Add( "Initialize", "fnapgmInit", function()
	GAMEMODE.Strings.en.fnap_scc = "Turn off the main power to start the night"
	GAMEMODE.Strings.fr.fnap_scc = "Coupez le courant pour démarrer la nuit"
	GAMEMODE.Strings.ru.fnap_scc = "Выключите главное питание, чтобы начать ночь" --Translation by http://steamcommunity.com/profiles/76561198135819236
	GAMEMODE.Strings.uk.fnap_scc = "Вимкніть головне живлення, щоб почати ніч" --Translation by http://steamcommunity.com/profiles/76561198135819236
	local fuckWubsy = true
end)

GM.Sound_end = {
	fnap_scc = Sound("fnafsounds/musicbox.ogg")
}

GM.Sound_Calls = {
	fnap_scc = { "fnapgm/call_1.ogg", "fnapgm/call_2.ogg", "fnapgm/call_3.ogg", "fnapgm/call_4.ogg", "fnapgm/call_5.ogg" }
}

GM.SecurityRoom = {
	fnap_scc = { Vector(-510,-125,26), Vector(-334,-372,170), Vector(-510,-125,26), Vector(-195,-258,170) },
	fnap_cb = { Vector(144,-80,339), Vector(337,-319,210) }
}

GM.DeadBodiesTeleport = {
	fnap_scc = { Vector(200, 432, 96) },
	fnap_cb = { Vector(177, -224, 144) }
}

GM.FNaFView = {
	fnap_scc = { Vector( -465, -255, 32 ), Angle( 0, 0, 0 ), Angle( 0, 58, 0 ), Angle( 0, -58, 0 ) },
	fnap_cb = { Vector( 256, -272, 272 ), Angle( 0, 90, 0 ), Angle( 0, 128, 0 ), Angle( 0, 50, 0 ) }
}

GM.Models_dead = {}

GM.CamsNames = {
	fnap_scc_1 = "Kitchen",
	fnap_scc_2 = "Stage",
	fnap_scc_3 = "Dining Area",
	fnap_scc_4 = "Entrance",
	fnap_scc_5 = "North Hall B",
	fnap_scc_6 = "Bath-Rooms",
	fnap_scc_7 = "North Hall A",
	fnap_scc_8 = "Pinkie's Bedroom",
	fnap_scc_9 = "Storage",
	fnap_scc_10 = "Supply Room",
	fnap_scc_11 = "Trash",
	fnap_scc_12 = "Cave",
	fnap_scc_13 = "Storage",
	fnap_scc_14 = "Generator"
}

GM.MapList = {
	fnap_scc = "Sugar Cube Corner",
	fnap_cb = "Carousel Boutique"
}

GM.MapListLinks = {
	fnap_scc = "http://go.Xperidia.com/FNAP_SCC"
	--fnap_cb = ""
}

GM.Animatronic = {}
GM.Animatronic.Pinkie = 11
GM.Animatronic.Fluttershy = 12
GM.Animatronic.Twilight = 13
GM.Animatronic.Rarity = 14
GM.Animatronic.Applejack = 15
GM.Animatronic.RainbowDash = 16
GM.Animatronic.ToyPinkie = 17
GM.Animatronic.ToyFluttershy = 18
GM.Animatronic.ToyTwilight = 19
GM.Animatronic.Discord = 20
GM.Animatronic.Spike = 21

GM.AnimatronicName = {}
GM.AnimatronicName[11] = "Pinkie Pie"
GM.AnimatronicName[12] = "Fluttershy"
GM.AnimatronicName[13] = "Twilight"
GM.AnimatronicName[14] = "Rarity"
GM.AnimatronicName[15] = "Applejack"
GM.AnimatronicName[16] = "Rainbow Dash"
GM.AnimatronicName[17] = "Toy Pinkie Pie"
GM.AnimatronicName[18] = "Toy Fluttershy"
GM.AnimatronicName[19] = "Toy Twilight"
GM.AnimatronicName[20] = "Discord"
GM.AnimatronicName[21] = "Spike"

GM.Animatronic_Models = {}
GM.Animatronic_Models[GM.Animatronic.Pinkie] = {}
GM.Animatronic_Models[GM.Animatronic.Pinkie].fnap_scc = Model("models/brokenmlpanimatronics/pinkie_pie.mdl")
GM.Animatronic_Models[GM.Animatronic.Pinkie].fnap_cb = Model("models/brokenmlpanimatronics/pinkie_pie.mdl")

--[[GM.APos = {}
GM.APos.fnap_cb = {
	
}]]


function GM:CheckDerivCreator(pl)
	if (pl:SteamID()=="STEAM_0:1:33606814" or pl:SteamID()=="STEAM_0:0:59390945") then
		return true
	end
	return false
end