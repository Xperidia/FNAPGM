DeriveGamemode( "fnafgm" )

--[[ Base config ]]--

GM.Name 	= "Five Nights at Pinkie's"
GM.ShortName = "FNAPGM"
GM.Author 	= "Xperidia"
GM.Email 	= "contact@Xperidia.com"
GM.Website 	= "http://go.Xperidia.com/FNAPGM"

GM.Version 	= 1.44
GM.CustomVersionChecker = "http://xperidia.com/fnapgmversion.txt"

if game.GetMap()=="fnap_cb" then
	GM.FT = 2
end

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
	
	table.Empty(GAMEMODE.Models_dead)
	
	-- GAMEMODE.Strings.en.fnap_scc = "Turn off the main power to start the night" --This is not used anymore!
	-- GAMEMODE.Strings.fr.fnap_scc = "Coupez le courant pour démarrer la nuit"
	-- GAMEMODE.Strings.ru.fnap_scc = "Выключите главное питание, чтобы начать ночь" --Translation by http://steamcommunity.com/profiles/76561198135819236
	-- GAMEMODE.Strings.uk.fnap_scc = "Вимкніть головне живлення, щоб почати ніч" --Translation by http://steamcommunity.com/profiles/76561198135819236
	
	sound.Add( {
		name = "fnapgm_applejackscream",
		channel = CHAN_AUTO,
		volume = 0.8,
		level = 0,
		sound = "fnafsounds/applejackscream.wav"
	} )
	sound.Add( {
		name = "fnapgm_officesnd",
		channel = CHAN_AUTO,
		volume = 0.2,
		level = 0,
		sound = "fnafsounds/walkpony.wav"
	} )
	sound.Add( {
		name = "fnapgm_rarityknock",
		channel = CHAN_AUTO,
		volume = 0.2,
		level = 0,
		sound = "fnafsounds/knockwindow.wav"
	} )
	sound.Add( {
		name = "fnapgm_pinkiescare",
		channel = CHAN_AUTO,
		volume = 0.8,
		level = 0,
		sound = "fnafsounds/pinkieisscary.wav"
	} )
	sound.Add( {
		name = "fnapgm_runrainbowdash",
		channel = CHAN_AUTO,
		volume = 0.8,
		level = 0,
		sound = "fnafsounds/runrainbowdash.wav"
	} )
	sound.Add( {
		name = "fnapgm_rainbowknock",
		channel = CHAN_AUTO,
		volume = 0.8,
		level = 0,
		sound = "physics/metal/metal_barrel_impact_hard1.wav"
	} )
	
end)

GM.Sound_end = {
	fnap_scc = Sound("fnafsounds/musicbox.ogg")
}

GM.Sound_Calls = {
	fnap_scc = { "fnapgm/call_1.ogg", "fnapgm/call_2.ogg", "fnapgm/call_3.ogg", "fnapgm/call_4.ogg", "fnapgm/call_5.ogg" }
}

GM.Sound_Animatronic = {}
GM.Sound_Animatronic[11] = { Sound("fnapgm/laught1.ogg"), Sound("fnapgm/laught2.ogg"), Sound("fnapgm/laught3.ogg"), Sound("fnapgm/laught4.ogg") }

GM.SecurityRoom = {
	fnap_scc = { Vector(-510,-372,26), Vector(-334,-125,170), Vector(-510,-258,26), Vector(-195,-125,170) },
	fnap_cb = { Vector(144,-80,339), Vector(337,-319,210) }
}

GM.DeadBodiesTeleport = {
	fnap_scc = { Vector(200, 432, 96) },
	fnap_cb = { Vector(177, -224, 144) }
}

GM.FNaFView = {
	fnap_scc = { Vector( -465, -255, 32 ), Angle( 0, 0, 0 ), Angle( 0, 58, 0 ), Angle( 0, -58, 0 ) },
	fnap_cb = { Vector( 256, -272, 208 ), Angle( 0, 90, 0 ), Angle( 0, 128, 0 ), Angle( 0, 50, 0 ) }
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
	fnap_scc_14 = "Generator",
	fnap_scc_16 = "Office",
	fnap_scc_17 = "Staff",
	fnap_scc_18 = "Staff Door",
	fnap_scc_19 = "Kitchen Door",
	fnap_scc_20 = "Entrance Door",
	fnap_cb_1 = "Stage",
	fnap_cb_2 = "Main Hall",
	fnap_cb_3 = "Backroom",
	fnap_cb_4 = "Storage",
	fnap_cb_5 = "Kitchen",
	fnap_cb_6 = "Supply Room",
	fnap_cb_7 = "Stairs",
	fnap_cb_8 = "Rarity's Bedroom",
	fnap_cb_9 = "Left Vent",
	fnap_cb_10 = "Right Vent",
	fnap_cb_11 = "Office"
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
GM.Animatronic_Models[GM.Animatronic.Pinkie].fnap_scc = Model("models/wubsy/pinkie_pie.mdl")
GM.Animatronic_Models[GM.Animatronic.Pinkie].fnap_cb = Model("models/brokenmlpanimatronics/pinkie_pie.mdl")
GM.Animatronic_Models[GM.Animatronic.Fluttershy] = {}
GM.Animatronic_Models[GM.Animatronic.Fluttershy].fnap_scc = Model("models/wubsy/fluttershy.mdl")
GM.Animatronic_Models[GM.Animatronic.Twilight] = {}
GM.Animatronic_Models[GM.Animatronic.Twilight].fnap_scc = Model("models/wubsy/twilight.mdl")
GM.Animatronic_Models[GM.Animatronic.Rarity] = {}
GM.Animatronic_Models[GM.Animatronic.Rarity].fnap_scc = Model("models/wubsy/rarity.mdl")
GM.Animatronic_Models[GM.Animatronic.Applejack] = {}
GM.Animatronic_Models[GM.Animatronic.Applejack].fnap_scc = Model("models/wubsy/appplejack.mdl")
GM.Animatronic_Models[GM.Animatronic.RainbowDash] = {}
GM.Animatronic_Models[GM.Animatronic.RainbowDash].fnap_scc = Model("models/wubsy/rainbow_dash.mdl")

GM.APos = {}
GM.APos.fnap_scc = {
	Kitchen = 1,
	SS = 2,
	DA = 3,
	Entrance = 4,
	NHB = 5,
	BR = 6,
	NHA = 7,
	Pinkie = 8,
	StorageT = 9,
	SR = 10,
	Trash = 11,
	Cave = 12,
	StorageD = 13,
	Generator = 14,
	Office = 16,
	StaffD = 17,
	Staff = 18,
	Kitchen2 = 19,
	EntranceD = 20
}
GM.APos.fnap_cb = {
	SS = 1,
	MH = 2,
	BR = 3,
	Storage = 4,
	Kitchen = 5,
	SR = 6,
	Stairs = 7,
	Rarity = 8,
	LV = 9,
	RV = 10,
	Office = 11
}

GM.ASSEye = {}
GM.ASSEye.fnap_scc = Vector(62, -22, 96)
GM.ASSEye.fnap_cb = Vector(-12, -240, 128)

GM.AnimatronicAPos = {}
GM.AnimatronicAPos[GM.Animatronic.Pinkie] = {}
GM.AnimatronicAPos[GM.Animatronic.Fluttershy] = {}
GM.AnimatronicAPos[GM.Animatronic.Twilight] = {}
GM.AnimatronicAPos[GM.Animatronic.Rarity] = {}
GM.AnimatronicAPos[GM.Animatronic.Applejack] = {}
GM.AnimatronicAPos[GM.Animatronic.RainbowDash] = {}

GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc = {}
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.SS] = { Vector(64.193, 139.1, 90.3044), Angle(0,270,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.NHA] = { Vector(-341.436, 299.512, 32.031250), Angle(0,-173,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Pinkie] = { Vector(-374.231, 426.545, 32.9537), Angle(0,213,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.SR] = { Vector(242.611, 470.115, 79.554), Angle(0,300,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Cave] = { Vector(260.138, -331.65, -98.2724), Angle(0,220,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Generator] = { Vector(-342.764, -257.734, -96.1159), Angle(0,75,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Office] = { Vector(-427.235, -416.156, 32), Angle(0,90,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.StaffD] = { Vector(-227.427, -428.674, 31.1774), Angle(0,150,0) }
GM.AnimatronicAPos[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Staff] = { Vector(-377.114, -451.607, 31.3187), Angle(0,135,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc = {}
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Kitchen] = { Vector(-207.467, 39.4443, 32.031250), Angle(0,234,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.SS] = { Vector(146.607, 129.722, 63.4359), Angle(0,237,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.DA] = { Vector(-35.0655, -378.776, 32.031250), Angle(0,113,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Entrance] = { Vector(468.435, -473.789, 32.031250), Angle(0,150,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.BR] = { Vector(441.505, 79.8756, 32.031250), Angle(0,115,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.NHA] = { Vector(-81.9206, 287.78, 32.031250), Angle(0,180,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.StorageT] = { Vector(-79.3985, 456.384, 32.031250), Angle(0,240,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Cave] = { Vector(214.599, -292.129, -91.8968), Angle(0,243,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Office] = { Vector(-434.534, -78.391, 32.031250), Angle(0,270,0) }
GM.AnimatronicAPos[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Kitchen2] = { Vector(-351.923, 21.8385, 32.031250), Angle(0,250,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc = {}
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.Kitchen] = { Vector(-145.811, -3.71502, 32), Angle(0,180,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.SS] = { Vector(229.355, 566.11, 87), Angle(0,234,87) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.NHA] = { Vector(226.063, 307.311, 32), Angle(0,320,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.BR] = { Vector(423.922, 29.9327, 32), Angle(0,90,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.SR] = { Vector(217.167, 417.786, 32), Angle(0,270,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.StorageD] = { Vector(-54.393, -92.0667, -96.1156), Angle(0,64,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.Generator] = { Vector(-336.451, -342.729, -96.9048), Angle(0,90,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.Office] = { Vector(-362.534, -85.6415, 64.2119), Angle(0,270,0) }
GM.AnimatronicAPos[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.Kitchen2] = { Vector(-292.778, 43.7329, 32), Angle(0,235,0) }
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc = {}
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.SS] = { Vector(577.209, -479.944, 55.5574), Angle(0,143,0) }
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Entrance] = { Vector(435.05, -411.066, 34.6907), Angle(0,195,0) }
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.EntranceD] = { Vector(238.816, -381.027, 34.6907), Angle(0,175,0) }
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.DA] = { Vector(44.7517, -392.845, 33.6907), Angle(0,180,0) }
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.StaffD] = { Vector(-150.427, -431.847, 33.6907), Angle(0,180,0) }
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Staff] = { Vector(-194.663, -300.543, 47.3979), Angle(0,180,0) }
GM.AnimatronicAPos[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Office] = { Vector(-289.801, -336, 64.6867), Angle(0,180,0) }
GM.AnimatronicAPos[GM.Animatronic.Applejack].fnap_scc = {}
GM.AnimatronicAPos[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.SS] = { Vector(744, 584, 32), Angle(0,-135,0) }
GM.AnimatronicAPos[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.Office] = { Vector(-237.473, -191.82, 75.8022), Angle(0,180,0) }
GM.AnimatronicAPos[GM.Animatronic.RainbowDash].fnap_scc = {}
GM.AnimatronicAPos[GM.Animatronic.RainbowDash].fnap_scc[GM.APos.fnap_scc.Trash] = { Vector(441.369, -397.072, -99.6947), Angle(0, 138.75, 0) }
GM.AnimatronicAPos[GM.Animatronic.RainbowDash].fnap_scc[GM.APos.fnap_scc.Office] = { Vector(441.369, -397.072, -99.6947), Angle(0, 138.75, 0) }

GM.AnimatronicsCD = {}
GM.AnimatronicsCD[GM.Animatronic.Pinkie] = {}
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc = {}
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc[0] = 10
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc[1] = -1
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc[2] = -1
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc[3] = 30
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc[4] = 30
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc[5] = 16
GM.AnimatronicsCD[GM.Animatronic.Pinkie].fnap_scc[6] = 6
GM.AnimatronicsCD[GM.Animatronic.Fluttershy] = {}
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc = {}
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc[0] = 10
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc[1] = 60
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc[2] = 40
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc[3] = 30
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc[4] = 20
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc[5] = 16
GM.AnimatronicsCD[GM.Animatronic.Fluttershy].fnap_scc[6] = 6
GM.AnimatronicsCD[GM.Animatronic.Twilight] = {}
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc = {}
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc[0] = 10
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc[1] = 60
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc[2] = 40
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc[3] = 30
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc[4] = 20
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc[5] = 16
GM.AnimatronicsCD[GM.Animatronic.Twilight].fnap_scc[6] = 6
GM.AnimatronicsCD[GM.Animatronic.Rarity] = {}
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc = {}
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc[0] = 5
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc[1] = 40
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc[2] = 30
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc[3] = 15
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc[4] = 10
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc[5] = 7
GM.AnimatronicsCD[GM.Animatronic.Rarity].fnap_scc[6] = 5
GM.AnimatronicsCD[GM.Animatronic.Applejack] = {}
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc = {}
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc[0] = 30
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc[1] = -1
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc[2] = -1
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc[3] = 190
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc[4] = 120
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc[5] = 60
GM.AnimatronicsCD[GM.Animatronic.Applejack].fnap_scc[6] = 30
GM.AnimatronicsCD[GM.Animatronic.RainbowDash] = {}
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc = {}
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc[0] = 30
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc[1] = -1
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc[2] = 150
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc[3] = 120
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc[4] = 60
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc[5] = 60
GM.AnimatronicsCD[GM.Animatronic.RainbowDash].fnap_scc[6] = 30

GM.AnimatronicsMaxCD = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie] = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc[0] = 10
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc[1] = -1
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc[2] = -1
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc[3] = 90
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc[4] = 60
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc[5] = 30
GM.AnimatronicsMaxCD[GM.Animatronic.Pinkie].fnap_scc[6] = 10
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy] = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc[0] = 10
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc[1] = 90
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc[2] = 60
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc[3] = 45
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc[4] = 30
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc[5] = 30
GM.AnimatronicsMaxCD[GM.Animatronic.Fluttershy].fnap_scc[6] = 10
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight] = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc[0] = 10
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc[1] = 90
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc[2] = 60
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc[3] = 45
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc[4] = 30
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc[5] = 30
GM.AnimatronicsMaxCD[GM.Animatronic.Twilight].fnap_scc[6] = 10
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity] = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc[0] = 7
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc[1] = 60
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc[2] = 50
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc[3] = 30
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc[4] = 20
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc[5] = 10
GM.AnimatronicsMaxCD[GM.Animatronic.Rarity].fnap_scc[6] = 7
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack] = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc = {}
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc[0] = 60
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc[1] = -1
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc[2] = -1
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc[3] = 260
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc[4] = 190
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc[5] = 120
GM.AnimatronicsMaxCD[GM.Animatronic.Applejack].fnap_scc[6] = 60
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash] = {}
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc = {}
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc[0] = 120
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc[1] = -1
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc[2] = 400
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc[3] = 300
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc[4] = 260
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc[5] = 160
GM.AnimatronicsMaxCD[GM.Animatronic.RainbowDash].fnap_scc[6] = 120

GM.AnimatronicsSkins = {}
GM.AnimatronicsSkins[GM.Animatronic.Pinkie] = {}
GM.AnimatronicsSkins[GM.Animatronic.Pinkie].fnap_scc = {}
GM.AnimatronicsSkins[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Office] = 3
GM.AnimatronicsSkins[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Staff] = 3
GM.AnimatronicsSkins[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.StaffD] = 3
GM.AnimatronicsSkins[GM.Animatronic.Fluttershy] = {}
GM.AnimatronicsSkins[GM.Animatronic.Fluttershy].fnap_scc = {}
GM.AnimatronicsSkins[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Office] = 2
GM.AnimatronicsSkins[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Kitchen2] = 2
GM.AnimatronicsSkins[GM.Animatronic.Twilight] = {}
GM.AnimatronicsSkins[GM.Animatronic.Twilight].fnap_scc = {}
GM.AnimatronicsSkins[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.SS] = 1
GM.AnimatronicsSkins[GM.Animatronic.Applejack] = {}
GM.AnimatronicsSkins[GM.Animatronic.Applejack].fnap_scc = {}
GM.AnimatronicsSkins[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.SS] = 4
GM.AnimatronicsSkins[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.Office] = 4
GM.AnimatronicsSkins[GM.Animatronic.Rarity] = {}
GM.AnimatronicsSkins[GM.Animatronic.Rarity].fnap_scc = {}
GM.AnimatronicsSkins[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Staff] = 1
GM.AnimatronicsSkins[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.StaffD] = 1
GM.AnimatronicsSkins[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Office] = 1
GM.AnimatronicsSkins[GM.Animatronic.RainbowDash] = {}
GM.AnimatronicsSkins[GM.Animatronic.RainbowDash].fnap_scc = {}
GM.AnimatronicsSkins[GM.Animatronic.RainbowDash].fnap_scc[GM.APos.fnap_scc.Trash] = 1
GM.AnimatronicsSkins[GM.Animatronic.RainbowDash].fnap_scc[GM.APos.fnap_scc.Office] = 1

GM.AnimatronicsFlex = {}
GM.AnimatronicsFlex[GM.Animatronic.Pinkie] = {}
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc = {}
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.SS] = { {21,1}, {11,0.5}, {12,0.5}  }
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Office] = { {0,1}, {19,1}, {1,1}, {2,1} }
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.StaffD] = { {1,1}, {2,1} }
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Staff] = { {0,1}, {19,1}, {1,1}, {2,1} }
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.Pinkie] = { {1,0.3}, {2,0.3} }
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.SR] = { {1,1}, {2,1} }
GM.AnimatronicsFlex[GM.Animatronic.Pinkie].fnap_scc[GM.APos.fnap_scc.NHA] = { {5,1}, {6,1} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy] = {}
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc = {}
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.SS] = { {21,1}, {9,0.6}, {10,0.6} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Office] = { {0,1} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.StorageT] = { {3,1}, {4,1} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.NHA] = { {3,1}, {4,1}, {21,1} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Kitchen] = { {3,1}, {4,1}, {21,1} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Kitchen2] = { {3,1}, {4,1}, {0,1} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.BR] = { {3,1}, {4,1} }
GM.AnimatronicsFlex[GM.Animatronic.Fluttershy].fnap_scc[GM.APos.fnap_scc.Cave] = { {21,1} }
GM.AnimatronicsFlex[GM.Animatronic.Applejack] = {}
GM.AnimatronicsFlex[GM.Animatronic.Applejack].fnap_scc = {}
GM.AnimatronicsFlex[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.Office] = { {0,1}, {1,1}, {18,1}, {49,1} }
GM.AnimatronicsFlex[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.SS] = { {20,1} }
GM.AnimatronicsFlex[GM.Animatronic.Rarity] = {}
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc = {}
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.SS] = { {21,1}, {10,1}, {11,1} }
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Entrance] = { {21,1}, {10,1}, {11,1} }
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.EntranceD] = { {21,1}, {0,1}, {1,1} }
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.DA] = { {21,1}, {0,1}, {1,1} }
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.StaffD] = { {38,1}, {6,1}, {7,1}, {18,0.5} }
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Staff] = { {38,1}, {0,1}, {1,1}, {18,0.5} }
GM.AnimatronicsFlex[GM.Animatronic.Rarity].fnap_scc[GM.APos.fnap_scc.Office] = { {21,1}, {0,1}, {1,1} }
GM.AnimatronicsFlex[GM.Animatronic.RainbowDash] = {}
GM.AnimatronicsFlex[GM.Animatronic.RainbowDash].fnap_scc = {}
GM.AnimatronicsFlex[GM.Animatronic.RainbowDash].fnap_scc[GM.APos.fnap_scc.Office] = { {1,1}, {2,1} }


GM.AnimatronicsAnim = {}
GM.AnimatronicsAnim[GM.Animatronic.Twilight] = {}
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc = {}
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.SS] = "ss"
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.BR] = "br"
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.SR] = "sr"
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.StorageD] = "storaged"
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.Generator] = "generator"
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.Office] = "office"
GM.AnimatronicsAnim[GM.Animatronic.Twilight].fnap_scc[GM.APos.fnap_scc.Kitchen2] = "kitchen2"
GM.AnimatronicsAnim[GM.Animatronic.Applejack] = {}
GM.AnimatronicsAnim[GM.Animatronic.Applejack].fnap_scc = {}
GM.AnimatronicsAnim[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.SS] = "sitting"
GM.AnimatronicsAnim[GM.Animatronic.Applejack].fnap_scc[GM.APos.fnap_scc.Office] = "office"
GM.AnimatronicsAnim[GM.Animatronic.RainbowDash] = {}
GM.AnimatronicsAnim[GM.Animatronic.RainbowDash].fnap_scc = {}
GM.AnimatronicsAnim[GM.Animatronic.RainbowDash].fnap_scc[GM.APos.fnap_scc.Trash] = "trashstand"
GM.AnimatronicsAnim[GM.Animatronic.RainbowDash].fnap_scc[GM.APos.fnap_scc.Office] = "gallop"


function GM:CheckDerivCreator(pl)
	if (pl:SteamID()=="STEAM_0:1:33606814" or pl:SteamID()=="STEAM_0:0:59390945") then
		return true
	end
	return false
end


function fnapgmAnimatronicMove(self,me,apos)
	
	if apos!=nil and self.OldAPos != apos then
		
		self.OldAPos = apos
		
		if me!=GAMEMODE.Animatronic.RainbowDash then
			
			self:SetColor( Color( 255, 255, 255, 0 ) )
			
			if GAMEMODE.AnimatronicAPos[me] and GAMEMODE.AnimatronicAPos[me][game.GetMap()] and GAMEMODE.AnimatronicAPos[me][game.GetMap()][apos] then
				self:SetPos(GAMEMODE.AnimatronicAPos[me][game.GetMap()][apos][1])
				self:SetAngles(GAMEMODE.AnimatronicAPos[me][game.GetMap()][apos][2])
			end
			
			self:SetColor( Color( 255, 255, 255, 255 ) )
			
		end
		
	elseif me==GAMEMODE.Animatronic.RainbowDash and apos==GAMEMODE.APos[game.GetMap()].Office and self.FoxyWillMove2 then
		
		if !self.preltime or self.preltime<1 then
			self.preltime = (self.preltime or 0) + FrameTime()
		elseif !self.preltime or self.preltime>=1 then
			self.preltime = 0
			self.presta = true
		end
		
		if !self.presta then
			self:SetPos( LerpVector( self.preltime, GAMEMODE.AnimatronicAPos[me][game.GetMap()][apos][1], Vector(417.923, -388.438, -95.7159) ) )
			self:SetAngles( LerpAngle( self.preltime, GAMEMODE.AnimatronicAPos[me][game.GetMap()][apos][2], Angle(0,120,0) ) )
		else
			self:SetPos( Vector(417.923, -388.438, -95.7159) )
		end
		
		if self:GetSequence() != self:LookupSequence( GAMEMODE.AnimatronicsAnim[me][game.GetMap()][GAMEMODE.APos.fnap_scc.Office] ) then
			self:SetSequence( self:LookupSequence( GAMEMODE.AnimatronicsAnim[me][game.GetMap()][GAMEMODE.APos.fnap_scc.Office] ) )
			self:ResetSequenceInfo()
			self:SetCycle(0)
			self:SetPlaybackRate(0)
		end
		
	elseif me==GAMEMODE.Animatronic.RainbowDash and apos==GAMEMODE.APos[game.GetMap()].Office and self.FoxyWillMove then
		
		if self:GetColor()!=Color( 255, 255, 255, 255 ) then self:SetColor( Color( 255, 255, 255, 255 ) ) end
		
		if self:GetSequence() != self:LookupSequence( GAMEMODE.AnimatronicsAnim[me][game.GetMap()][GAMEMODE.APos.fnap_scc.Trash] ) then
			self:SetSequence( self:LookupSequence( GAMEMODE.AnimatronicsAnim[me][game.GetMap()][GAMEMODE.APos.fnap_scc.Trash] ) )
			self:ResetSequenceInfo()
			self:SetCycle(0)
		end
		
	elseif me==GAMEMODE.Animatronic.RainbowDash and apos==GAMEMODE.APos[game.GetMap()].Office and self.FoxyMove2 then
		
		if self:GetColor()!=Color( 255, 255, 255, 255 ) then self:SetColor( Color( 255, 255, 255, 255 ) ) end
		
		if !self.ltime or self.ltime<1 then
			local multip = 1
			if self.sta==3 then
				multip = 0.6
			elseif self.sta==3 or self.sta==5 then
				multip = 1.4
			end
			self.ltime = (self.ltime or 0) + FrameTime()*multip
		elseif !self.ltime or self.ltime>=1 then
			self.ltime = 0
			self.sta = (self.sta or 0) + 1
		end
		
		if !self.sta or self.sta==0 then
			self:SetPos( LerpVector( self.ltime, Vector(417.923, -388.438, -95.7159), Vector(323, -186.201813, -89.016739) ) )
			self:SetAngles( LerpAngle( self.ltime, Angle(0,120,0), Angle(0,90,0) ) )
			self:SetPlaybackRate(1)
		elseif self.sta==1 then
			self:SetPos( LerpVector( self.ltime, Vector(323, -186.201813, -89.016739), Vector(323, -70.793152, 32) ) )
			self:SetAngles( Angle(-40,90,0) )
			self:SetPlaybackRate(1)
		elseif self.sta==2 then
			self:SetPos( LerpVector( self.ltime, Vector(323, -70.793152, 32), Vector(283.779999, -15.925056, 32) ) )
			self:SetAngles( LerpAngle( self.ltime, Angle(0,90,0), Angle(0,-180,0) ) )
			self:SetPlaybackRate(1)
		elseif self.sta==3 then
			self:SetPos( LerpVector( self.ltime, Vector(283.779999, -15.925056, 32), Vector(-137.194016, -8.655641, 32) ) )
			self:SetAngles( Angle(0,-180,0) )
			self:SetPlaybackRate(1)
		elseif self.sta==4 then
			self:SetPos( LerpVector( self.ltime, Vector(-137.194016, -8.655641, 32), Vector(-385.440521, -42.308228, 32) ) )
			self:SetAngles( LerpAngle( self.ltime, Angle(0,-180,0), Angle(0,-150,0) ) )
			self:SetPlaybackRate(1)
			if self:GetSkin()!=2 then self:SetSkin(2) end
			self:SetFlexWeight( 0, Lerp( self.ltime, 0, 1 ) )
		elseif self.sta==5 then
			self:SetPos( LerpVector( self.ltime, Vector(-385.440521, -42.308228, 32), Vector(-431.247833, -95, 32) ) )
			self:SetAngles( LerpAngle( self.ltime, Angle(0,-150,0), Angle(0,-90,0) ) )
			self:SetPlaybackRate(1)
		elseif self.sta==6 then
			self:Jumpscare()
			self.FoxyMove2 = false
			self:SetPlaybackRate(0.1)
		end
		
	elseif me==GAMEMODE.Animatronic.RainbowDash and apos==GAMEMODE.APos[game.GetMap()].Trash then
		
		if self:GetColor()!=Color( 255, 255, 255, 0 ) then self:SetColor( Color( 255, 255, 255, 0 ) ) end
		
		if !self.sta or self.sta>0 then self.sta=0 end
		if self.presta then self.presta=false end
		
	elseif me==GAMEMODE.Animatronic.Twilight and ( apos==GAMEMODE.APos[game.GetMap()].Office or apos==GAMEMODE.APos[game.GetMap()].Kitchen or apos==GAMEMODE.APos[game.GetMap()].Kitchen2 ) then
		
		self:SetSkin( math.random( 0, 1 ) )
		
	end
	
	return true
	
end
hook.Add( "fnafgmAnimatronicMove", "fnapgmAnimatronicMove", fnapgmAnimatronicMove)