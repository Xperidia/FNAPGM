--[[---------------------------------------------------------

	Five Nights at Pinkie's Gamemode for Garry's Mod
			by VictorienXP@Xperidia (2015)

-----------------------------------------------------------]]

AddCSLuaFile("shared.lua")
include("shared.lua")
resource.AddWorkshop("408243366")
DeriveGamemode("fnafgm")

if game.GetMap() == "fnap_scc" then
	resource.AddWorkshop("542724054")
end


function fnapgmStartNightCustom(ply)

	local gm = GAMEMODE
	local map = game.GetMap()

	if gm.Vars.startday then return end

	if map == "fnap_scc" then

		gm:SetNightTemplate(true)

		if btn and btn:IsValid() then btn:Fire("use") end

		local sound = ""
		local mutetime = 0

		if gm.Vars.night == 1 then
			sound = gm.Sound_Calls.fnap_scc[1]
			gm.Vars.mute = false
			mutetime = 64.2
		elseif gm.Vars.night == 2 then
			sound = gm.Sound_Calls.fnap_scc[2]
			gm.Vars.mute = false
			mutetime = 46.7
		elseif gm.Vars.night == 3 then
			sound = gm.Sound_Calls.fnap_scc[3]
			gm.Vars.mute = false
			mutetime = 47.4
		elseif gm.Vars.night == 4 then
			sound = gm.Sound_Calls.fnap_scc[4]
			gm.Vars.mute = false
			mutetime = 64.3
		elseif gm.Vars.night == 5 then
			sound = gm.Sound_Calls.fnap_scc[5]
			gm.Vars.mute = false
			mutetime = 76.8
		end

		for _, v in pairs(ents.FindByName("fnafgm_CallSource")) do
			v:SetKeyValue("message", sound)
		end

		for _, v in pairs(ents.FindByName("fnafgm_CallButton")) do
			v:Fire("addoutput", "OnPressed fnafgm_CallSource,Volume,0,0.00,1")
			v:Fire("addoutput", "OnPressed fnafgm_CallSprite,ToggleSprite,none,0,1")
			v:Fire("addoutput", "OnPressed fnafgm_link,MuteCall,,0,-1")
		end

		gm:CreateAnimatronic(gm.Animatronic.Pinkie, gm.APos.fnap_scc.SS)
		gm:CreateAnimatronic(gm.Animatronic.Fluttershy, gm.APos.fnap_scc.SS)
		gm:CreateAnimatronic(gm.Animatronic.Twilight, gm.APos.fnap_scc.SS)
		gm:CreateAnimatronic(gm.Animatronic.Rarity, gm.APos.fnap_scc.SS)
		gm:CreateAnimatronic(gm.Animatronic.Applejack, gm.APos.fnap_scc.SS)
		gm:CreateAnimatronic(gm.Animatronic.RainbowDash, gm.APos.fnap_scc.Trash)

		timer.Create("fnafgmTempoStartU", 1.3, 1, function()

			fnafgmVarsUpdate()

			for _, v in pairs(team.GetPlayers(1)) do
				if v:Alive() then
					v:ScreenFade(SCREENFADE.OUT, color_black, 0.25, 8.2 - 1.3 - 0.25)
				end
			end

			gm.Vars.LightUse[1] = false
			gm.Vars.LightUse[2] = false

			timer.Remove("fnafgmTempoStartU")

		end)

		timer.Create("fnafgmTempoStartM", 1.6, 1, function()

			for _, v in pairs(player.GetAll()) do
				if v:Team() == 1 and v:Alive() then
					v:SetPos(gm.FNaFView.fnap_scc[1])
					v:SetEyeAngles(gm.FNaFView.fnap_scc[2])
				end
			end

			timer.Remove("fnafgmTempoStartM")

		end)

		timer.Create("fnafgmTempoStart", 8.2, 1, function()

			gm.Vars.tempostart = false

			fnafgmVarsUpdate()
			fnafgmPowerUpdate()

			if IsValid(ents.FindByName("RainbowTimer")[1]) then ents.FindByName("RainbowTimer")[1]:Fire("Enable") end

			if not gm.Vars.mute then

				ents.FindByName("fnafgm_CallSprite")[1]:Fire("ToggleSprite")

				for _, v in pairs(ents.FindByName("fnafgm_CallSource")) do
					v:Fire("PlaySound")
				end

				timer.Create("fnafgmEndCall", mutetime, 1, function()
					gm.Vars.mute = true
					for _, v in pairs(ents.FindByName("fnafgm_CallButton")) do
						v:Fire("Use")
					end
				end)

			end

			for _, v in pairs(team.GetPlayers(1)) do
				gm:GoFNaFView(v, true)
			end

			for k, _ in pairs(gm.Vars.Animatronics) do

				if gm.AnimatronicsCD[k] and gm.AnimatronicsCD[k][map] and gm.AnimatronicsMaxCD[k] and gm.AnimatronicsMaxCD[k][map] then

					local randtime = math.random(gm.AnimatronicsCD[k][map][gm.Vars.night] or gm.AnimatronicsCD[k][map][0], gm.AnimatronicsMaxCD[k][map][gm.Vars.night] or gm.AnimatronicsMaxCD[k][map][0])
					if gm.AnimatronicsCD[k][map][gm.Vars.night] ~= -1 then
						timer.Create("fnafgmAnimatronicMove" .. k, randtime, 0, function() gm:AutoMoveAnimatronic(k) end)
					end

				else

					gm:Log("Missing or incomplete cooldown info for animatronic " .. ((gm.AnimatronicName[k] .. " (" .. (k or 0) .. ")") or k or 0) .. "!")

				end

			end

			timer.Create("fnafgmTimeThink", gm.HourTime, 0, fnafgmTimeThink)

			timer.Remove("fnafgmTempoStart")

		end)

		if timer.Exists("fnapgmPinkieScare") then

			timer.Adjust("fnapgmPinkieScare", math.random(280, 370), 1, function()

				if gm.Vars.startday then

					for _, v in pairs(player.GetAll()) do

						if v:Team() ~= TEAM_UNASSIGNED and v:Alive() then

							v:SendLua([[GAMEMODE:JumpscareOverlay("deathscreens/pinkieisscary",2)]])
							v:SendLua([[LocalPlayer():EmitSound("fnapgm_pinkiescare")]])

						end

					end

				end

				timer.Remove("fnapgmPinkieScare")

			end)

		else

			timer.Create("fnapgmPinkieScare", math.random(280, 370), 1, function()

				if gm.Vars.startday then

					for _, v in pairs(player.GetAll()) do

						if v:Team() ~= TEAM_UNASSIGNED and v:Alive() then

							v:SendLua([[GAMEMODE:JumpscareOverlay("deathscreens/pinkieisscary",2)]])
							v:SendLua([[LocalPlayer():EmitSound("fnapgm_pinkiescare")]])

						end

					end

				end

				timer.Remove("fnapgmPinkieScare")

			end)

		end

	elseif map == "fnap_cb" then

		gm:SetNightTemplate(false)
		if gm.Vars.night == 1 then
			gm.Vars.power = 115
			gm.Vars.powertot = 115
		elseif gm.Vars.night == 2 then
			gm.Vars.power = 100
			gm.Vars.powertot = 100
		elseif gm.Vars.night == 3 then
			gm.Vars.power = 85
			gm.Vars.powertot = 85
		elseif gm.Vars.night == 4 then
			gm.Vars.power = 67
			gm.Vars.powertot = 67
		else
			gm.Vars.power = 50
			gm.Vars.powertot = 50
		end

		timer.Create("fnafgmTempoStartU", 1.3, 1, function()

			fnafgmVarsUpdate()

			for _, v in pairs(team.GetPlayers(1)) do
				if v:Alive() then
					v:ScreenFade(SCREENFADE.OUT, color_black, 0.25, 8.2 - 1.3 - 0.25)
				end
			end

			timer.Remove("fnafgmTempoStartU")

		end)

		timer.Create("fnafgmTempoStartM", 1.6, 1, function()

			for _, v in pairs(player.GetAll()) do
				if v:Team() == 1 and v:Alive() then
					v:SetPos(gm.FNaFView.fnap_cb[1])
					v:SetEyeAngles(gm.FNaFView.fnap_cb[2])
				end
			end

			timer.Remove("fnafgmTempoStartM")

		end)

		timer.Create("fnafgmTempoStart", 8.2, 1, function()

			gm.Vars.tempostart = false

			fnafgmVarsUpdate()
			fnafgmPowerUpdate()

			for _, v in pairs(team.GetPlayers(1)) do
				gm:GoFNaFView(v, true)
			end

			timer.Create("fnafgmTimeThink", gm.HourTime, 0, fnafgmTimeThink)

			timer.Remove("fnafgmTempoStart")

		end)

	end

	return true

end
hook.Add("fnafgmCustomStart", "fnapgmStartNightCustom", fnapgmStartNightCustom)


function fnapgmMapOverrides()

	local map = game.GetMap()

	if map == "fnap_scc" then

		for _, v in pairs(ents.FindByName("TimerButton")) do
			btn = v
		end

		for _, v in pairs(ents.FindByName("Door1Light")) do
			light1 = v
		end

		for _, v in pairs(ents.FindByName("Door2Light")) do
			light2 = v
		end

		for _, v in pairs(ents.FindByName("OfficeLightSwitch")) do
			light3 = v
		end

		if IsValid(ents.FindByName("WarningTimer")[1]) then ents.FindByName("WarningTimer")[1]:Fire("Kill") end
		if IsValid(ents.FindByName("Warning")[1]) then ents.FindByName("Warning")[1]:Fire("Kill") end

		GAMEMODE.Vars.mapoverrideok = true

	end

end
hook.Add("fnafgmMapOverridesCustom", "fnapgmMapOverrides", fnapgmMapOverrides)

function fnapgmPowerCalc()

	local gm = GAMEMODE
	local map = game.GetMap()

	if gm.Vars.iniok and gm.Vars.mapoverrideok and gm.Vars.startday and gm.Vars.active and map == "fnap_scc" then

		gm.Vars.powerusage = gm.Power_Usage_Base

		if gm.Vars.poweroff or fnafgm_disablepower:GetBool() then

			gm.Vars.powerusage = 0

		else

			local tabactualuse = false --Calc tab usage

			for _, v in pairs(team.GetPlayers(1)) do

				if gm.Vars.tabused[v] and gm.Vars.tabused[v] == true then

					tabactualuse = true

				end

			end

			if tabactualuse then -- Tab use

				gm.Vars.powerusage = gm.Vars.powerusage + 1

			end

			if gm.Vars.DoorClosed[1] then -- Door 1 use

				gm.Vars.powerusage = gm.Vars.powerusage + 1

			end

			if gm.Vars.DoorClosed[2] then -- Door 2 use

				gm.Vars.powerusage = gm.Vars.powerusage + 1

			end

			if gm.Vars.LightUse[1] or gm.Vars.LightUse[2] then -- Lights use

				gm.Vars.powerusage = gm.Vars.powerusage + 1

			end

			if gm.Vars.AprilFool or fnafgm_forceseasonalevent:GetInt() == 2 then -- Troll use

				gm.Vars.powerusage = gm.Vars.powerusage + 5

			end

		end

		if gm.Vars.powerusage == 0 then

			gm.Vars.powerdrain = 0

		else

			gm.Vars.powerdrain = gm.Power_Drain_Time

			for i = 1, gm.Vars.powerusage - 1 do
				gm.Vars.powerdrain = gm.Vars.powerdrain / 2
			end

			if gm.Vars.powerchecktime == nil and gm.Vars.oldpowerdrain == nil and not gm.Vars.poweroff then

				gm.Vars.powerchecktime = CurTime() + gm.Vars.powerdrain
				gm.Vars.oldpowerdrain = gm.Vars.powerdrain

			elseif gm.Vars.powerchecktime ~= nil and gm.Vars.oldpowerdrain ~= nil and not gm.Vars.poweroff then

				local calcchangepower = gm.Vars.oldpowerdrain-gm.Vars.powerdrain

				if gm.Vars.powerchecktime <= CurTime() + calcchangepower then

					gm.Vars.powerchecktime = nil
					gm.Vars.oldpowerdrain = nil
					gm.Vars.power = gm.Vars.power - 1
					fnapgmDigits(gm.Vars.power)

				end

			end

		end

		if gm.Vars.power <= 0 and not gm.Vars.poweroff then

			gm:TriggerLinkOutput("OnPowerDown")

			local legacy_ent = ents.FindByName("NoMorePower")
			if #legacy_ent > 0 then
				legacy_ent = legacy_ent[1]
				if IsValid(legacy_ent) then
					legacy_ent:Fire("use")
				end
			end

			for _, v in pairs(player.GetAll()) do
				if v:Team() == 1 and v:Alive() then
					v:SetPos(Vector(-465, -255, 32))
				end
			end

			for k, _ in pairs(gm.Vars.Animatronics) do

				if k ~= gm.Animatronic.RainbowDash then
					gm:SetAnimatronicPos(nil, k, gm.APos[map].SS)
				end
				timer.Remove("fnafgmAnimatronicMove" .. k)

			end

			gm.Vars.poweroff = true
			if not game.SinglePlayer() then norespawn = true end
			gm:Log("The power is gone :)")

			timer.Create("fnapgmNoMorePower", 10, 1, function()

				for k, _ in pairs(gm.Vars.Animatronics) do

					if k ~= gm.Animatronic.Applejack and k ~= gm.Animatronic.RainbowDash then
						gm:SetAnimatronicPos(nil, k, gm.APos[map].Office)
					end

				end

				timer.Remove("fnapgmNoMorePower")

			end)

		end

		fnafgmPowerUpdate()

	elseif gm.Vars.iniok and gm.Vars.mapoverrideok and gm.Vars.startday and gm.Vars.active and map == "fnap_cb" then

		gm.Vars.powerusage = 0

		if not gm.Vars.poweroff and not fnafgm_disablepower:GetBool() then

			if gm.Vars.LightUse[1] or gm.Vars.LightUse[2] or gm.Vars.LightUse[3] then

				gm.Vars.powerusage = gm.Vars.powerusage + 1

			end

			for _, v in pairs(ents.FindByClass("fnafgm_camera")) do

				if v.GetLightState and v:GetLightState() then

					gm.Vars.powerusage = gm.Vars.powerusage + 1
					break

				end

			end

			for _, v in pairs(team.GetPlayers(1)) do

				if v:FlashlightIsOn() then

					gm.Vars.powerusage = gm.Vars.powerusage + 1
					break

				end

			end

		end

		if gm.Vars.powerusage == 0 or not gm.Vars.powerchecktime then

			gm.Vars.powerchecktime = CurTime() + 1

		else

			if gm.Vars.powerchecktime <= CurTime() then

				gm.Vars.powerchecktime = CurTime() + 1
				gm.Vars.power = gm.Vars.power - 1

			end

		end

		if gm.Vars.power == 0 and not gm.Vars.poweroff then

			gm.Vars.poweroff = true

			for _, v in pairs(team.GetPlayers(1)) do

				if v:FlashlightIsOn() and not fnafgmPlayerCanByPass(v, "flashlight") then

					v:Flashlight(false)

					v:SendLua([[LocalPlayer():EmitSound("fnafgm_lighterror")]])

				end

			end

			gm:Log("The battery is dead")

		end

		fnafgmPowerUpdate()

	end

end
hook.Add("fnafgmCustomPowerCalc", "fnapgmPowerCalc", fnapgmPowerCalc)

function fnapgmGeneralDeath()
	if IsValid(ents.FindByName("RainbowTimer")[1]) then ents.FindByName("RainbowTimer")[1]:Fire("Disable") end
end
hook.Add("fnafgmGeneralDeath", "fnapgmGeneralDeath", fnapgmGeneralDeath)

function fnapgmDigits(n)

	if not n then return end

	if n > 99 then
		n = 99
	elseif n < 0 then
		n = 0
	end

	local left = math.floor(n / 10)
	local right = math.fmod(n, 10)

	if left == 0 and n ~= 0 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	elseif left == 1 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	elseif left == 2 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	elseif left == 3 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	elseif left == 4 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	elseif left == 5 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Disable")
	elseif left == 6 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Disable")
	elseif left == 7 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	elseif left == 8 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	elseif left == 9 then
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Enable")
	else
		ents.FindByName("Timer_#1_SegmentE1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentG1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA1")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentB1")[1]:Fire("Disable")
	end
	if right == 0 and n ~= 0 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	elseif right == 1 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	elseif right == 2 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	elseif right == 3 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	elseif right == 4 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	elseif right == 5 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Disable")
	elseif right == 6 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Disable")
	elseif right == 7 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	elseif right == 8 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	elseif right == 9 then
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Enable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Enable")
	else
		ents.FindByName("Timer_#1_SegmentE")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentG")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentF")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentD")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentC")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentA")[1]:Fire("Disable")
		ents.FindByName("Timer_#1_SegmentB")[1]:Fire("Disable")
	end
end


function fnapgmRainbowDash(self)

	if self:GetAType() == GAMEMODE.Animatronic.RainbowDash then

		if self.FoxyMove then
			self.FoxyMove = false
			self.FoxyMove2 = true
			for _, v in pairs(player.GetAll()) do

				if v:Team() ~= TEAM_CONNECTING and v:Team() ~= TEAM_UNASSIGNED then

					v:SendLua([[LocalPlayer():EmitSound("fnapgm_runrainbowdash")]])

				end

			end
		end

		if self.FoxyWillMove or self.FoxyMove then coroutine.wait(0.1) else coroutine.wait(1) end

	else

		coroutine.wait(120)

	end

	return true

end
hook.Add("fnafgmCustomFoxy", "fnapgmRainbowDash", fnapgmRainbowDash)


function fnapgmWindowScare(self, me, apos)

	local gm = GAMEMODE
	local map = game.GetMap()

	if map == "fnap_scc" then

		if me == gm.Animatronic.Pinkie then

			if apos == gm.APos.fnap_scc.Office and gm.Vars.LightUse[1] and not self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos == gm.APos.fnap_scc.Office and not gm.Vars.LightUse[1] and self.wsip then
				self.wsip = false
			elseif apos ~= gm.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end

		elseif me == gm.Animatronic.Fluttershy then

			if apos == gm.APos.fnap_scc.Office and gm.Vars.LightUse[2] and not self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos == gm.APos.fnap_scc.Office and not gm.Vars.LightUse[2] and self.wsip then
				self.wsip = false
			elseif apos ~= gm.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end

		elseif me == gm.Animatronic.Twilight then

			if apos == gm.APos.fnap_scc.Office and gm.Vars.LightUse[2] and not self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos == gm.APos.fnap_scc.Office and not gm.Vars.LightUse[2] and self.wsip then
				self.wsip = false
			elseif apos ~= gm.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end

		elseif me == gm.Animatronic.Rarity then

			if apos == gm.APos.fnap_scc.Office and gm.Vars.LightUse[1] and not self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos == gm.APos.fnap_scc.Office and not gm.Vars.LightUse[1] and self.wsip then
				self.wsip = false
			elseif apos ~= gm.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end

		end

	end

	return true

end
hook.Add("fnafgmWindowScare", "fnapgmWindowScare", fnapgmWindowScare)


function fnapgmFixPos(self, me, apos)

	local gm = GAMEMODE
	local map = game.GetMap()

	if me ~= gm.Animatronic.RainbowDash and gm.AnimatronicAPos[me] and gm.AnimatronicAPos[me][map] and gm.AnimatronicAPos[me][map][apos] then
		self:SetPos(gm.AnimatronicAPos[me][map][apos][1])
	end

	return true

end
hook.Add("fnafgmFixPos", "fnapgmFixPos", fnapgmFixPos)


function fnapgmGoJumpscare(me, self, timet)

	local gm = GAMEMODE
	local map = game.GetMap()

	if (map == "fnap_scc") then

		if gm.Vars.poweroff then return true end

		if me == gm.Animatronic.Applejack then
			for _, v in pairs(player.GetAll()) do
				if v:Team() ~= TEAM_CONNECTING and v:Team() ~= TEAM_UNASSIGNED then
					v:SendLua([[LocalPlayer():EmitSound("fnapgm_applejackscream")]])
				end
			end
		elseif me == gm.Animatronic.Rarity then
			for _, v in pairs(player.GetAll()) do
				if v:Team() ~= TEAM_CONNECTING and v:Team() ~= TEAM_UNASSIGNED then
					v:SendLua([[LocalPlayer():EmitSound("fnapgm_rarityknock")]])
				end
			end
		elseif me ~= gm.Animatronic.RainbowDash then
			for _, v in pairs(player.GetAll()) do
				if v:Team() ~= TEAM_CONNECTING and v:Team() ~= TEAM_UNASSIGNED then
					v:SendLua([[LocalPlayer():EmitSound("fnapgm_officesnd")]])
				end
			end
		end

		if me == gm.Animatronic.RainbowDash then
			self.FoxyWillMove = true
			if IsValid(ents.FindByName("RDDoor")[1]) then ents.FindByName("RDDoor")[1]:Fire("Open") end
			local flight = ents.FindByName("FluoLight")[1]
			if IsValid(flight) then
				flight:Fire("TurnOff")
				flight:Fire("TurnOn", NULL, 2)
			end
			local tlight = ents.FindByName("TimerLightDoor3")[1]
			if IsValid(tlight) then
				tlight:Fire("Disable")
				tlight:Fire("Enable", NULL, 2)
			end
			timet = timet * 2
		end

		timer.Create("fnafgmJumpscare" .. me, timet, 1, function()

			local sgdead = true
			for _, v in pairs(player.GetAll()) do
				if v:Alive() and v:Team() == 1 then
					sgdead = false
					break
				end
			end

			if sgdead then timer.Remove("fnafgmJumpscare" .. me) return end

			if gm.Vars.startday and me ~= gm.Animatronic.RainbowDash then
				self:Jumpscare()
			elseif gm.Vars.startday then

				self.FoxyWillMove2 = true

				local flight = ents.FindByName("FluoLight")[1]
				if IsValid(flight) then
					flight:Fire("TurnOff")
					flight:Fire("TurnOn", NULL, 2)
				end
				local tlight = ents.FindByName("TimerLightDoor3")[1]
				if IsValid(tlight) then
					tlight:Fire("Disable")
					tlight:Fire("Enable", NULL, 2)
				end

				timer.Create("fnapgmRDmove", timet, 1, function()

					if IsValid(ents.FindByName("RDDoor")[1]) then ents.FindByName("RDDoor")[1]:Fire("Close", NULL, 0.2) end
					local DoorRD = ents.FindByName("DoorRD")[1]
					if IsValid(DoorRD) then
						DoorRD:Fire("Open", NULL, 0.8)
						DoorRD:Fire("Close", NULL, 3)
					end

					self.FoxyWillMove = false
					self.FoxyWillMove2 = false
					self.FoxyMove = true

					timer.Remove("fnapgmRDmove")

				end)

			end

			timer.Remove("fnafgmJumpscare" .. me)

		end)

	end

	return true

end
hook.Add("fnafgmCustomGoJumpscare", "fnapgmGoJumpscare", fnapgmGoJumpscare)


function fnapgmJumpscare(me, self)

	local gm = GAMEMODE
	local map = game.GetMap()

	if (map == "fnap_scc") then

		if me == gm.Animatronic.Pinkie and not gm.Vars.DoorClosed[1] then

			for _, v in pairs(player.GetAll()) do

				if v:Team() == 1 and v:Alive() and v.IsOnSecurityRoom then

					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_' .. me .. '")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self)

				end

			end

			gm:Log("Jumpscared by " .. gm.AnimatronicName[me])

		elseif me == gm.Animatronic.Fluttershy and not gm.Vars.DoorClosed[2] then

			for _, v in pairs(player.GetAll()) do

				if v:Team() == 1 and v:Alive() and v.IsOnSecurityRoom then

					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_' .. me .. '")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self)

				end

			end

			gm:Log("Jumpscared by " .. gm.AnimatronicName[me])

		elseif me == gm.Animatronic.Twilight and not gm.Vars.DoorClosed[2] then

			for _, v in pairs(player.GetAll()) do

				if v:Team() == 1 and v:Alive() and v.IsOnSecurityRoom then

					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_' .. me .. '")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self)

				end

			end

			gm:Log("Jumpscared by " .. gm.AnimatronicName[me])

		elseif me == gm.Animatronic.Rarity and not gm.Vars.DoorClosed[1] then

			for _, v in pairs(player.GetAll()) do

				if v:Team() == 1 and v:Alive() and v.IsOnSecurityRoom then

					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_' .. me .. '")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self)

				end

			end

			gm:Log("Jumpscared by " .. gm.AnimatronicName[me])

		elseif me == gm.Animatronic.Applejack and gm.Vars.LightUse[3] then

			for _, v in pairs(player.GetAll()) do

				if v:Team() == 1 and v:Alive() and v.IsOnSecurityRoom then

					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_' .. me .. '")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self)

				end

			end

			gm:Log("Jumpscared by " .. gm.AnimatronicName[me])

			elseif me == gm.Animatronic.RainbowDash and not gm.Vars.DoorClosed[2] then

				for _, v in pairs(player.GetAll()) do

					if v:Team() == 1 and v:Alive() and v.IsOnSecurityRoom then

						v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_' .. me .. '")')
						v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
						v:TakeDamage(100, self)

					end

				end

				gm:Log("Jumpscared by " .. gm.AnimatronicName[me])

		elseif me == gm.Animatronic.RainbowDash then

			for _, v in pairs(player.GetAll()) do

				if v:Team() ~= TEAM_CONNECTING and v:Team() ~= TEAM_UNASSIGNED then

					v:SendLua([[LocalPlayer():EmitSound("fnapgm_rainbowknock")]])

				end

			end

			if not fnafgm_disablepower:GetBool() then

				gm.Vars.power = gm.Vars.power - gm.Vars.foxyknockdoorpena
				gm:Log(gm.AnimatronicName[me] .. " removed " .. gm.Vars.foxyknockdoorpena .. "% of the power")
				fnafgmPowerUpdate()
				if gm.Vars.foxyknockdoorpena <= 10 then gm.Vars.foxyknockdoorpena = gm.Vars.foxyknockdoorpena + gm.Vars.addfoxyknockdoorpena end

				end

			end

		if me == gm.Animatronic.RainbowDash then

			timer.Create("fnafgmFoxyReset", 1, 1, function()
				self:SetPos(gm.AnimatronicAPos[me][map][gm.APos[map].Trash][1])
				self:SetAngles(gm.AnimatronicAPos[me][map][gm.APos[map].Trash][2])
				gm:SetAnimatronicPos(nil,me,gm.APos[map].Trash)
				timer.Remove("fnafgmFoxyReset")
			end)

		else
			gm:SetAnimatronicPos(nil, me, gm.APos[map].SS)
		end

	end

	return true

end
hook.Add("fnafgmCustomJumpscare", "fnapgmJumpscare", fnapgmJumpscare)


function fnapgmAutoMove(a)

	local gm = GAMEMODE
	local map = game.GetMap()

	if map == "fnap_scc" and a == gm.Animatronic.Rarity then

		local apos

		if gm.Vars.Animatronics[a][2] == gm.APos.fnap_scc.SS then
			apos = gm.APos.fnap_scc.Entrance
		elseif gm.Vars.Animatronics[a][2] == gm.APos.fnap_scc.Entrance then
			apos = gm.APos.fnap_scc.EntranceD
		elseif gm.Vars.Animatronics[a][2] == gm.APos.fnap_scc.EntranceD then
			apos = gm.APos.fnap_scc.DA
		elseif gm.Vars.Animatronics[a][2] == gm.APos.fnap_scc.DA then
			apos = gm.APos.fnap_scc.StaffD
		elseif gm.Vars.Animatronics[a][2] == gm.APos.fnap_scc.StaffD then
			apos = gm.APos.fnap_scc.Staff
		elseif gm.Vars.Animatronics[a][2] == gm.APos.fnap_scc.Staff then
			apos = gm.APos.fnap_scc.Office
		end

		return apos

	elseif a == gm.Animatronic.Pinkie then

		gm.Vars.Animatronics[a][1]:Taunt()

	end

end
hook.Add("fnafgmChangeAutoMove", "fnapgmAutoMove", fnapgmAutoMove)
