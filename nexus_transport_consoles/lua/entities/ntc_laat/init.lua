AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

util.AddNetworkString("NTC_LAAT")

function ENT:Initialize()
	self:SetModel( "models/blu/laat.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()

	phys:Wake()
	self:EmitSound( "lfs/laat/loop.wav", 75 )
end

function ENT:Use( activator )
	if NTC.Operators[team.GetName(activator:Team())] then
		net.Start("NTC_LAAT")
		net.Send(activator)
	end
end

function ENT:OnRemove()
	self:StopSound( "lfs/laat/loop.wav" )
end