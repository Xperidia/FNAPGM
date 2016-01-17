DeriveGamemode( "fnafgm" )

--[[ Base config ]]--

GM.Name 	= "Five Nights at Pinkie's"
GM.ShortName = "FNAPGM"
GM.Author 	= "Xperidia"
GM.Email 	= "contact@Xperidia.com"
GM.Website 	= "http://go.Xperidia.com/FNAPGM"

GM.Version 	= 1.08
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
end)

GM.Sound_end = {
	fnap_scc = Sound("fnafsounds/musicbox.ogg")
}

GM.Sound_Calls = {
	fnap_scc = { "fnapgm/call_1.ogg", "fnapgm/call_2.ogg", "fnapgm/call_3.ogg", "fnapgm/call_4.ogg", "fnapgm/call_5.ogg" }
}

GM.SecurityRoom = {
	fnap_scc = { Vector(-510,-125,26), Vector(-334,-372,170), Vector(-510,-125,26), Vector(-195,-258,170) }
}

GM.DeadBodiesTeleport = {
	fnap_scc = { Vector(200, 432, 96) }
}

GM.FNaFView = {
	fnap_scc = { Vector( -465, -255, 32 ), Angle( 0, 0, 0 ), Angle( 0, 58, 0 ), Angle( 0, -58, 0 ) }
}

GM.Materials_intro = {
	fnap_scc = { en = "fnapgm/intro_fnap_scc", fr = "fnapgm/intro_fnap_scc_fr" }
}

GM.Materials_end = {
	fnap_scc = { "fnapgm/end_fnap_scc", "fnapgm/end_fnap_scc_6" }
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
	fnap_scc = "Sugar Cube Corner"
}

GM.MapListLinks = {
	fnap_scc = "http://go.Xperidia.com/FNAP_SCC"
}

function GM:CheckDerivCreator(pl)
	if (pl:SteamID()=="STEAM_0:1:33606814" or pl:SteamID()=="STEAM_0:0:59390945") then
		return true
	end
	return false
end