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

	if GAMEMODE.IsFNAFGMDerived and GAMEMODE.ASSEye[game.GetMap()] then
		self:SetEyeTarget(GAMEMODE.ASSEye[game.GetMap()])
	end

end

function ENT:RunBehaviour()

	self.loco:SetDesiredSpeed(0)

end

function ENT:Think()

	if !SERVER then return end

	if GAMEMODE.IsFNAFGMDerived and GAMEMODE.Vars and GAMEMODE.Vars.startday then

		if !self.WaitTime then self.WaitTime = CurTime() + math.random(120, 340) end

		if self.WaitTime < CurTime() and !self.Done then

			self:SetSequence(self:LookupSequence("falling"))
			self:SetPlaybackRate(1)

			self.Done = true

		end

		if self.WaitTime + 0.5 < CurTime() and !self.Done2 then

			self:EmitSound(fall_sound, 0)

			self.Done2 = true

		end

	end

end

function ENT:OnInjured(info)
	info:SetDamage(0)
end

function ENT:CanTool(ply, trace, mode)

	return !GAMEMODE.IsFNAFGMDerived

end

function ENT:CanProperty(ply, property)

	return !GAMEMODE.IsFNAFGMDerived

end
