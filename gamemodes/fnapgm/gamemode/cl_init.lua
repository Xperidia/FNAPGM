--[[---------------------------------------------------------

	Five Nights at Pinkie's Gamemode for Garry's Mod
			by VictorienXP@Xperidia (2015)

-----------------------------------------------------------]]

include("shared.lua")
DeriveGamemode("fnafgm")

function fnapgmSecurityTabletInit(control)

	local gvars = GAMEMODE.Vars
	local map = game.GetMap()
	local ply = LocalPlayer()

	if map == "fnap_scc" then
		if not gvars.lastcam then
			gvars.lastcam = 2
		end
		if not control then ply:EmitSound("fnafgm_campop") end
	elseif map == "fnap_cb" then
		if not gvars.lastcam then
			gvars.lastcam = 1
		end
		if not control then ply:EmitSound("fnafgm_campop2") end
	else
		if not gvars.lastcam then
			gvars.lastcam = 1
		end
		if not control then ply:EmitSound("fnafgm_campop") end
	end

	return true

end
hook.Add("fnafgmSecurityTabletCustomInit", "fnapgmSecurityTabletInit", fnapgmSecurityTabletInit)

function fnapgmSecurityTablet(control)

	local gvars = GAMEMODE.Vars
	local ply = LocalPlayer()
	local map = game.GetMap()

	if map == "fnap_scc" then

		if not control then

			local closebtnsizew = (512 * (ScrH() / 480)) / 2
			local closebtnsizeh = (60 * (ScrH() / 480)) / 2

			CloseT = vgui.Create("DButton")
			CloseT:SetParent(gvars.Monitor)
			CloseT:SetSize(closebtnsizew, closebtnsizeh)
			CloseT:SetPos(ScrW() / 2 - closebtnsizew / 2, ScrH() - closebtnsizeh - 50)
			CloseT:SetText("")
			CloseT.DoClick = function(button)
				if IsValid(FNaFView) then waitt = CurTime() + 1 end
				gvars.Monitor:Close()
				ply:EmitSound("fnafgm_camdown")
				if IsValid(OpenT) then OpenT:Show() end
				if IsValid(lightroom) then lightroom:Show() end
			end
			CloseT.OnCursorEntered = function()
				if IsValid(FNaFView) then
					if not waitt then waitt = 0 end
					if waitt < CurTime() then
						waitt = CurTime() + 0.5
						gvars.Monitor:Close()
						ply:EmitSound("fnafgm_camdown")
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

			if not gvars.mute then
				local MUTET = vgui.Create("DImage")
				MUTET:SetParent(gvars.Monitor)
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

			gvars.Monitor.Map:SetImage("fnapgm/maps/fnap_scc_1")

		else
			gvars.Monitor.Map:SetImage("fnapgm/maps/fnap_scc_1_sgvsa")
		end

		gvars.Monitor.Map2:SetImage("fnapgm/maps/fnap_scc_2")

		if not control then
			gvars.Monitor:CreateButton(1,gvars.Monitor.Map,91,224,78.5,48.5,2.5)
		else
			gvars.Monitor:CreateButton(1,gvars.Monitor.Map,116.5, 224,78.5,48.5,2.5)
		end
		gvars.Monitor:CreateButton(2,gvars.Monitor.Map,206,229.5,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(3,gvars.Monitor.Map,206,334,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(4,gvars.Monitor.Map,312,387,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(5,gvars.Monitor.Map,354,281.5,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(6,gvars.Monitor.Map,354,151,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(7,gvars.Monitor.Map,20.5,162.5,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(8,gvars.Monitor.Map,91,92.5,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(9,gvars.Monitor.Map,192.5,92.5,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(10,gvars.Monitor.Map,293,92,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(11,gvars.Monitor.Map2,380,325.5,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(12,gvars.Monitor.Map2,315.5,268.5,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(13,gvars.Monitor.Map2,222,140,78.5,48.5,2.5)
		gvars.Monitor:CreateButton(14,gvars.Monitor.Map2,57,225.5,78.5,48.5,2.5)
		if control then
			gvars.Monitor:CreateButton(16,gvars.Monitor.Map,22,315,78.5,48.5,2.5)
			gvars.Monitor:CreateButton(17,gvars.Monitor.Map,138,429,78.5,48.5,2.5)
			gvars.Monitor:CreateButton(18,gvars.Monitor.Map,53,429,78.5,48.5,2.5)
			gvars.Monitor:CreateButton(19,gvars.Monitor.Map,22,224,78.5,48.5,2.5)
			gvars.Monitor:CreateButton(20,gvars.Monitor.Map,223,429,78.5,48.5,2.5)
		end

		local Unknown = vgui.Create("DButton")
		Unknown:SetParent(gvars.Monitor.Map2)
		Unknown:SetSize(4, 4)
		Unknown:SetPos(237, 298)
		Unknown:SetText("")
		Unknown.DoClick = function(button)
			ply:EmitSound("fnafgm_camselect")
			gvars.lastcam = 15
			fnafgmSetView(gvars.lastcam)
			gvars.Monitor.CamsNames:SetText(GAMEMODE.CamsNames["fnap_scc_" .. gvars.lastcam] or "")
		end
		Unknown.Paint = function(self, w, h)

		end

	else

		local CAM = vgui.Create( "DNumberWang" )
		CAM:SetParent(gvars.Monitor)
		CAM:SetPos(ScrW() / 2 - 16, ScrH() - 80 - 50 - 80)
		CAM:SetMinMax(1,table.Count(ents.FindByClass("fnafgm_camera")))
		CAM:SetSize(34, 28)
		CAM:SetValue(gvars.lastcam)
		CAM.OnValueChanged = function(val)
			ply:EmitSound("fnafgm_camselect")
			fnafgmSetView(math.Round(val:GetValue()))
			gvars.lastcam = val:GetValue()
			gvars.Monitor.CamsNames:SetText("CAM" .. val:GetValue())
		end

		local closebtnsizew = (512 * (ScrH() / 480)) / 2
		local closebtnsizeh = (60 * (ScrH() / 480)) / 2

		CloseT = vgui.Create("DButton")
		CloseT:SetParent(gvars.Monitor)
		CloseT:SetSize(closebtnsizew, closebtnsizeh)
		CloseT:SetPos(ScrW() / 2 - closebtnsizew / 2, ScrH() - closebtnsizeh - 50)
		CloseT:SetText("")
		CloseT:SetTextColor(Color(255, 255, 255, 255))
		CloseT:SetFont("FNAFGMID")
		CloseT.DoClick = function(button)
			if IsValid(FNaFView) then waitt = CurTime() + 1 end
			gvars.Monitor:Close()
			ply:EmitSound("fnafgm_camdown")
			if IsValid(OpenT) then OpenT:Show() end
		end
		CloseT.OnCursorEntered = function()
			if IsValid(FNaFView) then
				if not waitt then waitt = 0 end
				if waitt < CurTime() then
					waitt = CurTime() + 0.5
					gvars.Monitor:Close()
					ply:EmitSound("fnafgm_camdown")
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

	local ply = LocalPlayer()
	local map = game.GetMap()

	if map == "fnap_scc" then

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
			if not waitt then waitt = 0 end
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

	elseif map == "fnap_cb" then

		OpenT = vgui.Create("DButton")
		OpenT:SetParent(FNaFView)
		OpenT:SetSize(512, 80)
		OpenT:SetPos(ScrW() / 2 - 256, ScrH() - 80 - 50)
		OpenT:SetText("")
		OpenT.DoClick = function(button)
			waitt = CurTime() + 1
			GAMEMODE:Monitor()
			ply:EmitSound("fnafgm_campop")
			OpenT:Hide()
			--SafeE:Hide()
		end
		OpenT.OnCursorEntered = function()
			if not waitt then waitt = 0 end
			if waitt < CurTime() then
				waitt = CurTime() + 0.5
				GAMEMODE:Monitor()
				ply:EmitSound("fnafgm_campop")
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

	local gvars = GAMEMODE.Vars
	local gapos = GAMEMODE.APos
	local map = game.GetMap()

	if map == "fnap_scc" and a == GAMEMODE.Animatronic.Rarity then

		if gvars.Animatronics[a][2] == gapos.fnap_scc.SS and apos == gapos.fnap_scc.Entrance then
			return false
		elseif gvars.Animatronics[a][2] == gapos.fnap_scc.Entrance and apos == gapos.fnap_scc.EntranceD then
			return false
		elseif gvars.Animatronics[a][2] == gapos.fnap_scc.EntranceD and apos == gapos.fnap_scc.DA then
			return false
		elseif gvars.Animatronics[a][2] == gapos.fnap_scc.DA and apos == gapos.fnap_scc.StaffD then
			return false
		elseif gvars.Animatronics[a][2] == gapos.fnap_scc.StaffD and apos == gapos.fnap_scc.Staff then
			return false
		elseif gvars.Animatronics[a][2] == gapos.fnap_scc.Staff and apos == gapos.fnap_scc.Office then
			return false
		end

		return true

	end

end
hook.Add("fnafgmPreventAnimatronicMove", "fnapgmPreventAnimatronicMove", fnapgmPreventAnimatronicMove)
