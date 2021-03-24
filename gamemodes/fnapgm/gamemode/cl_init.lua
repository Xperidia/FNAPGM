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
	local mon = gvars.Monitor

	if map == "fnap_scc" then

		if not control then

			local closebtnsizew = (512 * (ScrH() / 480)) / 2
			local closebtnsizeh = (60 * (ScrH() / 480)) / 2

			CloseT = vgui.Create("DButton")
			CloseT:SetParent(mon)
			CloseT:SetSize(closebtnsizew, closebtnsizeh)
			CloseT:SetPos(ScrW() / 2 - closebtnsizew / 2, ScrH() - closebtnsizeh - 50)
			CloseT:SetText("")
			CloseT.DoClick = function(button)
				if IsValid(FNaFView) then waitt = CurTime() + 1 end
				mon:Close()
				ply:EmitSound("fnafgm_camdown")
				if IsValid(OpenT) then OpenT:Show() end
				if IsValid(lightroom) then lightroom:Show() end
			end
			CloseT.OnCursorEntered = function()
				if IsValid(FNaFView) then
					if not waitt then waitt = 0 end
					if waitt < CurTime() then
						waitt = CurTime() + 0.5
						mon:Close()
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
				MUTET:SetParent(mon)
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

			mon.Map:SetImage("fnapgm/maps/fnap_scc_1")

		else
			mon.Map:SetImage("fnapgm/maps/fnap_scc_1_sgvsa")
		end

		mon.Map2:SetImage("fnapgm/maps/fnap_scc_2")

		if not control then
			mon:CreateButton(1,mon.Map,91,224,78.5,48.5,2.5)
		else
			mon:CreateButton(1,mon.Map,116.5, 224,78.5,48.5,2.5)
		end
		mon:CreateButton(2,mon.Map,206,229.5,78.5,48.5,2.5)
		mon:CreateButton(3,mon.Map,206,334,78.5,48.5,2.5)
		mon:CreateButton(4,mon.Map,312,387,78.5,48.5,2.5)
		mon:CreateButton(5,mon.Map,354,281.5,78.5,48.5,2.5)
		mon:CreateButton(6,mon.Map,354,151,78.5,48.5,2.5)
		mon:CreateButton(7,mon.Map,20.5,162.5,78.5,48.5,2.5)
		mon:CreateButton(8,mon.Map,91,92.5,78.5,48.5,2.5)
		mon:CreateButton(9,mon.Map,192.5,92.5,78.5,48.5,2.5)
		mon:CreateButton(10,mon.Map,293,92,78.5,48.5,2.5)
		mon:CreateButton(11,mon.Map2,380,325.5,78.5,48.5,2.5)
		mon:CreateButton(12,mon.Map2,315.5,268.5,78.5,48.5,2.5)
		mon:CreateButton(13,mon.Map2,222,140,78.5,48.5,2.5)
		mon:CreateButton(14,mon.Map2,57,225.5,78.5,48.5,2.5)
		if control then
			mon:CreateButton(16,mon.Map,22,315,78.5,48.5,2.5)
			mon:CreateButton(17,mon.Map,138,429,78.5,48.5,2.5)
			mon:CreateButton(18,mon.Map,53,429,78.5,48.5,2.5)
			mon:CreateButton(19,mon.Map,22,224,78.5,48.5,2.5)
			mon:CreateButton(20,mon.Map,223,429,78.5,48.5,2.5)
		end

		local Unknown = vgui.Create("DButton")
		Unknown:SetParent(mon.Map2)
		Unknown:SetSize(4, 4)
		Unknown:SetPos(237, 298)
		Unknown:SetText("")
		Unknown.DoClick = function(button)
			ply:EmitSound("fnafgm_camselect")
			gvars.lastcam = 15
			fnafgmSetView(gvars.lastcam)
			mon.CamsNames:SetText(GAMEMODE.CamsNames["fnap_scc_" .. gvars.lastcam] or "")
		end
		Unknown.Paint = function(self, w, h)

		end

	elseif map == "fnap_cb" then

		if not control then

			CloseT = vgui.Create("DButton")
			CloseT:SetParent(mon)
			CloseT:SetSize(512, 80)
			CloseT:SetPos(ScrW() / 2 - 256, ScrH() - 80 - 50)
			CloseT:SetText("")
			CloseT.DoClick = function(button)
				if IsValid(FNaFView) then waitt = CurTime() + 1 end
				mon:Close()
				ply:EmitSound("fnafgm_camdown")
				if IsValid(OpenT) then OpenT:Show() end
				if IsValid(lightroom) then lightroom:Show() end
			end
			CloseT.OnCursorEntered = function()
				if IsValid(FNaFView) then
					if not waitt then waitt = 0 end
					if waitt < CurTime() then
						waitt = CurTime() + 0.5
						mon:Close()
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
				MUTET:SetParent(mon)
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

		end

		mon.Map:SetImage("fnapgm/maps/fnap_cb_1")
		mon.Map2:SetImage("fnapgm/maps/fnap_cb_2")

		mon:CreateButton(1,		mon.Map,	153.5,	350,	79,		49,		2.5)
		mon:CreateButton(2,		mon.Map,	14,		162.5,	79,		49,		2.5)
		mon:CreateButton(3,		mon.Map,	114,	207,	79,		49,		2.5)
		mon:CreateButton(4,		mon.Map,	217,	93.5,	79,		49,		2.5)
		mon:CreateButton(5,		mon.Map,	320,	119.5,	79,		49,		2.5)
		mon:CreateButton(6,		mon.Map,	312,	325.5,	79,		49,		2.5)
		mon:CreateButton(7,		mon.Map2,	43,		154.5,	79,		49,		2.5)
		mon:CreateButton(8,		mon.Map2,	93,		278.5,	79,		49,		2.5)
		mon:CreateButton(9,		mon.Map2,	216,	308.5,	79,		49,		2.5)
		mon:CreateButton(10,	mon.Map2,	409,	308.5,	79,		49,		2.5)
		--[[if control then
			mon:CreateButton(11,	mon.Map2,	0,	0,	79,	49,	2.5)
		end]]

		local Unknown = vgui.Create("DButton")
		Unknown:SetParent(mon.Map2)
		Unknown:SetSize(4, 4)
		Unknown:SetPos(237, 298)
		Unknown:SetText("")
		Unknown.DoClick = function(button)
			ply:EmitSound("fnafgm_camselect")
			gvars.lastcam = 15
			fnafgmSetView(gvars.lastcam)
			mon.CamsNames:SetText(GAMEMODE.CamsNames["fnap_cb_" .. gvars.lastcam] or "")
		end
		Unknown.Paint = function(self, w, h)

		end

	else

		local CAM = vgui.Create( "DNumberWang" )
		CAM:SetParent(mon)
		CAM:SetPos(ScrW() / 2 - 16, ScrH() - 80 - 50 - 80)
		CAM:SetMinMax(1,table.Count(ents.FindByClass("fnafgm_camera")))
		CAM:SetSize(34, 28)
		CAM:SetValue(gvars.lastcam)
		CAM.OnValueChanged = function(val)
			ply:EmitSound("fnafgm_camselect")
			fnafgmSetView(math.Round(val:GetValue()))
			gvars.lastcam = val:GetValue()
			mon.CamsNames:SetText("CAM" .. val:GetValue())
		end

		local closebtnsizew = (512 * (ScrH() / 480)) / 2
		local closebtnsizeh = (60 * (ScrH() / 480)) / 2

		CloseT = vgui.Create("DButton")
		CloseT:SetParent(mon)
		CloseT:SetSize(closebtnsizew, closebtnsizeh)
		CloseT:SetPos(ScrW() / 2 - closebtnsizew / 2, ScrH() - closebtnsizeh - 50)
		CloseT:SetText("")
		CloseT:SetTextColor(Color(255, 255, 255, 255))
		CloseT:SetFont("FNAFGMID")
		CloseT.DoClick = function(button)
			if IsValid(FNaFView) then waitt = CurTime() + 1 end
			mon:Close()
			ply:EmitSound("fnafgm_camdown")
			if IsValid(OpenT) then OpenT:Show() end
		end
		CloseT.OnCursorEntered = function()
			if IsValid(FNaFView) then
				if not waitt then waitt = 0 end
				if waitt < CurTime() then
					waitt = CurTime() + 0.5
					mon:Close()
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
		gui.OpenURL("https://github.com/Xperidia/FNAPGM/wiki/FAQ")
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
