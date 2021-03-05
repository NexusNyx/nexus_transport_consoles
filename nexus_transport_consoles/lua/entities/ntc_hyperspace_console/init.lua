AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/kingpommes/starwars/misc/bridge_console4.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()

	phys:Wake()
end

function ENT:Use( activator )
	if NTC.Operators[team.GetName(activator:Team())] then
		net.Start("NTC_Hyperspace")
		net.Send(activator)
	end
end