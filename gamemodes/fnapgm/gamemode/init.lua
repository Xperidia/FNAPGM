--[[---------------------------------------------------------

  Five Nights at Freddy's Gamemode Derive

  "Five Nights at Freddy's" is a game by Scott Cawthon.

-----------------------------------------------------------]]
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
resource.AddWorkshop( "408243366" )
DeriveGamemode( "fnafgm" )


function fnapgmUse(ply, ent, test, test2)
	
	if (game.GetMap()=="fnap_scc") then
		
		if ( test or ( btn and btn:IsValid() and ent==btn and ply:IsValid() and ply:Alive() ) ) and !startday then
			
			startday = true
			tempostart = true
			night = night+1
			AMPM = GAMEMODE.AMPM
			time = GAMEMODE.TimeBase
			hourtime = hourtime+GAMEMODE.HourTime_add
			power = GAMEMODE.Power_Max
			nightpassed = false
			iniok = true
			norespawn = false
			foxyknockdoorpena = 2
			addfoxyknockdoorpena = 4
			
			btn:Fire("use")
			
			
			local sound = ""
			local mutetime = 0
			
			if night==1 then
				sound = GAMEMODE.Sound_Calls.fnap_scc[1]
				mute = false
				mutetime = 64.2
			elseif night==2 then
				sound = GAMEMODE.Sound_Calls.fnap_scc[2]
				mute = false
				mutetime = 46.7
			elseif night==3 then
				sound = GAMEMODE.Sound_Calls.fnap_scc[3]
				mute = false
				mutetime = 47.4
			elseif night==4 then
				sound = GAMEMODE.Sound_Calls.fnap_scc[4]
				mute = false
				mutetime = 64.3
			elseif night==5 then
				sound = GAMEMODE.Sound_Calls.fnap_scc[5]
				mute = false
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
			
			if Halloween or fnafgm_forceseasonalevent:GetInt()==3 then
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "RainbowTimer" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "RainbowTimer" )[1]:Fire("UpperRandomBound", 120)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("LowerRandomBound", 10)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("UpperRandomBound", 20)
				
				ents.FindByName( "PinkieTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "PinkieTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "ApplejackTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "ApplejackTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.6)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0)
				
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase01", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase02", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase03", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase05", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase06", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase08", 0.6)
			elseif night==1 then
				ents.FindByName( "PinkieTimer" )[1]:Fire("Kill")
				ents.FindByName( "RainbowTimer" )[1]:Fire("Kill")
				ents.FindByName( "ApplejackTimer" )[1]:Fire("Kill")
				
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 40)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 60)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 40)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 60)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 40)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 60)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0.6)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0.6)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.3)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.5)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.5)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.3)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0.3)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0.3)
			elseif night==2 then
				ents.FindByName( "PinkieTimer" )[1]:Fire("Kill")
				ents.FindByName( "ApplejackTimer" )[1]:Fire("Kill")
				
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 50)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 50)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 50)
				
				ents.FindByName( "RainbowTimer" )[1]:Fire("LowerRandomBound", 150)
				ents.FindByName( "RainbowTimer" )[1]:Fire("UpperRandomBound", 400)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("UpperRandomBound", 50)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.4)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.5)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.5)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0.2)
			elseif night==3 then
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 15)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 30)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 15)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 30)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 15)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 30)
				
				ents.FindByName( "RainbowTimer" )[1]:Fire("LowerRandomBound", 120)
				ents.FindByName( "RainbowTimer" )[1]:Fire("UpperRandomBound", 300)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("UpperRandomBound", 50)
				
				ents.FindByName( "PinkieTimer" )[1]:Fire("LowerRandomBound", 20)
				ents.FindByName( "PinkieTimer" )[1]:Fire("UpperRandomBound", 40)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0.3)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0.3)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.6)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.6)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.4)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.4)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0.2)
				
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase01", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase02", 0.6)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase03", 0.6)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase04", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase07", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase08", 0.4)
			elseif night==4 then
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 10)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 20)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 10)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 20)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 10)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 20)
				
				ents.FindByName( "RainbowTimer" )[1]:Fire("LowerRandomBound", 60)
				ents.FindByName( "RainbowTimer" )[1]:Fire("UpperRandomBound", 260)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("LowerRandomBound", 20)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("UpperRandomBound", 40)
				
				ents.FindByName( "PinkieTimer" )[1]:Fire("LowerRandomBound", 10)
				ents.FindByName( "PinkieTimer" )[1]:Fire("UpperRandomBound", 20)
				
				ents.FindByName( "ApplejackTimer" )[1]:Fire("LowerRandomBound", 15)
				ents.FindByName( "ApplejackTimer" )[1]:Fire("UpperRandomBound", 30)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0.3)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0.3)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0.2)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0.2)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.4)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.5)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.3)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.3)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0.2)
				
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase01", 0.4)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase02", 0.6)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase03", 0.6)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase04", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase06", 0.6)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase07", 0.6)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase08", 0.5)
			elseif night==5 then
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 7)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 10)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 7)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 10)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 7)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 10)
				
				ents.FindByName( "RainbowTimer" )[1]:Fire("LowerRandomBound", 60)
				ents.FindByName( "RainbowTimer" )[1]:Fire("UpperRandomBound", 160)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("LowerRandomBound", 15)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("UpperRandomBound", 30)
				
				ents.FindByName( "PinkieTimer" )[1]:Fire("LowerRandomBound", 7)
				ents.FindByName( "PinkieTimer" )[1]:Fire("UpperRandomBound", 10)
				
				ents.FindByName( "ApplejackTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "ApplejackTimer" )[1]:Fire("UpperRandomBound", 15)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0.2)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0.2)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.3)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.3)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.6)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0)
				
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase01", 0.2)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase02", 0.3)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase03", 0.3)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase05", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase06", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase08", 0.6)
			elseif night==6 then
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "RainbowTimer" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "RainbowTimer" )[1]:Fire("UpperRandomBound", 120)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("LowerRandomBound", 10)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("UpperRandomBound", 20)
				
				ents.FindByName( "PinkieTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "PinkieTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "ApplejackTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "ApplejackTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.6)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0)
				
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase01", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase02", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase03", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase05", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase06", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase08", 0.6)
			else
				ents.FindByName( "RarityTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "RarityTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "TwilightTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "TwilightTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "FluttershyTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "FluttershyTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "RainbowTimer" )[1]:Fire("LowerRandomBound", 30)
				ents.FindByName( "RainbowTimer" )[1]:Fire("UpperRandomBound", 120)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("LowerRandomBound", 10)
				ents.FindByName( "RainbowTimer2" )[1]:Fire("UpperRandomBound", 20)
				
				ents.FindByName( "PinkieTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "PinkieTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "ApplejackTimer" )[1]:Fire("LowerRandomBound", 5)
				ents.FindByName( "ApplejackTimer" )[1]:Fire("UpperRandomBound", 7)
				
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase01", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase02", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase05", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase06", 0.5)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase08", 0.7)
				ents.FindByName( "FluttershyCase" )[1]:SetKeyValue("ProbCase09", 0.6)
				
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase01", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase02", 0.2)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase03", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase04", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase05", 0.7)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase06", 0.6)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase07", 0)
				ents.FindByName( "TwilightCase" )[1]:SetKeyValue("ProbCase08", 0)
				
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase01", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase02", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase03", 0.5)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase04", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase05", 0)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase06", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase07", 0.7)
				ents.FindByName( "PinkieCase" )[1]:SetKeyValue("ProbCase08", 0.6)
			end
			
			if IsValid(ply) then
				MsgC( Color( 255, 255, 85 ), "FNAFGM: Night "..night.." started by "..ply:GetName().."\n" )
			else
				MsgC( Color( 255, 255, 85 ), "FNAFGM: Night "..night.." started by console/map/other\n" )
			end
			
			timer.Create( "fnafgmTempoStartU", 1.3, 1, function()
				
				fnafgmVarsUpdate()
				
				for k, v in pairs(team.GetPlayers(1)) do
					if v:Alive() then
						v:ScreenFade(SCREENFADE.OUT, color_black, 0.25, 8.2-1.3-0.25 )
					end
				end
				
				LightUse[1] = false
				LightUse[2] = false
				
				timer.Remove( "fnafgmTempoStartU" )
				
			end)
			
			timer.Create( "fnafgmTempoStartM", 1.6, 1, function()
				
				for k, v in pairs(team.GetPlayers(1)) do
					if v:Alive() and !CheckPlayerSecurityRoom(v) then
						v:SetPos( Vector( -465, -255, 32 ) )
						v:SetEyeAngles(Angle( 0, 0, 0 ))
					end
				end
				
				timer.Remove( "fnafgmTempoStartM" )
				
			end)
			
			timer.Create( "fnafgmTempoStart", 8.2, 1, function()
				
				tempostart = false
				
				fnafgmVarsUpdate()
				fnafgmPowerUpdate()
				
				if !mute then
					
					ents.FindByName("fnafgm_CallSprite")[1]:Fire("ToggleSprite")
				
					for k, v in pairs(ents.FindByName("fnafgm_CallSource")) do
						v:Fire("PlaySound")
					end
					
					timer.Create( "fnafgmEndCall", mutetime, 1, function()
						mute = true
						for k, v in pairs(ents.FindByName("fnafgm_CallButton")) do
							v:Fire("Use")
						end
					end)
					
				end
				
				for k, v in pairs(team.GetPlayers(1)) do
					if v:Team()==1 and v:Alive() and v:GetInfoNum("fnafgm_cl_autofnafview", 1)==1 then
						fnafgmFNaFView(v)
					end
				end
				
				timer.Create( "fnafgmTimeThink", hourtime, 0, fnafgmTimeThink)
				
				timer.Remove( "fnafgmTempoStart" )
				
			end)
			
			return false
		
		elseif !btn then
			
			error( "btn is not defined" )
		
			
		elseif btn and btn:IsValid() and ent==btn then
			
			return false
			
		end
	
	end
	
end
hook.Add( "fnafgmUseCustom", "fnapgmUse", fnapgmUse)


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
		
		mapoverrideok = true
		
	end
	
end
hook.Add( "fnafgmMapOverridesCustom", "fnapgmMapOverrides", fnapgmMapOverrides)

function fnapgmPowerCalc()

	if iniok and mapoverrideok and startday and active and (game.GetMap()=="fnap_scc") then
		
		powerusage = GAMEMODE.Power_Usage_Base
		
		if poweroff then
			
			powerusage = 0
			
		else
		
			local tabactualuse = false --Calc tab usage
			
			for k, v in pairs(team.GetPlayers(1)) do
				
				if tabused[v] and tabused[v]==true then
						
					tabactualuse = true
					
				end
				
			end
			
			if tabactualuse then -- Tab use
				
				powerusage = powerusage+1
				
			end
			
			if DoorClosed[1] then -- Door 1 use
				
				powerusage = powerusage+1
				
			end
			
			if DoorClosed[2] then -- Door 2 use
				
				powerusage = powerusage+1
				
			end
			
			if LightUse[1] or LightUse[2] then -- Lights use
				
				powerusage = powerusage+1
				
			end
			
			if AprilFool or fnafgm_forceseasonalevent:GetInt()==2 then -- Troll use
				
				powerusage = powerusage+5
				
			end
			
		end
		
		if powerusage==0 then
			
			powerdrain = 0
			
		else
			
			powerdrain = GAMEMODE.Power_Drain_Time
		
			for i=1, powerusage-1 do
				powerdrain = powerdrain/2
			end
			
			if powerchecktime==nil and oldpowerdrain==nil and !poweroff then
				
				powerchecktime = CurTime()+powerdrain
				oldpowerdrain = powerdrain
				
			elseif powerchecktime!=nil and oldpowerdrain!=nil and !poweroff then
				
				local calcchangepower = oldpowerdrain-powerdrain
				
				if powerchecktime<=CurTime()+calcchangepower then
					
					powerchecktime=nil
					oldpowerdrain=nil
					power = power-1
					fnapgmDigits(power)
				
				end
				
			end
		
		end
		
		if power<=0 and !poweroff then
			ents.FindByName( "NoMorePower" )[1]:Fire("use")
			for k, v in pairs(team.GetPlayers(1)) do
				if v:Alive() then
					v:SetPos( Vector( -465, -255, 32 ) )
				end
			end
			poweroff = true
			if !game.SinglePlayer() then norespawn = true end
			MsgC( Color( 255, 255, 85 ), "FNAFGM: The power is gone :)\n" )
		end
		
		fnafgmPowerUpdate()
		
	end
	
end
hook.Add( "fnafgmCustomPowerCalc", "fnapgmPowerCalc", fnapgmPowerCalc)


function fnapgmDigits(n)
	
	if !n then return end
	
	if n>99 then
		n=99
	elseif n<0 then
		n=0
	end
	
	left = math.floor(n/10)
	right = math.fmod(n,10)
	
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