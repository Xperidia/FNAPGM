--[[---------------------------------------------------------

	Five Nights at Pinkie's Gamemode for Garry's Mod
			by VictorienXP@Xperidia (2020)

-----------------------------------------------------------]]

AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Prop Rainbow Dash Head"
ENT.Author = "Xperidia"
ENT.DisableDuplicator = true
ENT.DoNotDuplicate = true
ENT.PhysgunDisabled = true

function ENT:Initialize()

	self:SetModel("models/pony_heads/rainbowdash_head.mdl")

	self:SetHealth(2147483647)

	self:SetFlexWeight(self:GetFlexIDByName("r_sad"), 1)
	self:SetFlexWeight(self:GetFlexIDByName("eye_closer_left"), 1)
	self:SetFlexWeight(self:GetFlexIDByName("jaw_open"), .43)
	self:SetFlexWeight(self:GetFlexIDByName("mouth_S"), 1)

end

function ENT:RunBehaviour()

	self.loco:SetDesiredSpeed(0)

end

function ENT:AcceptInput(name, activator, caller, data)

	if name == "Enable" then

		self.do_not_draw = false

	elseif name == "Disable" then

		self.do_not_draw = true

	end

	return true

end

function ENT:KeyValue(k, v)

	if string.Left(k, 2) == "On" then

		self:StoreOutput(k, v)

	elseif k == "StartDisabled" then

		self.do_not_draw = tobool(v)

	end

end

function ENT:Draw()

	if not self.do_not_draw then
		self:DrawModel()
	end

end

function ENT:OnInjured(info)

	info:SetDamage(0)

end

function ENT:Think()

	if self.do_not_draw then return end

	local last_eye_target

	for _, cam in pairs(ents.FindByClass("fnafgm_camera")) do

		if !last_eye_target or cam:GetPos():Distance(self:GetPos()) < last_eye_target:Distance(self:GetPos()) then

			last_eye_target = cam:GetPos()

		end

	end

	if last_eye_target then

		self:SetEyeTarget(last_eye_target)

	end

end

function ENT:CanTool(ply, trace, mode)

	return !GAMEMODE.IsFNAFGMDerived

end

function ENT:CanProperty(ply, property)

	return !GAMEMODE.IsFNAFGMDerived

end
