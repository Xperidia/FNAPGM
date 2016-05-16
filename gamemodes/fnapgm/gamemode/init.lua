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
		elseif GAMEMODE.Vars.night==1 then
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
		elseif GAMEMODE.Vars.night==2 then
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
		elseif GAMEMODE.Vars.night==3 then
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
		elseif GAMEMODE.Vars.night==4 then
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
		elseif GAMEMODE.Vars.night==5 then
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
		elseif GAMEMODE.Vars.night==6 then
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
			
			for k, v in pairs(team.GetPlayers(1)) do
				if v:Alive() and !GAMEMODE:CheckPlayerSecurityRoom(v) then
					v:SetPos( Vector( -465, -255, 32 ) )
					v:SetEyeAngles(Angle( 0, 0, 0 ))
				end
			end
			
			timer.Remove( "fnafgmTempoStartM" )
			
		end)
		
		timer.Create( "fnafgmTempoStart", 8.2, 1, function()
			
			GAMEMODE.Vars.tempostart = false
			
			fnafgmVarsUpdate()
			fnafgmPowerUpdate()
			
			if IsValid(ents.FindByName( "ApplejackTimer" )[1]) then ents.FindByName( "ApplejackTimer" )[1]:Fire("Enable") end
			if IsValid(ents.FindByName( "FluttershyTimer" )[1]) then ents.FindByName( "FluttershyTimer" )[1]:Fire("Enable") end
			if IsValid(ents.FindByName( "PinkieTimer" )[1]) then ents.FindByName( "PinkieTimer" )[1]:Fire("Enable") end
			if IsValid(ents.FindByName( "RainbowTimer" )[1]) then ents.FindByName( "RainbowTimer" )[1]:Fire("Enable") end
			if IsValid(ents.FindByName( "RarityTimer" )[1]) then ents.FindByName( "RarityTimer" )[1]:Fire("Enable") end
			if IsValid(ents.FindByName( "TwilightTimer" )[1]) then ents.FindByName( "TwilightTimer" )[1]:Fire("Enable") end
			if IsValid(ents.FindByName( "NewTwilyTimer" )[1]) then ents.FindByName( "NewTwilyTimer" )[1]:Fire("Enable") end
			
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
				if v:Team()==1 and v:Alive() and v:GetInfoNum("fnafgm_cl_autofnafview", 1)==1 then
					GAMEMODE:GoFNaFView(v)
				end
			end
			
			timer.Create( "fnafgmTimeThink", GAMEMODE.HourTime, 0, fnafgmTimeThink)
			
			timer.Remove( "fnafgmTempoStart" )
			
		end)
		
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
			
			for k, v in pairs(team.GetPlayers(1)) do
				if v:Alive() and !GAMEMODE:CheckPlayerSecurityRoom(v) then
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
				if v:Team()==1 and v:Alive() and v:GetInfoNum("fnafgm_cl_autofnafview", 1)==1 then
					GAMEMODE:GoFNaFView(v)
				end
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
		
		if GAMEMODE.Vars.poweroff then
			
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
				
			else
				
				for k, v in pairs(ents.FindByClass( "fnafgm_camera" )) do
					
					if v:GetLightState() then
						
						GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage+1
						break
						
					end
					
				end
				
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
			for k, v in pairs(team.GetPlayers(1)) do
				if v:Alive() then
					v:SetPos( Vector( -465, -255, 32 ) )
				end
			end
			GAMEMODE.Vars.poweroff = true
			if !game.SinglePlayer() then norespawn = true end
			GAMEMODE:Log("The power is gone :)")
		end
		
		fnafgmPowerUpdate()
		
	elseif GAMEMODE.Vars.iniok and GAMEMODE.Vars.mapoverrideok and GAMEMODE.Vars.startday and GAMEMODE.Vars.active and (game.GetMap()=="fnap_cb") then
		
		GAMEMODE.Vars.powerusage = 0
		
		if !GAMEMODE.Vars.poweroff then
			
			if GAMEMODE.Vars.LightUse[1] or GAMEMODE.Vars.LightUse[2] or GAMEMODE.Vars.LightUse[3] then
				
				GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage + 1
				
			end
			
			for k, v in pairs(ents.FindByClass( "fnafgm_camera" )) do
				
				if v:GetLightState() then
					
					GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage+1
					
				end
				
			end
			
			for k, v in pairs(team.GetPlayers(1)) do
				
				if v:FlashlightIsOn() then
					
					GAMEMODE.Vars.powerusage = GAMEMODE.Vars.powerusage + 1
					
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
					
					v:ConCommand("play "..GAMEMODE.Sound_lighterror)
					
				end
				
			end
			
			GAMEMODE:Log("The battery is dead")
			
		end
		
		fnafgmPowerUpdate()
		
	end
	
end
hook.Add( "fnafgmCustomPowerCalc", "fnapgmPowerCalc", fnapgmPowerCalc)

function fnapgmGeneralDeath()
	if IsValid(ents.FindByName( "ApplejackTimer" )[1]) then ents.FindByName( "ApplejackTimer" )[1]:Fire("Disable") end
	if IsValid(ents.FindByName( "FluttershyTimer" )[1]) then ents.FindByName( "FluttershyTimer" )[1]:Fire("Disable") end
	if IsValid(ents.FindByName( "PinkieTimer" )[1]) then ents.FindByName( "PinkieTimer" )[1]:Fire("Disable") end
	if IsValid(ents.FindByName( "RainbowTimer" )[1]) then ents.FindByName( "RainbowTimer" )[1]:Fire("Disable") end
	if IsValid(ents.FindByName( "RarityTimer" )[1]) then ents.FindByName( "RarityTimer" )[1]:Fire("Disable") end
	if IsValid(ents.FindByName( "TwilightTimer" )[1]) then ents.FindByName( "TwilightTimer" )[1]:Fire("Disable") end
	if IsValid(ents.FindByName( "NewTwilyTimer" )[1]) then ents.FindByName( "NewTwilyTimer" )[1]:Fire("Disable") end
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