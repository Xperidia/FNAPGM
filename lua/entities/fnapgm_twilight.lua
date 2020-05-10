--[[---------------------------------------------------------

	Five Nights at Pinkie's Gamemode for Garry's Mod
			by VictorienXP@Xperidia (2015-2020)

-----------------------------------------------------------]]

AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Prop Twilight"
ENT.Author = "Xperidia"
ENT.DisableDuplicator = true
ENT.DoNotDuplicate = true
ENT.PhysgunDisabled = true

local ent_model = Model("models/wubsy/vn_mecha_freddytwilight.mdl")
local fall_sound = Sound("physics/metal/metal_barrel_impact_hard1.wav")

function ENT:Initialize()

	self:SetModel(ent_model)

	self:SetHealth(2147483647)

	if SERVER then
		self:SetBloodColor(BLOOD_COLOR_MECH)
	end

	if GAMEMODE.IsFNAFGMDerived and GAMEMODE.ASSEye[game.GetMap()] then
		self:SetEyeTarget(GAMEMODE.ASSEye[game.GetMap()])
	end

end

function ENT:RunBehaviour()
	self.loco:SetDesiredSpeed(0)
end

function ENT:Use(activator, caller, useType, value)
	self:Fall()
end

function ENT:AcceptInput(name, activator, caller, data)

	if name == "Fall" then

		self:Fall(activator or caller)

		return true

	end

	return false

end

function ENT:KeyValue(k, v)

	if string.Left(k, 2) == "On" then

		self:StoreOutput(k, v)

	end

end

function ENT:Think()

	if not SERVER then return end

	if GAMEMODE.IsFNAFGMDerived and GAMEMODE.Vars and GAMEMODE.Vars.startday then

		if not self.WaitTime then self.WaitTime = CurTime() + math.random(120, 340) end

		if self.WaitTime < CurTime() and not self.Done then

			self:Fall()

			self.Done = true

		end

	end

end

function ENT:Fall()

	if not self.fallen then

		self:SetSequence(self:LookupSequence("falling"))
		self:SetPlaybackRate(1)
		self:TriggerOutput("OnFall")
		self.fallen = true

		timer.Create("fnapgm_twilight_fall_sound_" .. self:EntIndex(), 0.5, 1,
		function()

			self:EmitSound(fall_sound, 140)

		end)

	end

end

function ENT:OnInjured(info)

	info:SetDamage(0)

	self:Fall()

end

function ENT:CanTool(ply, trace, mode)
	return not GAMEMODE.IsFNAFGMDerived
end

function ENT:CanProperty(ply, property)
	return not GAMEMODE.IsFNAFGMDerived
end
