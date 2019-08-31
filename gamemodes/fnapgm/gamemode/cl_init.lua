--[[---------------------------------------------------------

	Five Nights at Pinkie's Gamemode for Garry's Mod
			by VictorienXP@Xperidia (2015)

-----------------------------------------------------------]]

include('shared.lua')
DeriveGamemode("fnafgm")

function fnapgmSecurityTabletInit(control)

	if game.GetMap() == "fnap_scc" then
		if !GAMEMODE.Vars.lastcam then
			GAMEMODE.Vars.lastcam = 2
		end
		if !control then LocalPlayer():EmitSound("fnafgm_campop") end
	elseif game.GetMap() == "fnap_cb" then
		if !GAMEMODE.Vars.lastcam then
			GAMEMODE.Vars.lastcam = 1
		end
		if !control then LocalPlayer():EmitSound("fnafgm_campop2") end
	else
		if !GAMEMODE.Vars.lastcam then
			GAMEMODE.Vars.lastcam = 1
		end
		if !control then LocalPlayer():EmitSound("fnafgm_campop") end
	end

	return true

end
hook.Add("fnafgmSecurityTabletCustomInit", "fnapgmSecurityTabletInit", fnapgmSecurityTabletInit)

function fnapgmSecurityTablet(control)

	if game.GetMap() == "fnap_scc" then

		if !control then

			local closebtnsizew = (512 * (ScrH() / 480)) / 2
			local closebtnsizeh = (60 * (ScrH() / 480)) / 2

			CloseT = vgui.Create("DButton")
			CloseT:SetParent(GAMEMODE.Vars.Monitor)
			CloseT:SetSize(closebtnsizew, closebtnsizeh)
			CloseT:SetPos(ScrW() / 2 - closebtnsizew / 2, ScrH() - closebtnsizeh - 50)
			CloseT:SetText("")
			CloseT.DoClick = function(button)
				if IsValid(FNaFView) then waitt = CurTime() + 1 end
				GAMEMODE.Vars.Monitor:Close()
				LocalPlayer():EmitSound("fnafgm_camdown")
				if IsValid(OpenT) then OpenT:Show() end
				if IsValid(lightroom) then lightroom:Show() end
			end
			CloseT.OnCursorEntered = function()
				if IsValid(FNaFView) then
					if !waitt then waitt = 0 end
					if waitt < CurTime() then
						waitt = CurTime() + 0.5
						GAMEMODE.Vars.Monitor:Close()
						LocalPlayer():EmitSound("fnafgm_camdown")
						if IsValid(OpenT) then OpenT:Show() end
						if IsValid(lightroom) then lightroom:Show() end
					end
				end
			end
			CloseT.Paint = function(self, w, h)

				draw.RoundedBox(0, 1, 1, w-2, h-2, Color(255, 255, 255, 32))

				surface.SetDrawColor(255, 255, 255, 128)

				draw.NoTexture()

				surface.DrawLine(w / 2 - 64, h / 2 - 16, w / 2, h / 2)
				surface.DrawLine(w / 2, h / 2, w / 2 + 64, h / 2 - 16)

				surface.DrawLine(w / 2 - 64, h / 2- 16 + 16, w / 2, h / 2 + 16)
				surface.DrawLine(w / 2, h / 2 + 16, w / 2 + 64, h / 2- 16 + 16)

				surface.DrawOutlinedRect(0, 0, w, h)

			end

			if !GAMEMODE.Vars.mute then
				local MUTET = vgui.Create("DImage")
				MUTET:SetParent(GAMEMODE.Vars.Monitor)
				MUTET:SetImage("fnafgm/mute")
				MUTET:SetSize(128, 32)
				MUTET:SetPos(64, 64)

				local MUTEbT = vgui.Create("DButton")
				MUTEbT:SetParent(MUTET)
				MUTEbT:SetSize(121, 31)
				MUTEbT:SetPos(0, 0)
				MUTEbT:SetText("")
				MUTEbT.DoClick = function(button)
					fnafgmMuteCall()
					MUTET:Remove()
					MUTEbT:Remove()
				end
				MUTEbT.Paint = function(self, w, h)

				end
			end

			GAMEMODE.Vars.Monitor.Map:SetImage("fnapgm/maps/fnap_scc_1")

		else
			GAMEMODE.Vars.Monitor.Map:SetImage("fnapgm/maps/fnap_scc_1_sgvsa")
		end

		GAMEMODE.Vars.Monitor.Map2:SetImage("fnapgm/maps/fnap_scc_2")

		if !control then
			GAMEMODE.Vars.Monitor:CreateButton(1,GAMEMODE.Vars.Monitor.Map,91,224,78.5,48.5,2.5)
		else
			GAMEMODE.Vars.Monitor:CreateButton(1,GAMEMODE.Vars.Monitor.Map,116.5, 224,78.5,48.5,2.5)
		end
		GAMEMODE.Vars.Monitor:CreateButton(2,GAMEMODE.Vars.Monitor.Map,206,229.5,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(3,GAMEMODE.Vars.Monitor.Map,206,334,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(4,GAMEMODE.Vars.Monitor.Map,312,387,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(5,GAMEMODE.Vars.Monitor.Map,354,281.5,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(6,GAMEMODE.Vars.Monitor.Map,354,151,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(7,GAMEMODE.Vars.Monitor.Map,20.5,162.5,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(8,GAMEMODE.Vars.Monitor.Map,91,92.5,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(9,GAMEMODE.Vars.Monitor.Map,192.5,92.5,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(10,GAMEMODE.Vars.Monitor.Map,293,92,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(11,GAMEMODE.Vars.Monitor.Map2,380,325.5,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(12,GAMEMODE.Vars.Monitor.Map2,315.5,268.5,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(13,GAMEMODE.Vars.Monitor.Map2,222,140,78.5,48.5,2.5)
		GAMEMODE.Vars.Monitor:CreateButton(14,GAMEMODE.Vars.Monitor.Map2,57,225.5,78.5,48.5,2.5)
		if control then
			GAMEMODE.Vars.Monitor:CreateButton(16,GAMEMODE.Vars.Monitor.Map,22,315,78.5,48.5,2.5)
			GAMEMODE.Vars.Monitor:CreateButton(17,GAMEMODE.Vars.Monitor.Map,138,429,78.5,48.5,2.5)
			GAMEMODE.Vars.Monitor:CreateButton(18,GAMEMODE.Vars.Monitor.Map,53,429,78.5,48.5,2.5)
			GAMEMODE.Vars.Monitor:CreateButton(19,GAMEMODE.Vars.Monitor.Map,22,224,78.5,48.5,2.5)
			GAMEMODE.Vars.Monitor:CreateButton(20,GAMEMODE.Vars.Monitor.Map,223,429,78.5,48.5,2.5)
		end

		local Unknown = vgui.Create("DButton")
		Unknown:SetParent(GAMEMODE.Vars.Monitor.Map2)
		Unknown:SetSize(4, 4)
		Unknown:SetPos(237, 298)
		Unknown:SetText("")
		Unknown.DoClick = function(button)
			LocalPlayer():EmitSound("fnafgm_camselect")
			GAMEMODE.Vars.lastcam = 15
			fnafgmSetView(GAMEMODE.Vars.lastcam)
			GAMEMODE.Vars.Monitor.CamsNames:SetText(GAMEMODE.CamsNames["fnap_scc_" .. GAMEMODE.Vars.lastcam] or "")
		end
		Unknown.Paint = function(self, w, h)

		end

	else

		local CAM = vgui.Create( "DNumberWang" )
		CAM:SetParent(GAMEMODE.Vars.Monitor)
		CAM:SetPos(ScrW() / 2 - 16, ScrH() - 80 - 50 - 80)
		CAM:SetMinMax(1,table.Count(ents.FindByClass("fnafgm_camera")))
		CAM:SetSize(34, 28)
		CAM:SetValue(GAMEMODE.Vars.lastcam)
		CAM.OnValueChanged = function(val)
			LocalPlayer():EmitSound("fnafgm_camselect")
			fnafgmSetView(math.Round(val:GetValue()))
			GAMEMODE.Vars.lastcam = val:GetValue()
			GAMEMODE.Vars.Monitor.CamsNames:SetText("CAM" .. val:GetValue())
		end

		local closebtnsizew = (512 * (ScrH() / 480)) / 2
		local closebtnsizeh = (60 * (ScrH() / 480)) / 2

		CloseT = vgui.Create("DButton")
		CloseT:SetParent(GAMEMODE.Vars.Monitor)
		CloseT:SetSize(closebtnsizew, closebtnsizeh)
		CloseT:SetPos(ScrW() / 2 - closebtnsizew / 2, ScrH() - closebtnsizeh - 50)
		CloseT:SetText("")
		CloseT:SetTextColor(Color(255, 255, 255, 255))
		CloseT:SetFont("FNAFGMID")
		CloseT.DoClick = function(button)
			if IsValid(FNaFView) then waitt = CurTime() + 1 end
			GAMEMODE.Vars.Monitor:Close()
			LocalPlayer():EmitSound("fnafgm_camdown")
			if IsValid(OpenT) then OpenT:Show() end
		end
		CloseT.OnCursorEntered = function()
			if IsValid(FNaFView) then
				if !waitt then waitt = 0 end
				if waitt < CurTime() then
					waitt = CurTime() + 0.5
					GAMEMODE.Vars.Monitor:Close()
					LocalPlayer():EmitSound("fnafgm_camdown")
					if IsValid(OpenT) then OpenT:Show() end
				end
			end
		end
		CloseT.Paint = function(self, w, h)

			draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 32))

			surface.SetDrawColor(255, 255, 255, 128)

			draw.NoTexture()

			surface.DrawLine(w / 2 - 64, h / 2 - 16, w / 2, h / 2)
			surface.DrawLine(w / 2, h / 2, w / 2 + 64, h / 2 - 16)

			surface.DrawLine(w / 2 - 64, h / 2 - 16 + 16, w / 2, h / 2 + 16)
			surface.DrawLine(w / 2, h / 2 + 16, w / 2 + 64, h / 2 - 16 + 16)

			surface.DrawOutlinedRect(0, 0, w, h)

		end

	end

	return true

end
hook.Add("fnafgmSecurityTabletCustom", "fnapgmSecurityTablet", fnapgmSecurityTablet)

function fnapgmFNaFViewHUD()

	if game.GetMap() == "fnap_scc" then

		lightroom = vgui.Create("DButton")
		lightroom:SetParent(FNaFView)
		lightroom:SetSize(256, 80)
		lightroom:SetPos(ScrW() / 2 - 128, 50)
		lightroom:SetText("LIGHT")
		lightroom:SetTextColor(Color(255, 255, 255, 255))
		lightroom:SetFont("FNAFGMNIGHT")
		lightroom.DoClick = function(button)
			fnafgmUseLight(3)
		end
		lightroom.Paint = function(self, w, h)

			draw.RoundedBox(0, 1, 1, w-2, h-2, Color(255, 255, 255, 5))

			surface.SetDrawColor(255, 255, 255, 128)

			draw.NoTexture()

			surface.DrawOutlinedRect(0, 0, w, h)

		end

		local closebtnsizew = (512 * (ScrH() / 480)) / 2
		local closebtnsizeh = (60 * (ScrH() / 480)) / 2

		OpenT = vgui.Create("DButton")
		OpenT:SetParent(FNaFView)
		OpenT:SetSize(closebtnsizew, closebtnsizeh)
		OpenT:SetPos(ScrW() / 2 - closebtnsizew / 2 , ScrH() - closebtnsizeh - 50)
		OpenT:SetText("")
		OpenT.DoClick = function(button)
			waitt = CurTime() + 1
			GAMEMODE:Monitor()
			OpenT:Hide()
			lightroom:Hide()
		end
		OpenT.OnCursorEntered = function()
			if !waitt then waitt = 0 end
			if waitt < CurTime() then
				waitt = CurTime() + 0.5
				GAMEMODE:Monitor()
				OpenT:Hide()
				lightroom:Hide()
			end
		end
		OpenT.Paint = function(self, w, h)

			draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 32))

			surface.SetDrawColor(255, 255, 255, 128)

			draw.NoTexture()

			surface.DrawLine(w / 2 - 64, h / 2 - 16, w / 2, h / 2)
			surface.DrawLine(w / 2, h / 2, w / 2 + 64, h / 2 - 16)

			surface.DrawLine(w / 2 - 64, h / 2 - 16 + 16, w / 2, h / 2 + 16)
			surface.DrawLine(w / 2, h / 2 + 16, w / 2 + 64, h / 2 - 16 + 16)

			surface.DrawOutlinedRect(0, 0, w, h)

		end

	elseif game.GetMap() == "fnap_cb" then

		OpenT = vgui.Create("DButton")
		OpenT:SetParent(FNaFView)
		OpenT:SetSize(512, 80)
		OpenT:SetPos(ScrW() / 2 - 256, ScrH() - 80 - 50)
		OpenT:SetText("")
		OpenT.DoClick = function(button)
			waitt = CurTime() + 1
			GAMEMODE:Monitor()
			LocalPlayer():EmitSound("fnafgm_campop")
			OpenT:Hide()
			--SafeE:Hide()
		end
		OpenT.OnCursorEntered = function()
			if !waitt then waitt = 0 end
			if waitt < CurTime() then
				waitt = CurTime() + 0.5
				GAMEMODE:Monitor()
				LocalPlayer():EmitSound("fnafgm_campop")
				OpenT:Hide()
				--SafeE:Hide()
			end
		end
		OpenT.Paint = function(self, w, h)

			draw.RoundedBox(0, 1, 1, w-2, h-2, Color(255, 255, 255, 32))

			surface.SetDrawColor(255, 255, 255, 128)

			draw.NoTexture()

			surface.DrawLine(w / 2 - 64, h / 2 - 16, w / 2, h / 2)
			surface.DrawLine(w / 2, h / 2, w / 2 + 64, h / 2 - 16)

			surface.DrawLine(w / 2 - 64, h / 2 - 16 + 16, w / 2, h / 2 + 16)
			surface.DrawLine(w / 2, h / 2 + 16, w / 2 + 64, h / 2 - 16 + 16)

			surface.DrawOutlinedRect(0, 0, w, h)

		end

	end

	return true

end
hook.Add("fnafgmFNaFViewCustom", "fnapgmFNaFViewHUD", fnapgmFNaFViewHUD)

function fnapgmMenu()

	questionbtn = vgui.Create("DButton")
	questionbtn:SetParent(fnafgmMenuF.links)
	questionbtn:SetText(GAMEMODE.TranslatedStrings.faqbtn or GAMEMODE.Strings.en.faqbtn)
	questionbtn:SetPos(10, 185)
	questionbtn:SetSize(140, 20)
	questionbtn.DoClick = function()
		gui.OpenURL("https://steamcommunity.com/workshop/filedetails/discussion/542710334/490123938445012064/")
		fnafgmMenuF:Close()
	end

	bugreportbtn = vgui.Create("DButton")
	bugreportbtn:SetParent(fnafgmMenuF.links)
	bugreportbtn:SetText("GitHub")
	bugreportbtn:SetPos(155, 185)
	bugreportbtn:SetSize(140, 20)
	bugreportbtn.DoClick = function()
		gui.OpenURL("https://github.com/Xperidia/FNAPGM")
		fnafgmMenuF:Close()
	end

end
hook.Add("fnafgmMenuCustom", "fnapgmMenu", fnapgmMenu)

function fnapgmPreventAnimatronicMove(a, apos)

	if game.GetMap() == "fnap_scc" and a == GAMEMODE.Animatronic.Rarity then

		if GAMEMODE.Vars.Animatronics[a][2] == GAMEMODE.APos.fnap_scc.SS and apos == GAMEMODE.APos.fnap_scc.Entrance then
			return false
		elseif GAMEMODE.Vars.Animatronics[a][2] == GAMEMODE.APos.fnap_scc.Entrance and apos == GAMEMODE.APos.fnap_scc.EntranceD then
			return false
		elseif GAMEMODE.Vars.Animatronics[a][2] == GAMEMODE.APos.fnap_scc.EntranceD and apos == GAMEMODE.APos.fnap_scc.DA then
			return false
		elseif GAMEMODE.Vars.Animatronics[a][2] == GAMEMODE.APos.fnap_scc.DA and apos == GAMEMODE.APos.fnap_scc.StaffD then
			return false
		elseif GAMEMODE.Vars.Animatronics[a][2] == GAMEMODE.APos.fnap_scc.StaffD and apos == GAMEMODE.APos.fnap_scc.Staff then
			return false
		elseif GAMEMODE.Vars.Animatronics[a][2] == GAMEMODE.APos.fnap_scc.Staff and apos == GAMEMODE.APos.fnap_scc.Office then
			return false
		end

		return true

	end

end
hook.Add("fnafgmPreventAnimatronicMove", "fnapgmPreventAnimatronicMove", fnapgmPreventAnimatronicMove)
