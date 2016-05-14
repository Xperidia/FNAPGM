include( 'shared.lua' )
DeriveGamemode( "fnafgm" )

function fnapgmSecurityTabletInit()
	
	if game.GetMap()=="fnap_scc" then
		if !GAMEMODE.Vars.lastcam then
			GAMEMODE.Vars.lastcam = 2
		end
		LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
	else
		if !GAMEMODE.Vars.lastcam then
			GAMEMODE.Vars.lastcam = 1
		end
		LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
	end
	
	return true
	
end
hook.Add( "fnafgmSecurityTabletCustomInit", "fnapgmSecurityTabletInit", fnapgmSecurityTabletInit)

function fnapgmSecurityTablet()
	
	if game.GetMap()=="fnap_scc" then
		
		local CamsNames = vgui.Create( "DLabel" )
		CamsNames:SetParent(Monitor)
		CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		CamsNames:SetTextColor( Color( 255, 255, 255, 255 ) )
		CamsNames:SetFont("FNAFGMTIME")
		CamsNames:SetPos( ScrW()-64-512, ScrH()-64-512 )
		CamsNames:SetSize( 512, 64 )
		
		if !GAMEMODE.Vars.mute then
			local MUTET = vgui.Create( "DImage" )
			MUTET:SetParent(Monitor)
			MUTET:SetImage( "fnafgm/mute" )
			MUTET:SetSize( 128, 32 )
			MUTET:SetPos( 64, 64 )
			
			local MUTEbT = vgui.Create( "DButton" )
			MUTEbT:SetParent(MUTET)
			MUTEbT:SetSize( 121, 31 )
			MUTEbT:SetPos( 0, 0 )
			MUTEbT:SetText( "" )
			MUTEbT.DoClick = function( button )
				fnafgmMuteCall()
				MUTET:Remove()
				MUTEbT:Remove()
			end
			MUTEbT.Paint = function( self, w, h )
				
			end
		end
		
		local map = vgui.Create( "DImage" )
		map:SetParent(Monitor)
		map:SetImage( "fnapgm/maps/fnap_scc_1" )
		map:SetPos( ScrW()-64-512, ScrH()-64-512 )
		map:SetSize( 512, 512 )
		
		local map2 = vgui.Create( "DImage" )
		map2:SetParent(Monitor)
		map2:SetImage( "fnapgm/maps/fnap_scc_2" )
		map2:SetPos( 64, ScrH()-64-512 )
		map2:SetSize( 512, 512 )
		
		local Kitchen = vgui.Create( "DButton" )
		Kitchen:SetParent(map)
		Kitchen:SetSize( 78.5, 48.5 )
		Kitchen:SetPos( 91, 224 )
		Kitchen:SetText( "" )
		Kitchen.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 1 )
			GAMEMODE.Vars.lastcam = 1
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Kitchen.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==1 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Stage = vgui.Create( "DButton" )
		Stage:SetParent(map)
		Stage:SetSize( 78.5, 48.5 )
		Stage:SetPos( 206, 229.5 )
		Stage:SetText( "" )
		Stage.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 2 )
			GAMEMODE.Vars.lastcam = 2
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Stage.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==2 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end

		local Dining_Area = vgui.Create( "DButton" )
		Dining_Area:SetParent(map)
		Dining_Area:SetSize( 78.5, 48.5 )
		Dining_Area:SetPos( 206, 334 )
		Dining_Area:SetText( "" )
		Dining_Area.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 3 )
			GAMEMODE.Vars.lastcam = 3
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Dining_Area.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==3 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Entrance = vgui.Create( "DButton" )
		Entrance:SetParent(map)
		Entrance:SetSize( 78.5, 48.5 )
		Entrance:SetPos( 312, 387 )
		Entrance:SetText( "" )
		Entrance.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 4 )
			GAMEMODE.Vars.lastcam = 4
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Entrance.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==4 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end

		local North_Hall_B = vgui.Create( "DButton" )
		North_Hall_B:SetParent(map)
		North_Hall_B:SetSize( 78.5, 48.5 )
		North_Hall_B:SetPos( 354, 281.5 )
		North_Hall_B:SetText( "" )
		North_Hall_B.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 5 )
			GAMEMODE.Vars.lastcam = 5
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		North_Hall_B.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==5 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Bathroom = vgui.Create( "DButton" )
		Bathroom:SetParent(map)
		Bathroom:SetSize( 78.5, 48.5 )
		Bathroom:SetPos( 354, 151 )
		Bathroom:SetText( "" )
		Bathroom.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 6 )
			GAMEMODE.Vars.lastcam = 6
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Bathroom.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==6 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local North_Hall_A = vgui.Create( "DButton" )
		North_Hall_A:SetParent(map)
		North_Hall_A:SetSize( 78.5, 48.5 )
		North_Hall_A:SetPos( 20.5, 162.5 )
		North_Hall_A:SetText( "" )
		North_Hall_A.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 7 )
			GAMEMODE.Vars.lastcam = 7
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		North_Hall_A.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==7 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Pinkie_Bedroom = vgui.Create( "DButton" )
		Pinkie_Bedroom:SetParent(map)
		Pinkie_Bedroom:SetSize( 78.5, 48.5 )
		Pinkie_Bedroom:SetPos( 91, 92.5 )
		Pinkie_Bedroom:SetText( "" )
		Pinkie_Bedroom.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 8 )
			GAMEMODE.Vars.lastcam = 8
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Pinkie_Bedroom.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==8 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Storage = vgui.Create( "DButton" )
		Storage:SetParent(map)
		Storage:SetSize( 78.5, 48.5 )
		Storage:SetPos( 192.5, 92.5 )
		Storage:SetText( "" )
		Storage.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 9 )
			GAMEMODE.Vars.lastcam = 9
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Storage.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==9 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Supply_Room = vgui.Create( "DButton" )
		Supply_Room:SetParent(map)
		Supply_Room:SetSize( 78.5, 48.5 )
		Supply_Room:SetPos( 293, 92 )
		Supply_Room:SetText( "" )
		Supply_Room.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 10 )
			GAMEMODE.Vars.lastcam = 10
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Supply_Room.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==10 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Trash = vgui.Create( "DButton" )
		Trash:SetParent(map2)
		Trash:SetSize( 78.5, 48.5 )
		Trash:SetPos( 380, 325.5 )
		Trash:SetText( "" )
		Trash.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 11 )
			GAMEMODE.Vars.lastcam = 11
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Trash.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==11 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Cave = vgui.Create( "DButton" )
		Cave:SetParent(map2)
		Cave:SetSize( 78.5, 48.5 )
		Cave:SetPos( 315.5, 268.5 )
		Cave:SetText( "" )
		Cave.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 12 )
			GAMEMODE.Vars.lastcam = 12
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Cave.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==12 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Storage = vgui.Create( "DButton" )
		Storage:SetParent(map2)
		Storage:SetSize( 78.5, 48.5 )
		Storage:SetPos( 222, 140 )
		Storage:SetText( "" )
		Storage.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 13 )
			GAMEMODE.Vars.lastcam = 13
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Storage.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==13 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Generator = vgui.Create( "DButton" )
		Generator:SetParent(map2)
		Generator:SetSize( 78.5, 48.5 )
		Generator:SetPos( 57, 225.5 )
		Generator:SetText( "" )
		Generator.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 14 )
			GAMEMODE.Vars.lastcam = 14
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Generator.Paint = function( self, w, h )
			if GAMEMODE.Vars.lastcam==14 then
				draw.RoundedBox( 0, 2.5, 2.5, w-5, h-5, Color( 136, 168, 0, 128 ) )
			end
		end
		
		local Unknown = vgui.Create( "DButton" )
		Unknown:SetParent(map2)
		Unknown:SetSize( 4, 4 )
		Unknown:SetPos( 237, 298 )
		Unknown:SetText( "" )
		Unknown.DoClick = function( button )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( 15 )
			GAMEMODE.Vars.lastcam = 15
			CamsNames:SetText( GAMEMODE.CamsNames["fnap_scc_"..GAMEMODE.Vars.lastcam] or "" )
		end
		Unknown.Paint = function( self, w, h )
			
		end
		
		
		CloseT = vgui.Create( "DButton" )
		CloseT:SetParent(Monitor)
		CloseT:SetSize( 512, 80 )
		CloseT:SetPos( ScrW()/2-256, ScrH()-80-50 )
		CloseT:SetText( "" )
		CloseT.DoClick = function( button )
			if IsValid(FNaFView) then waitt = CurTime()+1 end
			Monitor:Close()
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
			if IsValid(OpenT) then OpenT:Show() end
			if IsValid(lightroom) then lightroom:Show() end
		end
		CloseT.OnCursorEntered = function()
			if IsValid(FNaFView) then
				if !waitt then waitt=0 end
				if waitt<CurTime() then
					waitt = CurTime()+0.5
					Monitor:Close()
					LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
					if IsValid(OpenT) then OpenT:Show() end
					if IsValid(lightroom) then lightroom:Show() end
				end
			end
		end
		CloseT.Paint = function( self, w, h )
			
			draw.RoundedBox( 0, 1, 1, w-2, h-2, Color( 255, 255, 255, 32 ) )
			
			surface.SetDrawColor( 255, 255, 255, 128 )
			
			draw.NoTexture()
			
			surface.DrawLine( w/2-64, h/2-16, w/2, h/2 )
			surface.DrawLine( w/2, h/2, w/2+64, h/2-16 )
			
			surface.DrawLine( w/2-64, h/2-16+16, w/2, h/2+16 )
			surface.DrawLine( w/2, h/2+16, w/2+64, h/2-16+16 )
			
			surface.DrawOutlinedRect( 0, 0, w, h )
			
		end
		
	else
		
		local CamsNames = vgui.Create( "DLabel" )
		CamsNames:SetParent(Monitor)
		CamsNames:SetText( "CAM"..GAMEMODE.Vars.lastcam )
		CamsNames:SetTextColor( Color( 255, 255, 255, 255 ) )
		CamsNames:SetFont("FNAFGMTIME")
		CamsNames:SetPos( 70, 60 )
		CamsNames:SetSize( 200, 64 )
		
		local CAM = vgui.Create( "DNumberWang" )
		CAM:SetParent(Monitor)
		CAM:SetPos( ScrW()/2-16, ScrH()-80-50-80 )
		CAM:SetMinMax(1,table.Count(ents.FindByClass( "fnafgm_camera" )))
		CAM:SetSize( 34, 28 )
		CAM:SetValue(GAMEMODE.Vars.lastcam)
		CAM.OnValueChanged = function( val )
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_camselect)
			fnafgmSetView( math.Round( val:GetValue() ) )
			GAMEMODE.Vars.lastcam = val:GetValue()
			CamsNames:SetText( "CAM"..val:GetValue() )
		end
		
		CloseT = vgui.Create( "DButton" )
		CloseT:SetParent(Monitor)
		CloseT:SetSize( 512, 80 )
		CloseT:SetPos( ScrW()/2-256, ScrH()-80-50 )
		CloseT:SetText( "" )
		CloseT:SetTextColor( Color( 255, 255, 255, 255 ) )
		CloseT:SetFont("FNAFGMID")
		CloseT.DoClick = function( button )
			if IsValid(FNaFView) then waitt = CurTime()+1 end
			Monitor:Close()
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
			if IsValid(OpenT) then OpenT:Show() end
		end
		CloseT.OnCursorEntered = function()
			if IsValid(FNaFView) then
				if !waitt then waitt=0 end
				if waitt<CurTime() then
					waitt = CurTime()+0.5
					Monitor:Close()
					LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
					if IsValid(OpenT) then OpenT:Show() end
				end
			end
		end
		CloseT.Paint = function( self, w, h )
			
			draw.RoundedBox( 0, 1, 1, w-2, h-2, Color( 255, 255, 255, 32 ) )
			
			surface.SetDrawColor( 255, 255, 255, 128 )
			
			draw.NoTexture()
			
			surface.DrawLine( w/2-64, h/2-16, w/2, h/2 )
			surface.DrawLine( w/2, h/2, w/2+64, h/2-16 )
			
			surface.DrawLine( w/2-64, h/2-16+16, w/2, h/2+16 )
			surface.DrawLine( w/2, h/2+16, w/2+64, h/2-16+16 )
			
			surface.DrawOutlinedRect( 0, 0, w, h )
			
		end
		
	end
	
	return true
	
end
hook.Add( "fnafgmSecurityTabletCustom", "fnapgmSecurityTablet", fnapgmSecurityTablet)

function fnapgmFNaFViewHUD()
	
	if game.GetMap()=="fnap_scc" then
		
		lightroom = vgui.Create( "DButton" )
		lightroom:SetParent(FNaFView)
		lightroom:SetSize( 256, 80 )
		lightroom:SetPos( ScrW()/2-128, 50 )
		lightroom:SetText( "LIGHT" )
		lightroom:SetTextColor( Color( 255, 255, 255, 255 ) )
		lightroom:SetFont("FNAFGMNIGHT")
		lightroom.DoClick = function( button )
			fnafgmUseLight(3)
		end
		lightroom.Paint = function( self, w, h )
			
			draw.RoundedBox( 0, 1, 1, w-2, h-2, Color( 255, 255, 255, 5 ) )
			
			surface.SetDrawColor( 255, 255, 255, 128 )
			
			draw.NoTexture()
			
			surface.DrawOutlinedRect( 0, 0, w, h )
			
		end
		
		OpenT = vgui.Create( "DButton" )
		OpenT:SetParent(FNaFView)
		OpenT:SetSize( 512, 80 )
		OpenT:SetPos( ScrW()/2-256, ScrH()-80-50 )
		OpenT:SetText( "" )
		OpenT.DoClick = function( button )
			waitt = CurTime()+1
			fnafgmSecurityTablet() 
			LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
			OpenT:Hide()
			lightroom:Hide()
		end
		OpenT.OnCursorEntered = function()
			if !waitt then waitt=0 end
			if waitt<CurTime() then
				waitt = CurTime()+0.5
				fnafgmSecurityTablet() 
				LocalPlayer():ConCommand("play "..GAMEMODE.Sound_securitycampop)
				OpenT:Hide()
				lightroom:Hide()
			end
		end
		OpenT.Paint = function( self, w, h )
			
			draw.RoundedBox( 0, 1, 1, w-2, h-2, Color( 255, 255, 255, 32 ) )
			
			surface.SetDrawColor( 255, 255, 255, 128 )
			
			draw.NoTexture()
			
			surface.DrawLine( w/2-64, h/2-16, w/2, h/2 )
			surface.DrawLine( w/2, h/2, w/2+64, h/2-16 )
			
			surface.DrawLine( w/2-64, h/2-16+16, w/2, h/2+16 )
			surface.DrawLine( w/2, h/2+16, w/2+64, h/2-16+16 )
			
			surface.DrawOutlinedRect( 0, 0, w, h )
			
		end
		
	end
	
	return true
	
end
hook.Add( "fnafgmFNaFViewCustom", "fnapgmFNaFViewHUD", fnapgmFNaFViewHUD)

function fnapgmMenu()
	
	questionbtn = vgui.Create( "DButton" )
	questionbtn:SetParent(fnafgmMenuF.links)
	questionbtn:SetText( tostring(GAMEMODE.TranslatedStrings.faqbtn or GAMEMODE.Strings.en.faqbtn) )
	questionbtn:SetPos( 10, 185 )
	questionbtn:SetSize( 140, 20 )
	questionbtn.DoClick = function()
		gui.OpenURL( "http://steamcommunity.com/workshop/filedetails/discussion/542710334/490123938445012064/" )
		fnafgmMenuF:Close()
	end
	
	bugreportbtn = vgui.Create( "DButton" )
	bugreportbtn:SetParent(fnafgmMenuF.links)
	bugreportbtn:SetText( "Bug report" )
	bugreportbtn:SetPos( 155, 185 )
	bugreportbtn:SetSize( 140, 20 )
	bugreportbtn.DoClick = function()
		gui.OpenURL( "http://steamcommunity.com/workshop/filedetails/discussion/542710334/496880203071666595/" )
		fnafgmMenuF:Close()
	end
	
end
hook.Add( "fnafgmMenuCustom", "fnapgmMenu", fnapgmMenu)
