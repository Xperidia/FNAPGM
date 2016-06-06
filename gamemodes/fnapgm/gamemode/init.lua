--[[---------------------------------------------------------

  Five Nights at Freddy's Gamemode Derive

  "Five Nights at Freddy's" is a game by Scott Cawthon.

-----------------------------------------------------------]]
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
resource.AddWorkshop( "408243366" )
DeriveGamemode( "fnafgm" )

if (game.GetMap()=="fnap_scc") then
	resource.AddWorkshop( "542724054" )
	resource.AddWorkshop( "542724293" )
	resource.AddWorkshop( "542724719" )
end


function fnapgmStartNightCustom(ply)
	
	if GAMEMODE.Vars.startday then return end
	
	if (game.GetMap()=="fnap_scc") then
		
		GAMEMODE:SetNightTemplate(true)
		
		if ( btn and btn:IsValid() ) then btn:Fire("use") end
		
		local sound = ""
		local mutetime = 0
		
		if GAMEMODE.Vars.night==1 then
			sound = GAMEMODE.Sound_Calls.fnap_scc[1]
			GAMEMODE.Vars.mute = false
			mutetime = 64.2
		elseif GAMEMODE.Vars.night==2 then
			sound = GAMEMODE.Sound_Calls.fnap_scc[2]
			GAMEMODE.Vars.mute = false
			mutetime = 46.7
		elseif GAMEMODE.Vars.night==3 then
			sound = GAMEMODE.Sound_Calls.fnap_scc[3]
			GAMEMODE.Vars.mute = false
			mutetime = 47.4
		elseif GAMEMODE.Vars.night==4 then
			sound = GAMEMODE.Sound_Calls.fnap_scc[4]
			GAMEMODE.Vars.mute = false
			mutetime = 64.3
		elseif GAMEMODE.Vars.night==5 then
			sound = GAMEMODE.Sound_Calls.fnap_scc[5]
			GAMEMODE.Vars.mute = false
			mutetime = 76.8
		end
		
		for k, v in pairs(ents.FindByName("fnafgm_CallSource")) do
			v:SetKeyValue( "message", sound )
		end
		
		for k, v in pairs(ents.FindByName("fnafgm_CallButton")) do
			v:Fire("addoutput", "OnPressed fnafgm_CallSource,Volume,0,0.00,1")
			v:Fire("addoutput", "OnPressed fnafgm_CallSprite,ToggleSprite,none,0,1")
			v:Fire("addoutput", "OnPressed fnafgm_link,MuteCall,,0,-1")
		end
		
		GAMEMODE:CreateAnimatronic(GAMEMODE.Animatronic.Pinkie, GAMEMODE.APos.fnap_scc.SS)
		GAMEMODE:CreateAnimatronic(GAMEMODE.Animatronic.Fluttershy, GAMEMODE.APos.fnap_scc.SS)
		GAMEMODE:CreateAnimatronic(GAMEMODE.Animatronic.Twilight, GAMEMODE.APos.fnap_scc.SS)
		GAMEMODE:CreateAnimatronic(GAMEMODE.Animatronic.Rarity, GAMEMODE.APos.fnap_scc.SS)
		GAMEMODE:CreateAnimatronic(GAMEMODE.Animatronic.Applejack, GAMEMODE.APos.fnap_scc.SS)
		GAMEMODE:CreateAnimatronic(GAMEMODE.Animatronic.RainbowDash, GAMEMODE.APos.fnap_scc.Trash)
		
		timer.Create( "fnafgmTempoStartU", 1.3, 1, function()
			
			fnafgmVarsUpdate()
			
			for k, v in pairs(team.GetPlayers(1)) do
				if v:Alive() then
					v:ScreenFade(SCREENFADE.OUT, color_black, 0.25, 8.2-1.3-0.25 )
				end
			end
			
			GAMEMODE.Vars.LightUse[1] = false
			GAMEMODE.Vars.LightUse[2] = false
			
			timer.Remove( "fnafgmTempoStartU" )
			
		end)
		
		timer.Create( "fnafgmTempoStartM", 1.6, 1, function()
			
			for k, v in pairs(player.GetAll()) do
				if v:Team()==1 and v:Alive() then
					v:SetPos( GAMEMODE.FNaFView.fnap_scc[1] )
					v:SetEyeAngles( GAMEMODE.FNaFView.fnap_scc[2] )
				end
			end
			
			timer.Remove( "fnafgmTempoStartM" )
			
		end)
		
		timer.Create( "fnafgmTempoStart", 8.2, 1, function()
			
			GAMEMODE.Vars.tempostart = false
			
			fnafgmVarsUpdate()
			fnafgmPowerUpdate()
			
			if IsValid(ents.FindByName( "RainbowTimer" )[1]) then ents.FindByName( "RainbowTimer" )[1]:Fire("Enable") end
			
			if !GAMEMODE.Vars.mute then
				
				ents.FindByName("fnafgm_CallSprite")[1]:Fire("ToggleSprite")
			
				for k, v in pairs(ents.FindByName("fnafgm_CallSource")) do
					v:Fire("PlaySound")
				end
				
				timer.Create( "fnafgmEndCall", mutetime, 1, function()
					GAMEMODE.Vars.mute = true
					for k, v in pairs(ents.FindByName("fnafgm_CallButton")) do
						v:Fire("Use")
					end
				end)
				
			end
			
			for k, v in pairs(team.GetPlayers(1)) do
				GAMEMODE:GoFNaFView(v,true)
			end
			
			for k, v in pairs(GAMEMODE.Vars.Animatronics) do
				
				if GAMEMODE.AnimatronicsCD[k] and GAMEMODE.AnimatronicsCD[k][game.GetMap()] and GAMEMODE.AnimatronicsMaxCD[k] and GAMEMODE.AnimatronicsMaxCD[k][game.GetMap()] then
					
					local randtime = math.random(GAMEMODE.AnimatronicsCD[k][game.GetMap()][GAMEMODE.Vars.night] or GAMEMODE.AnimatronicsCD[k][game.GetMap()][0], GAMEMODE.AnimatronicsMaxCD[k][game.GetMap()][GAMEMODE.Vars.night] or GAMEMODE.AnimatronicsMaxCD[k][game.GetMap()][0])
					if GAMEMODE.AnimatronicsCD[k][game.GetMap()][GAMEMODE.Vars.night]!=-1 then
						timer.Create( "fnafgmAnimatronicMove"..k, randtime, 0, function() GAMEMODE:AutoMoveAnimatronic(k) end)
					end
					
				else
					
					GAMEMODE:Log("Missing or incomplete cooldown info for animatronic "..((GAMEMODE.AnimatronicName[k].." ("..(k or 0)..")") or k or 0).."!")
					
				end
				
			end
			
			timer.Create( "fnafgmTimeThink", GAMEMODE.HourTime, 0, fnafgmTimeThink)
			
			timer.Remove( "fnafgmTempoStart" )
			
		end)
		
		if timer.Exists( "fnapgmPinkieScare" ) then
			
			timer.Adjust( "fnapgmPinkieScare", math.random(280, 370), 1, function()
				
				if GAMEMODE.Vars.startday then
					
					for k, v in pairs(player.GetAll()) do
						
						if v:Team()!=TEAM_UNASSIGNED and v:Alive() then
							
							v:SendLua('GAMEMODE:JumpscareOverlay("deathscreens/pinkieisscary",2)')
							v:SendLua([[LocalPlayer():EmitSound("fnapgm_pinkiescare")]])
							
						end
						
					end
					
				end
				
				timer.Remove( "fnapgmPinkieScare" )
				
			end)
			
		else
			
			timer.Create( "fnapgmPinkieScare", math.random(280, 370), 1, function()
				
				if GAMEMODE.Vars.startday then
					
					for k, v in pairs(player.GetAll()) do
						
						if v:Team()!=TEAM_UNASSIGNED and v:Alive() then
							
							v:SendLua('GAMEMODE:JumpscareOverlay("deathscreens/pinkieisscary",2)')
							v:SendLua([[LocalPlayer():EmitSound("fnapgm_pinkiescare")]])
							
						end
						
					end
					
				end
				
				timer.Remove( "fnapgmPinkieScare" )
				
			end)
			
		end
		
	elseif (game.GetMap()=="fnap_cb") then
		
		GAMEMODE:SetNightTemplate(false)
		if GAMEMODE.Vars.night==1 then
			GAMEMODE.Vars.power = 115
			GAMEMODE.Vars.powertot = 115
		elseif GAMEMODE.Vars.night==2 then
			GAMEMODE.Vars.power = 100
			GAMEMODE.Vars.powertot = 100
		elseif GAMEMODE.Vars.night==3 then
			GAMEMODE.Vars.power = 85
			GAMEMODE.Vars.powertot = 85
		elseif GAMEMODE.Vars.night==4 then
			GAMEMODE.Vars.power = 67
			GAMEMODE.Vars.powertot = 67
		else
			GAMEMODE.Vars.power = 50
			GAMEMODE.Vars.powertot = 50
		end
		
		timer.Create( "fnafgmTempoStartU", 1.3, 1, function()
			
			fnafgmVarsUpdate()
			
			for k, v in pairs(team.GetPlayers(1)) do
				if v:Alive() then
					v:ScreenFade(SCREENFADE.OUT, color_black, 0.25, 8.2-1.3-0.25 )
				end
			end
			
			timer.Remove( "fnafgmTempoStartU" )
			
		end)
		
		timer.Create( "fnafgmTempoStartM", 1.6, 1, function()
			
			for k, v in pairs(player.GetAll()) do
				if v:Team()==1 and v:Alive() then
					v:SetPos( GAMEMODE.FNaFView.fnap_cb[1] )
					v:SetEyeAngles( GAMEMODE.FNaFView.fnap_cb[2] )
				end
			end
			
			timer.Remove( "fnafgmTempoStartM" )
			
		end)
		
		timer.Create( "fnafgmTempoStart", 8.2, 1, function()
			
			GAMEMODE.Vars.tempostart = false
			
			fnafgmVarsUpdate()
			fnafgmPowerUpdate()
			
			for k, v in pairs(team.GetPlayers(1)) do
				GAMEMODE:GoFNaFView(v,true)
			end
			
			timer.Create( "fnafgmTimeThink", GAMEMODE.HourTime, 0, fnafgmTimeThink)
			
			timer.Remove( "fnafgmTempoStart" )
			
		end)
		
	end
	
	return true
	
end
hook.Add( "fnafgmCustomStart", "fnapgmStartNightCustom", fnapgmStartNightCustom)


function fnapgmMapOverrides()
	
	if (game.GetMap()=="fnap_scc") then
		
		for k, v in pairs(ents.FindByName("TimerButton")) do
			btn = v
		end
		
		for k, v in pairs(ents.FindByName("Door1Light")) do
			light1 = v
		end
		
		for k, v in pairs(ents.FindByName("Door2Light")) do
			light2 = v
		end
		
		for k, v in pairs(ents.FindByName("OfficeLightSwitch")) do
			light3 = v
		end
		
		if IsValid(ents.FindByName( "WarningTimer" )[1]) then ents.FindByName( "WarningTimer" )[1]:Fire("Kill") end
		if IsValid(ents.FindByName( "Warning" )[1]) then ents.FindByName( "Warning" )[1]:Fire("Kill") end
		
		GAMEMODE.Vars.mapoverrideok = true
		
	end
	
end
hook.Add( "fnafgmMapOverridesCustom", "fnapgmMapOverrides", fnapgmMapOverrides)

function fnapgmPowerCalc()

	if GAMEMODE.Vars.iniok and GAMEMODE.Vars.mapoverrideok and GAMEMODE.Vars.startday and GAMEMODE.Vars.active and (game.GetMap()=="fnap_scc") then
		
		GAMEMODE.Vars.powerusage = GAMEMODE.Power_Usage_Base
		
		if GAMEMODE.Vars.poweroff or fnafgm_disablepower:GetBool() then
			
			GAMEMODE.Vars.powerusage = 0
			
		else
		
			local tabactualuse = false --Calc tab usage
			
			for k, v in pairs(team.GetPlayers(1)) do
				
				if GAMEMODE.Vars.tabused[v] and GAMEMODE.Vars.tabused[v]==true then
					
					tabactualuse = true
					
				end
				
			end
			
			if tabactualuse then -- Tab use
				
				GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage+1
				
			end
			
			if GAMEMODE.Vars.DoorClosed[1] then -- Door 1 use
				
				GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage+1
				
			end
			
			if GAMEMODE.Vars.DoorClosed[2] then -- Door 2 use
				
				GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage+1
				
			end
			
			if GAMEMODE.Vars.LightUse[1] or GAMEMODE.Vars.LightUse[2] then -- Lights use
				
				GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage+1
				
			end
			
			if GAMEMODE.Vars.AprilFool or fnafgm_forceseasonalevent:GetInt()==2 then -- Troll use
				
				GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage+5
				
			end
			
		end
		
		if GAMEMODE.Vars.powerusage==0 then
			
			GAMEMODE.Vars.powerdrain = 0
			
		else
			
			GAMEMODE.Vars.powerdrain = GAMEMODE.Power_Drain_Time
		
			for i=1, GAMEMODE.Vars.powerusage-1 do
				GAMEMODE.Vars.powerdrain = GAMEMODE.Vars.powerdrain/2
			end
			
			if GAMEMODE.Vars.powerchecktime==nil and GAMEMODE.Vars.oldpowerdrain==nil and !GAMEMODE.Vars.poweroff then
				
				GAMEMODE.Vars.powerchecktime = CurTime()+GAMEMODE.Vars.powerdrain
				GAMEMODE.Vars.oldpowerdrain = GAMEMODE.Vars.powerdrain
				
			elseif GAMEMODE.Vars.powerchecktime!=nil and GAMEMODE.Vars.oldpowerdrain!=nil and !GAMEMODE.Vars.poweroff then
				
				local calcchangepower = GAMEMODE.Vars.oldpowerdrain-GAMEMODE.Vars.powerdrain
				
				if GAMEMODE.Vars.powerchecktime<=CurTime()+calcchangepower then
					
					GAMEMODE.Vars.powerchecktime=nil
					GAMEMODE.Vars.oldpowerdrain=nil
					GAMEMODE.Vars.power = GAMEMODE.Vars.power-1
					fnapgmDigits(GAMEMODE.Vars.power)
				
				end
				
			end
		
		end
		
		if GAMEMODE.Vars.power<=0 and !GAMEMODE.Vars.poweroff then
			
			ents.FindByName( "NoMorePower" )[1]:Fire("use")
			
			for k, v in pairs(player.GetAll()) do
				if v:Team()==1 and v:Alive() then
					v:SetPos( Vector( -465, -255, 32 ) )
				end
			end
			
			for k, v in pairs(GAMEMODE.Vars.Animatronics) do
				
				if k!=GAMEMODE.Animatronic.RainbowDash then
					GAMEMODE:SetAnimatronicPos(nil,k,GAMEMODE.APos[game.GetMap()].SS)
				end
				timer.Remove( "fnafgmAnimatronicMove"..k )
				
			end
			
			GAMEMODE.Vars.poweroff = true
			if !game.SinglePlayer() then norespawn = true end
			GAMEMODE:Log("The power is gone :)")
			
			timer.Create( "fnapgmNoMorePower", 10, 1, function()
				
				for k, v in pairs(GAMEMODE.Vars.Animatronics) do
					
					if k!=GAMEMODE.Animatronic.Applejack and k!=GAMEMODE.Animatronic.RainbowDash then
						GAMEMODE:SetAnimatronicPos(nil,k,GAMEMODE.APos[game.GetMap()].Office)
					end
					
				end
				
				timer.Remove( "fnapgmNoMorePower" )
				
			end)
			
		end
		
		fnafgmPowerUpdate()
		
	elseif GAMEMODE.Vars.iniok and GAMEMODE.Vars.mapoverrideok and GAMEMODE.Vars.startday and GAMEMODE.Vars.active and (game.GetMap()=="fnap_cb") then
		
		GAMEMODE.Vars.powerusage = 0
		
		if !GAMEMODE.Vars.poweroff and !fnafgm_disablepower:GetBool() then
			
			if GAMEMODE.Vars.LightUse[1] or GAMEMODE.Vars.LightUse[2] or GAMEMODE.Vars.LightUse[3] then
				
				GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage + 1
				
			end
			
			for k, v in pairs(ents.FindByClass( "fnafgm_camera" )) do
				
				if v.GetLightState and v:GetLightState() then
					
					GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage + 1
					break
					
				end
				
			end
			
			for k, v in pairs(team.GetPlayers(1)) do
				
				if v:FlashlightIsOn() then
					
					GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage + 1
					break
					
				end
				
			end
			
		end
		
		if GAMEMODE.Vars.powerusage==0 or !GAMEMODE.Vars.powerchecktime then
			
			GAMEMODE.Vars.powerchecktime = CurTime()+1
			
		else
			
			if GAMEMODE.Vars.powerchecktime<=CurTime() then
				
				GAMEMODE.Vars.powerchecktime = CurTime()+1
				GAMEMODE.Vars.power = GAMEMODE.Vars.power-1
				
			end
		
		end
		
		if GAMEMODE.Vars.power==0 and !GAMEMODE.Vars.poweroff then
			
			GAMEMODE.Vars.poweroff = true
			
			for k, v in pairs(team.GetPlayers(1)) do
				
				if v:FlashlightIsOn() and !fnafgmPlayerCanByPass(v,"flashlight") then
					
					v:Flashlight( false )
					
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_lighterror")]])
					
				end
				
			end
			
			GAMEMODE:Log("The battery is dead")
			
		end
		
		fnafgmPowerUpdate()
		
	end
	
end
hook.Add( "fnafgmCustomPowerCalc", "fnapgmPowerCalc", fnapgmPowerCalc)

function fnapgmGeneralDeath()
	if IsValid(ents.FindByName( "RainbowTimer" )[1]) then ents.FindByName( "RainbowTimer" )[1]:Fire("Disable") end
end
hook.Add( "fnafgmGeneralDeath", "fnapgmGeneralDeath", fnapgmGeneralDeath)

function fnapgmDigits(n)
	
	if !n then return end
	
	if n>99 then
		n=99
	elseif n<0 then
		n=0
	end
	
	local left = math.floor(n/10)
	local right = math.fmod(n,10)
	
	if left==0 and n!=0 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	elseif left==1 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	elseif left==2 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	elseif left==3 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	elseif left==4 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	elseif left==5 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Disable")
	elseif left==6 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Disable")
	elseif left==7 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	elseif left==8 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	elseif left==9 then
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Enable")
	else
		ents.FindByName( "Timer_#1_SegmentE1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentG1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA1" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentB1" )[1]:Fire("Disable")
	end
	if right==0 and n!=0 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	elseif right==1 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	elseif right==2 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	elseif right==3 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	elseif right==4 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	elseif right==5 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Disable")
	elseif right==6 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Disable")
	elseif right==7 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	elseif right==8 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	elseif right==9 then
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Enable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Enable")
	else
		ents.FindByName( "Timer_#1_SegmentE" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentG" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentF" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentD" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentC" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentA" )[1]:Fire("Disable")
		ents.FindByName( "Timer_#1_SegmentB" )[1]:Fire("Disable")
	end
end


function fnapgmRainbowDash(self)
	
	if self:GetAType()==GAMEMODE.Animatronic.RainbowDash then
		
		if self.FoxyMove then
			self.FoxyMove = false
			self.FoxyMove2 = true
			for k, v in pairs(player.GetAll()) do
				
				if v:Team()!=TEAM_CONNECTING and v:Team()!=TEAM_UNASSIGNED then
					
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
hook.Add( "fnafgmCustomFoxy", "fnapgmRainbowDash", fnapgmRainbowDash)


function fnapgmWindowScare(self,me,apos)
	
	if game.GetMap()=="fnap_scc" then
		
		if me==GAMEMODE.Animatronic.Pinkie then
			
			if apos==GAMEMODE.APos.fnap_scc.Office and GAMEMODE.Vars.LightUse[1] and !self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos==GAMEMODE.APos.fnap_scc.Office and !GAMEMODE.Vars.LightUse[1] and self.wsip then
				self.wsip = false
			elseif apos!=GAMEMODE.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end
			
		elseif me==GAMEMODE.Animatronic.Fluttershy then
			
			if apos==GAMEMODE.APos.fnap_scc.Office and GAMEMODE.Vars.LightUse[2] and !self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos==GAMEMODE.APos.fnap_scc.Office and !GAMEMODE.Vars.LightUse[2] and self.wsip then
				self.wsip = false
			elseif apos!=GAMEMODE.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end
			
		elseif me==GAMEMODE.Animatronic.Twilight then
			
			if apos==GAMEMODE.APos.fnap_scc.Office and GAMEMODE.Vars.LightUse[2] and !self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos==GAMEMODE.APos.fnap_scc.Office and !GAMEMODE.Vars.LightUse[2] and self.wsip then
				self.wsip = false
			elseif apos!=GAMEMODE.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end
			
		elseif me==GAMEMODE.Animatronic.Rarity then
			
			if apos==GAMEMODE.APos.fnap_scc.Office and GAMEMODE.Vars.LightUse[1] and !self.wsip then
				self:EmitSound("fnafgm_windowscare")
				self.wsip = true
			elseif apos==GAMEMODE.APos.fnap_scc.Office and !GAMEMODE.Vars.LightUse[1] and self.wsip then
				self.wsip = false
			elseif apos!=GAMEMODE.APos.fnap_scc.Office and self.wsip then
				self.wsip = false
			end
			
		end
		
	end
	
	return true
	
end
hook.Add( "fnafgmWindowScare", "fnapgmWindowScare", fnapgmWindowScare)


function fnapgmFixPos(self,me,apos)
	
	if me!=GAMEMODE.Animatronic.RainbowDash and GAMEMODE.AnimatronicAPos[me] and GAMEMODE.AnimatronicAPos[me][game.GetMap()] and GAMEMODE.AnimatronicAPos[me][game.GetMap()][apos] then
		self:SetPos(GAMEMODE.AnimatronicAPos[me][game.GetMap()][apos][1])
	end
	
	return true
	
end
hook.Add( "fnafgmFixPos", "fnapgmFixPos", fnapgmFixPos)


function fnapgmGoJumpscare(me,self,timet)
	
	if (game.GetMap()=="fnap_scc") then
		
		if GAMEMODE.Vars.poweroff then return true end
		
		if me==GAMEMODE.Animatronic.Applejack then
			for k, v in pairs(player.GetAll()) do
				if v:Team()!=TEAM_CONNECTING and v:Team()!=TEAM_UNASSIGNED then
					v:SendLua([[LocalPlayer():EmitSound("fnapgm_applejackscream")]])
				end
			end
		elseif me==GAMEMODE.Animatronic.Rarity then
			for k, v in pairs(player.GetAll()) do
				if v:Team()!=TEAM_CONNECTING and v:Team()!=TEAM_UNASSIGNED then
					v:SendLua([[LocalPlayer():EmitSound("fnapgm_rarityknock")]])
				end
			end
		elseif me!=GAMEMODE.Animatronic.RainbowDash then
			for k, v in pairs(player.GetAll()) do
				if v:Team()!=TEAM_CONNECTING and v:Team()!=TEAM_UNASSIGNED then
					v:SendLua([[LocalPlayer():EmitSound("fnapgm_officesnd")]])
				end
			end
		end
		
		if me==GAMEMODE.Animatronic.RainbowDash then
			self.FoxyWillMove = true
			if IsValid(ents.FindByName( "RDDoor" )[1]) then ents.FindByName( "RDDoor" )[1]:Fire("Open") end
			local flight = ents.FindByName( "FluoLight" )[1]
			if IsValid(flight) then
				flight:Fire("TurnOff")
				flight:Fire("TurnOn",NULL,2)
			end
			local tlight = ents.FindByName( "TimerLightDoor3" )[1]
			if IsValid(tlight) then
				tlight:Fire("Disable")
				tlight:Fire("Enable",NULL,2)
			end
			timet = timet * 2
		end
		
		timer.Create( "fnafgmJumpscare"..me, timet, 1, function()
			
			local sgdead = true
			for k, v in pairs(player.GetAll()) do
				if v:Alive() and v:Team()==1 then
					sgdead = false
					break
				end
			end
			
			if sgdead then timer.Remove( "fnafgmJumpscare"..me ) return end
			
			if GAMEMODE.Vars.startday and me!=GAMEMODE.Animatronic.RainbowDash then
				self:Jumpscare()
			elseif GAMEMODE.Vars.startday then
				
				self.FoxyWillMove2 = true
				
				local flight = ents.FindByName( "FluoLight" )[1]
				if IsValid(flight) then
					flight:Fire("TurnOff")
					flight:Fire("TurnOn",NULL,2)
				end
				local tlight = ents.FindByName( "TimerLightDoor3" )[1]
				if IsValid(tlight) then
					tlight:Fire("Disable")
					tlight:Fire("Enable",NULL,2)
				end
				
				timer.Create( "fnapgmRDmove", timet, 1, function()
					
					if IsValid(ents.FindByName( "RDDoor" )[1]) then ents.FindByName( "RDDoor" )[1]:Fire("Close",NULL,0.2) end
					local DoorRD = ents.FindByName( "DoorRD" )[1]
					if IsValid(DoorRD) then
						DoorRD:Fire("Open",NULL,0.8)
						DoorRD:Fire("Close",NULL,3)
					end
					
					self.FoxyWillMove = false
					self.FoxyWillMove2 = false
					self.FoxyMove = true
					
					timer.Remove( "fnapgmRDmove" )
					
				end)
				
			end
			
			timer.Remove( "fnafgmJumpscare"..me )
			
		end)
		
	end
	
	return true
	
end
hook.Add( "fnafgmCustomGoJumpscare", "fnapgmGoJumpscare", fnapgmGoJumpscare)


function fnapgmJumpscare(me,self)
	
	if (game.GetMap()=="fnap_scc") then
		
		if me==GAMEMODE.Animatronic.Pinkie and !GAMEMODE.Vars.DoorClosed[1] then
			
			for k, v in pairs(player.GetAll()) do
				
				if v:Team()==1 and v:Alive() and v.IsOnSecurityRoom then
					
					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_'..me..'")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self )
					
				end
				
			end
			
			GAMEMODE:Log("Jumpscared by "..GAMEMODE.AnimatronicName[me])
			
		elseif me==GAMEMODE.Animatronic.Fluttershy and !GAMEMODE.Vars.DoorClosed[2] then
			
			for k, v in pairs(player.GetAll()) do
				
				if v:Team()==1 and v:Alive() and v.IsOnSecurityRoom then
					
					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_'..me..'")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self )
					
				end
				
			end
			
			GAMEMODE:Log("Jumpscared by "..GAMEMODE.AnimatronicName[me])
			
		elseif me==GAMEMODE.Animatronic.Twilight and !GAMEMODE.Vars.DoorClosed[2] then
			
			for k, v in pairs(player.GetAll()) do
				
				if v:Team()==1 and v:Alive() and v.IsOnSecurityRoom then
					
					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_'..me..'")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self )
					
				end
				
			end
			
			GAMEMODE:Log("Jumpscared by "..GAMEMODE.AnimatronicName[me])
			
		elseif me==GAMEMODE.Animatronic.Rarity and !GAMEMODE.Vars.DoorClosed[1] then
			
			for k, v in pairs(player.GetAll()) do
				
				if v:Team()==1 and v:Alive() and v.IsOnSecurityRoom then
					
					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_'..me..'")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self )
					
				end
				
			end
			
			GAMEMODE:Log("Jumpscared by "..GAMEMODE.AnimatronicName[me])
			
		elseif me==GAMEMODE.Animatronic.Applejack and GAMEMODE.Vars.LightUse[3] then
			
			for k, v in pairs(player.GetAll()) do
				
				if v:Team()==1 and v:Alive() and v.IsOnSecurityRoom then
					
					v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_'..me..'")')
					v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
					v:TakeDamage(100, self )
					
				end
				
			end
			
			GAMEMODE:Log("Jumpscared by "..GAMEMODE.AnimatronicName[me])
			
			elseif me==GAMEMODE.Animatronic.RainbowDash and !GAMEMODE.Vars.DoorClosed[2] then
				
				for k, v in pairs(player.GetAll()) do
					
					if v:Team()==1 and v:Alive() and v.IsOnSecurityRoom then
						
						v:SendLua('GAMEMODE:JumpscareOverlay("fnapgm/screamers/fnap_scc_'..me..'")')
						v:SendLua([[LocalPlayer():EmitSound("fnafgm_scream")]])
						v:TakeDamage(100, self )
						
					end
					
				end
				
				GAMEMODE:Log("Jumpscared by "..GAMEMODE.AnimatronicName[me])
				
		elseif me==GAMEMODE.Animatronic.RainbowDash then
			
			for k, v in pairs(player.GetAll()) do
				
				if v:Team()!=TEAM_CONNECTING and v:Team()!=TEAM_UNASSIGNED then
					
					v:SendLua([[LocalPlayer():EmitSound("fnapgm_rainbowknock")]])
					
				end
				
			end
			
			if !fnafgm_disablepower:GetBool() then
				
				GAMEMODE.Vars.power = GAMEMODE.Vars.power - GAMEMODE.Vars.foxyknockdoorpena
				GAMEMODE:Log(GAMEMODE.AnimatronicName[me].." removed "..GAMEMODE.Vars.foxyknockdoorpena.."% of the power")
				fnafgmPowerUpdate()
				if GAMEMODE.Vars.foxyknockdoorpena<=10 then GAMEMODE.Vars.foxyknockdoorpena = GAMEMODE.Vars.foxyknockdoorpena + GAMEMODE.Vars.addfoxyknockdoorpena end
				
				end
				
			end
		
		if me==GAMEMODE.Animatronic.RainbowDash then
			
			timer.Create( "fnafgmFoxyReset", 1, 1, function()
				self:SetPos(GAMEMODE.AnimatronicAPos[me][game.GetMap()][GAMEMODE.APos[game.GetMap()].Trash][1])
				self:SetAngles(GAMEMODE.AnimatronicAPos[me][game.GetMap()][GAMEMODE.APos[game.GetMap()].Trash][2])
				GAMEMODE:SetAnimatronicPos(nil,me,GAMEMODE.APos[game.GetMap()].Trash)
				timer.Remove( "fnafgmFoxyReset" )
			end)
			
		else
			GAMEMODE:SetAnimatronicPos(nil,me,GAMEMODE.APos[game.GetMap()].SS)
		end
		
	end
	
	return true
	
end
hook.Add( "fnafgmCustomJumpscare", "fnapgmJumpscare", fnapgmJumpscare)


function fnapgmAutoMove(a)
	
	if game.GetMap()=="fnap_scc" and a==GAMEMODE.Animatronic.Rarity then
		
		local apos
		
		if GAMEMODE.Vars.Animatronics[a][2]==GAMEMODE.APos.fnap_scc.SS then
			apos = GAMEMODE.APos.fnap_scc.Entrance
		elseif GAMEMODE.Vars.Animatronics[a][2]==GAMEMODE.APos.fnap_scc.Entrance then
			apos = GAMEMODE.APos.fnap_scc.EntranceD
		elseif GAMEMODE.Vars.Animatronics[a][2]==GAMEMODE.APos.fnap_scc.EntranceD then
			apos = GAMEMODE.APos.fnap_scc.DA
		elseif GAMEMODE.Vars.Animatronics[a][2]==GAMEMODE.APos.fnap_scc.DA then
			apos = GAMEMODE.APos.fnap_scc.StaffD
		elseif GAMEMODE.Vars.Animatronics[a][2]==GAMEMODE.APos.fnap_scc.StaffD then
			apos = GAMEMODE.APos.fnap_scc.Staff
		elseif GAMEMODE.Vars.Animatronics[a][2]==GAMEMODE.APos.fnap_scc.Staff then
			apos = GAMEMODE.APos.fnap_scc.Office
		end
		
		return apos
		
	elseif a==GAMEMODE.Animatronic.Pinkie then
		
		GAMEMODE.Vars.Animatronics[a][1]:Taunt()
		
	end
	
end
hook.Add( "fnafgmChangeAutoMove", "fnapgmAutoMove", fnapgmAutoMove)
